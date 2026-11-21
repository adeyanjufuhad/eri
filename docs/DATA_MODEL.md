# Eri — Data Model

## Principles

- **Money is stored in kobo** as `bigint` (₦25,000 = `2500000`). Never floats.
- **Raw notification and chat text never leaves the phone.** The device parses it and syncs only structured fields plus a SHA-256 hash of the raw text (for dedupe).
- **On-device first:** the matching engine runs locally in Dart against a local SQLite (drift) copy. Supabase is the sync + multi-device + network layer.
- **Deterministic before AI:** the LLM is a fallback for fuzzy narration and for reading screenshots, never for arithmetic.
- **Row Level Security on every table:** a vendor only sees their own rows. The only cross-vendor table is `scam_fingerprints`, and it holds hashes only.

## Entity overview

```
vendors ─┬─ bank_accounts ── bank_events ──┬── matches ── orders ── order_items ── products
         │                                 ├── expenses                              │
         ├─ products ── stock_movements ───┘                                        │
         ├─ customers ── orders                                                      │
         ├─ payment_claims ── (matched) bank_events                                  │
         ├─ receipt_checks ── fingerprint_reports ── scam_fingerprints (shared)      │
         ├─ ignore_rules                                                             │
         └─ eri_scores, delivery_confirmations ──────────────────────────────────────┘
```

## Tables (Supabase Postgres)

```sql
-- Enums
create type direction as enum ('credit','debit');
create type parser_kind as enum ('template','llm','manual');
create type order_status as enum ('draft','awaiting_payment','paid','shipped','delivered','cancelled');
create type match_kind as enum ('order_code','expected_payment','narration','amount_combo','manual','not_sale');
create type stock_reason as enum ('restock','sale','adjustment','return');
create type expense_category as enum ('supplier','dispatch','ads','rent','data_airtime','other');
create type claim_source as enum ('whatsapp_preview','whatsapp_business_preview','instagram_preview','screenshot','manual');
create type claim_status as enum ('pending','verified','not_received','mismatch','expired');
create type verdict as enum ('landed','not_received','mismatch');
create type fingerprint_kind as enum ('image_phash','sender_name','phone','account_number');

create table vendors (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  business_name text not null,
  handle text unique,                       -- for the public Eri Score page: eri.app/@handle
  phone text,
  default_delivery_fee_kobo bigint default 0,
  created_at timestamptz default now()
);

create table bank_accounts (
  id uuid primary key default gen_random_uuid(),
  vendor_id uuid not null references vendors(id) on delete cascade,
  bank_name text not null,                  -- 'GTBank', 'OPay', 'Moniepoint', ...
  android_package text not null,            -- e.g. 'com.gtbank.gtworldv1' (verify on device)
  account_last4 text,
  active boolean default true
);

create table products (
  id uuid primary key default gen_random_uuid(),
  vendor_id uuid not null references vendors(id) on delete cascade,
  name text not null,
  aliases text[] default '{}',              -- 'gown', 'ankara', 'the blue gown'
  sell_price_kobo bigint not null,
  avg_cost_kobo bigint not null,            -- moving average, updated on restock
  qty_on_hand int not null default 0,
  low_stock_threshold int default 2,
  active boolean default true,
  created_at timestamptz default now()
);

create table stock_movements (
  id uuid primary key default gen_random_uuid(),
  product_id uuid not null references products(id) on delete cascade,
  delta int not null,                       -- +5 restock, -1 sale
  reason stock_reason not null,
  unit_cost_kobo bigint,                    -- for restocks
  order_id uuid,
  created_at timestamptz default now()
);

create table customers (
  id uuid primary key default gen_random_uuid(),
  vendor_id uuid not null references vendors(id) on delete cascade,
  display_name text not null,
  normalized_name text not null,            -- 'CHIOMA OKAFOR' → 'chioma okafor'
  phone_hash text,                          -- sha256(salt + E.164 phone)
  created_at timestamptz default now()
);

create table orders (
  id uuid primary key default gen_random_uuid(),
  vendor_id uuid not null references vendors(id) on delete cascade,
  customer_id uuid references customers(id),
  code text not null,                       -- 'ERI-482', unique per vendor
  status order_status not null default 'draft',
  expected_amount_kobo bigint,
  delivery_fee_kobo bigint default 0,
  created_at timestamptz default now(),
  paid_at timestamptz,
  unique (vendor_id, code)
);

create table order_items (
  order_id uuid references orders(id) on delete cascade,
  product_id uuid references products(id),
  qty int not null,
  unit_price_kobo bigint not null,
  unit_cost_kobo bigint not null,           -- snapshot at time of sale → profit is stable
  primary key (order_id, product_id)
);

create table bank_events (
  id uuid primary key default gen_random_uuid(),
  vendor_id uuid not null references vendors(id) on delete cascade,
  bank_account_id uuid references bank_accounts(id),
  direction direction not null,
  amount_kobo bigint not null,
  counterparty_name text,
  narration text,
  session_id text,
  occurred_at timestamptz not null,
  raw_hash text not null,                   -- sha256(raw notification text); raw text stays on device
  parser parser_kind not null,
  parse_confidence real,
  created_at timestamptz default now(),
  unique (vendor_id, raw_hash)              -- dedupe repeated notifications
);

create table matches (
  id uuid primary key default gen_random_uuid(),
  bank_event_id uuid not null unique references bank_events(id) on delete cascade,
  order_id uuid references orders(id),
  kind match_kind not null,
  confidence real not null,                 -- 1.0 for order codes
  confirmed_by_user boolean default false,
  created_at timestamptz default now()
);

create table expenses (
  id uuid primary key default gen_random_uuid(),
  vendor_id uuid not null references vendors(id) on delete cascade,
  bank_event_id uuid unique references bank_events(id),
  category expense_category not null,
  amount_kobo bigint not null,
  note text,
  occurred_at timestamptz not null
);

create table ignore_rules (                 -- "always ignore money from my brother"
  id uuid primary key default gen_random_uuid(),
  vendor_id uuid not null references vendors(id) on delete cascade,
  counterparty_normalized text not null
);

create table payment_claims (
  id uuid primary key default gen_random_uuid(),
  vendor_id uuid not null references vendors(id) on delete cascade,
  customer_id uuid references customers(id),
  source claim_source not null,
  claimed_amount_kobo bigint,               -- null if the message didn't state one
  claimed_at timestamptz not null,
  status claim_status not null default 'pending',
  matched_bank_event_id uuid references bank_events(id),
  expires_at timestamptz not null           -- claimed_at + wait window (default 10 min)
);

create table receipt_checks (
  id uuid primary key default gen_random_uuid(),
  vendor_id uuid not null references vendors(id) on delete cascade,
  image_phash text not null,
  extracted jsonb not null,                 -- {amount_kobo, sender, bank, time, session_id}
  result verdict not null,
  reasons text[] default '{}',              -- ['No matching credit in last 2h', 'Amount is ₦4,500 not ₦45,000']
  matched_bank_event_id uuid references bank_events(id),
  created_at timestamptz default now()
);

-- Shared Canary network: hashes only, no raw personal data
create table scam_fingerprints (
  id uuid primary key default gen_random_uuid(),
  kind fingerprint_kind not null,
  value_hash text not null,
  report_count int not null default 1,
  first_seen timestamptz default now(),
  last_seen timestamptz default now(),
  unique (kind, value_hash)
);

create table fingerprint_reports (
  fingerprint_id uuid references scam_fingerprints(id) on delete cascade,
  vendor_id uuid references vendors(id) on delete cascade,
  receipt_check_id uuid references receipt_checks(id),
  created_at timestamptz default now(),
  primary key (fingerprint_id, vendor_id)   -- one vendor can't inflate a count
);

create table delivery_confirmations (
  order_id uuid primary key references orders(id) on delete cascade,
  token text not null unique,               -- one-time link sent to the buyer
  confirmed_at timestamptz
);

-- Eri Score (stretch): computed by a scheduled function, read by the public page
create table eri_scores (
  vendor_id uuid primary key references vendors(id) on delete cascade,
  verified_paid_orders int default 0,
  confirmed_deliveries int default 0,
  disputes int default 0,
  selling_since date,
  updated_at timestamptz default now()
);
```

## Views

```sql
create view daily_pnl as
select
  o.vendor_id,
  date_trunc('day', o.paid_at) as day,
  sum(oi.qty * oi.unit_price_kobo) as sales_kobo,
  sum(oi.qty * oi.unit_cost_kobo)  as cogs_kobo,
  sum(oi.qty * (oi.unit_price_kobo - oi.unit_cost_kobo)) as gross_profit_kobo
from orders o join order_items oi on oi.order_id = o.id
where o.status in ('paid','shipped','delivered')
group by 1, 2;
-- Net profit = gross_profit − sum(expenses) for the same day (join in the app or a second view).
```

## On-device only (drift / SQLite, never synced)

| Table | Holds |
|---|---|
| `raw_notifications` | package, title, text, posted_at, raw_hash. Auto-deleted after 7 days. |
| `chat_previews` | app, sender display name, preview text, posted_at. Only rows that match payment phrases are kept, for 24h max. |
| `parser_templates` | per-bank regexes, versioned, updatable from Supabase |

## Matching engine (Dart, on-device)

```
on credit bank_event E:
  if E.counterparty in ignore_rules → done (not a sale)
  1. order code: /ERI-\d{3,5}/ in E.narration            → match(order, conf 1.0)
  2. expected payment: open order with expected_amount == E.amount
       and fuzzy(customer.name, E.counterparty) > 0.8      → match(order, conf 0.95)
  3. narration → product: alias/fuzzy match score > 0.75  → create order, match(conf 0.85)
       else if narration present → LLM classify (conf from model, cap 0.8)
  4. amount → product combo: solve sum(qty_i × price_i) + delivery ∈ {E.amount}
       (bounded search, ≤3 products, ≤5 units) unique solution → conf 0.7
  5. otherwise → one-tap confirm card
  on match: decrement stock (stock_movements), snapshot unit_cost, mark order paid,
            resolve any pending payment_claim for this customer.

on debit bank_event D:
  classify → expense (rules by counterparty name first, then LLM), ask once if unsure.

every minute:
  pending payment_claims past expires_at with no match → status 'not_received' → warn vendor.
```
