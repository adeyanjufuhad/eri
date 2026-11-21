# Eri

**Proof, not screenshots.**

Eri reads the bank alerts on an online vendor's Android phone, logs every real sale automatically, keeps stock and profit up to date, and catches fake "I've paid" claims before goods leave the shop.

*Ẹ̀rí* is Yoruba for proof, evidence, witness.

## Who it's for

Instagram, WhatsApp and TikTok vendors in Nigeria who ship goods after a customer sends a payment screenshot, and who lose track of sales, stock and profit across several bank apps.

## Status

Mavuly Hackathon 2026 entry. Build window: 23–29 November 2026.
Planning docs are in [`/docs`](docs). Code lands from 23 November.

- [7-day plan](docs/PLAN.md)
- [Data model](docs/DATA_MODEL.md)
- [Design system & landing page storyboard](docs/DESIGN.md)

## Privacy

Raw notification text never leaves the phone. Eri syncs only parsed fields (amount, time, counterparty, match), plus a hash for deduplication.

## Credits

Design/animation skills in `.claude/skills` by [Emil Kowalski](https://github.com/emilkowalski/skills) (MIT).
