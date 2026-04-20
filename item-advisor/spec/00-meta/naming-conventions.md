# Naming Conventions

## Purpose

This document defines naming rules for the ItemAdvisor spec repository.

The goal is to keep documents:

- easy to scan
- easy to reference
- easy to link in prompts
- easy to trace into implementation and validation

Consistency matters because this repository is meant to be read by:
- humans
- coding agents
- reviewers
- future maintainers

---

## General principles

### Principle 1
Prefer stable, explicit, low-ambiguity names.

### Principle 2
Use the same domain words everywhere unless a deliberate distinction exists.

### Principle 3
Prefer singular semantic identifiers for feature packets and architecture decisions.

### Principle 4
Document file names should reveal their role from the prefix.

---

## Directory-level naming

### Meta documents
Location:
- `spec/00-meta/`

Examples:
- `README.md`
- `naming-conventions.md`
- `traceability-rules.md`

### Conceptual documents
Location:
- `spec/01-conceptual/`

Format:
- numeric prefix + kebab-case title

Examples:
- `01-vision.md`
- `03-actors-and-goals.md`
- `04-domain-model.md`

Reason:
Conceptual docs are read in curated order.

### Delivery slice documents
Location:
- `spec/02-delivery/`

Format:
- numeric prefix + slice title

Examples:
- `00-roadmap.md`
- `01-slice-bootstrap.md`
- `02-slice-auth-foundation.md`

Reason:
Delivery docs are sequence-sensitive.

### Feature documents
Location:
- `spec/03-features/features/`

Format:
- `FEAT-<feature-name>.md`

Examples:
- `FEAT-auth-login.md`
- `FEAT-public-catalog.md`
- `FEAT-admin-item-crud.md`

### Cross-cutting documents
Location:
- `spec/03-features/cross-cutting/`

Format:
- `XCUT-<concern-name>.md`

Examples:
- `XCUT-authz.md`
- `XCUT-read-model-sync.md`
- `XCUT-static-file-serving.md`

### ADR documents
Location:
- `spec/05-architecture/adr/`

Format:
- `ADR-###-<decision-name>.md`

Examples:
- `ADR-003-canonical-vs-read-model.md`
- `ADR-005-jwt-auth.md`

### Acceptance documents
Location:
- `spec/06-validation/acceptance/`

Format:
- `AC-<area-name>.md`

Examples:
- `AC-auth.md`
- `AC-public-catalog.md`
- `AC-admin-items.md`

### BDD documents
Location:
- `spec/06-validation/bdd/`

Format:
- descriptive kebab-case `.feature`

Examples:
- `review-moderation.feature`
- `auth.feature`
- `catalog.feature`

### Prompt documents
Location:
- `spec/08-prompts/...`

Format:
- action-oriented kebab-case

Examples:
- `codex-build-mvp.md`
- `codex-add-feature-template.md`

---

## Identifier naming

### Feature identifiers
Format:
- `FEAT-<feature-name>`

Examples:
- `FEAT-auth-register`
- `FEAT-review-submit`

### Cross-cutting identifiers
Format:
- `XCUT-<concern-name>`

Examples:
- `XCUT-authz`
- `XCUT-read-model-sync`

### Business rule identifiers
Format:
- `RULE-<area>-###`

Examples:
- `RULE-auth-001`
- `RULE-review-005`
- `RULE-readmodel-007`

### API identifiers
Format:
- `API-<context>-<resource>-<action>`

Examples:
- `API-public-auth-login`
- `API-public-items-list`
- `API-admin-item-update`
- `API-admin-review-approve`

### UI identifiers
Format:
- `UI-<context>-<surface-name>`

Examples:
- `UI-site-login-page`
- `UI-site-catalog-page`
- `UI-admin-items-list-page`

### Data identifiers
Format:
- `DATA-<collection-or-model-name>`

Examples:
- `DATA-items`
- `DATA-reviews`
- `DATA-public_item_cards`

### Test identifiers
Format:
- `TEST-<area>-<behavior>`

Examples:
- `TEST-auth-login-success-user`
- `TEST-public-catalog-pagination`
- `TEST-admin-review-decline-requires-reason`

### Slice identifiers
Format:
- `SLICE-###-<slice-name>`

Examples:
- `SLICE-001-bootstrap`
- `SLICE-003-public-catalog`

### Change request identifiers
Format:
- `CR-YYYY-MM-DD-XXX`

Example:
- `CR-2026-04-20-001`

---

## File content naming conventions

### Headings
Use clear singular headings where possible.

Good:
- `## Purpose`
- `## Scope`
- `## Business rules`

Avoid:
- decorative headings
- vague headings such as `## Notes` unless truly needed

### Lists of rules
Always include full rule identifiers.

Good:
- `RULE-review-005: Declining a review requires non-empty decline_reason.`

### References
When referencing another document, use its identifier or file name explicitly.

Good:
- `Related documents: FEAT-review-submit, XCUT-authz, ADR-005-jwt-auth`

---

## Domain term conventions

Use these terms consistently:

- `Item` — product domain entity
- `Review` — user-submitted review
- `User` — authenticated end user or manager identity
- `Manager` — privileged internal operator role
- `public API` — backend-public-api context
- `admin API` — backend-admin-api context
- `public site` — frontend-site
- `admin panel` — frontend-admin
- `canonical collection` — operational source-of-truth data
- `public read-model` — public projection collection

Do not freely alternate these with synonyms unless a distinction is intentional.

---

## Casing rules

### In prose
Use:
- `Item`
- `Review`
- `User`
- `Manager`

when referring to domain concepts.

### In file names
Use kebab-case except where identifier prefixes require uppercase tokens like `FEAT-`, `ADR-`, `AC-`.

### In collection names
Use the exact persistence names used by the system design.

Examples:
- `items`
- `users`
- `reviews`
- `public_item_cards`
- `public_item_details`

---

## Final rule

If a new document name feels clever, shorten it and make it more explicit.

The spec repository should optimize for traceability, not literary style.
