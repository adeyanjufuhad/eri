# Eri (Android app)

Reads bank alerts on the vendor's own Android phone, logs real sales, and catches fake "I've paid" claims.
Android only (`minSdk 24`). See `../CLAUDE.md` and `../docs/PLAN.md`.

## Run

```sh
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # drift database code (lib/data/db.g.dart)
flutter run                                                # on a real phone for notification features
flutter test                                               # parser + money unit tests
```

Testing on a phone: follow `../docs/SPIKE.md`.

**Browser preview (screens only, no alert listener):** `flutter build web`, then start `app-web` from `../.claude/launch.json`
(serves `build/web` on :8090). Use **Alert log → Simulate alert** to add synthetic alerts. `web/sqlite3.wasm` and
`web/drift_worker.js` come from drift's `drift-2.35.4` GitHub release; update them together with the drift version.

## Layout

```
android/.../EriNotificationListener.kt  native listener: keeps money-looking notifications, queues them on the phone
android/.../MainActivity.kt             MethodChannel eri/notifications + EventChannel eri/notifications/ping
lib/listener/                           Dart bridge + ingest (hash → store raw on device → parse → bank event)
lib/parsing/bank_alert.dart             deterministic alert parser (amount, direction, sender, note, session ID)
lib/data/db.dart                        drift tables: raw_notifications (device only, 7 days), bank_events
lib/features/                           welcome (permission), home (today), alert log (debug)
lib/theme/eri_theme.dart                tokens from docs/DESIGN.md
```

## Rules that matter here

- Money is integer **kobo** everywhere; `naira()` formats it only in widgets.
- Raw notification text never leaves the phone. Only parsed fields + `raw_hash` will sync (Day 2).
- No LLM in the parser. Fuzzy narration matching gets an LLM fallback later, through a Supabase Edge Function.
