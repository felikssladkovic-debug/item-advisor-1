# XCUT-read-model-sync

## Purpose

Define how public read-model collections are synchronized from canonical data.

This is a cross-cutting concern because it affects:

- admin item CRUD
- review moderation
- startup seed logic
- public catalog correctness
- public item details correctness
- public aggregate correctness

---

## Problem statement

ItemAdvisor intentionally separates:

- canonical operational collections
- public read-optimized collections

This means the system must maintain projection coherence.

Without explicit synchronization rules, the public site can drift away from canonical truth.

---

## Canonical sources

### Items
Canonical source for:
- slug
- title
- descriptions
- location fields
- tags
- publication status
- hero image URL
- timestamps

### Reviews
Canonical source for:
- rating
- moderation status
- relation to Item
- public aggregate contribution eligibility

### Users
Users do not directly project into public catalog/details projections, but participate indirectly through review ownership.

---

## Target projections

### public_item_cards
Purpose:
- optimized public catalog rendering

Contains:
- public-safe item summary
- rating aggregates based only on approved reviews

### public_item_details
Purpose:
- optimized public item details rendering

Contains:
- public-safe item full details
- rating aggregates based only on approved reviews

---

## Projection rules

### Projection rule 1
Only `PUBLISHED` Items may appear in `public_item_cards`.

### Projection rule 2
Only `PUBLISHED` Items may appear in `public_item_details`.

### Projection rule 3
Only `APPROVED` Reviews contribute to:
- approved reviews count
- average rating

### Projection rule 4
`DRAFT` Items must be absent from public projections.

### Projection rule 5
Deleted Items must be absent from public projections.

### Projection rule 6
Projection payload must not contain admin-only fields.

---

## Synchronization triggers

Synchronization must run after:

- item create
- item update
- item delete
- item publication status change
- review approval
- review decline if aggregate refresh is needed
- startup seed initialization / rebuild when baseline data exists or changes

---

## Synchronization granularity

Preferred MVP strategy:
- synchronize only affected Item projections when practical
- allow rebuild of all projections during startup or repair paths

This balances simplicity and correctness.

---

## Sync behavior by case

### Case: item created as DRAFT
Result:
- canonical item exists
- no public projection exists

### Case: item created as PUBLISHED
Result:
- canonical item exists
- card projection created
- details projection created
- review aggregates initialized from approved reviews only

### Case: item updated while PUBLISHED
Result:
- existing card/details projections updated

### Case: item changed from PUBLISHED to DRAFT
Result:
- public projections removed

### Case: item changed from DRAFT to PUBLISHED
Result:
- public projections created

### Case: item deleted
Result:
- public projections removed

### Case: review approved
Result:
- related Item aggregates refreshed
- approved review count and average rating may change

### Case: review declined
Result:
- declined review remains absent from public review list
- aggregates refreshed if necessary to preserve correctness

---

## Consistency strategy

### MVP consistency model
For MVP, strong-enough immediate consistency through synchronous in-process refresh is acceptable.

### Why acceptable
- simpler runtime
- easier local development
- easier debugging
- sufficient for MVP scale

### Why still important
Even in MVP, sync logic must be explicit, reusable, and testable.

---

## Failure handling expectations

If projection refresh fails after a write, the system must not silently ignore the failure.

Preferred MVP behavior:
- fail loudly
- log clearly
- make inconsistency visible during development/testing

Silent projection drift is worse than a visible failure.

---

## Validation expectations

The following behaviors must be tested:

- published Items appear in catalog
- draft Items do not appear in catalog
- item details projection matches published Item state
- approved review changes aggregate values
- declined review does not become public
- projection rebuild works on startup for seeded data

---

## Document dependencies

This cross-cutting concern is referenced by:

- `FEAT-public-catalog`
- `FEAT-item-details`
- `FEAT-admin-item-crud`
- `FEAT-admin-review-moderation`
- `SLICE-001-bootstrap`
- `ADR-003-canonical-vs-read-model`

---

## Future evolution

Possible future enhancements:
- background projection worker
- event-driven projection updates
- outbox pattern
- projection repair jobs
- projection versioning
- cache layer on top of projections
