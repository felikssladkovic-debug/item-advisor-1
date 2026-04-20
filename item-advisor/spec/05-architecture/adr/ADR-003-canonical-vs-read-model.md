# ADR-003: Separate canonical collections from public read-model collections

## Status

Accepted

---

## Context

ItemAdvisor has two clearly different operational contexts:

1. admin management and moderation workflows
2. public website rendering workflows

These contexts differ in both access patterns and security expectations.

Admin workflows need:
- canonical item data
- moderation fields
- management filters
- write access

Public workflows need:
- render-optimized item data
- safe exposure without admin-only fields
- catalog and details projections
- aggregate values derived from approved reviews

The MVP could theoretically read everything directly from canonical collections, but this would create tighter coupling between admin data shape and public delivery shape.

Because the project is intended to grow beyond a toy scaffold, a cleaner separation is preferred already in MVP.

---

## Decision

Use two data layers inside the same MongoDB database:

### Canonical collections
Primary operational data owned by admin and system write workflows.

Initial canonical collections:
- `items`
- `users`
- `reviews`

### Public read-model collections
Projection collections optimized for public site rendering.

Initial public read-model collections:
- `public_item_cards`
- `public_item_details`

Admin API owns canonical item writes and review moderation actions.

Public API reads public item data from read-model collections and public review data from approved reviews only.

After relevant writes, synchronization logic refreshes affected public read-model records and aggregates.

---

## Decision details

### Item publication boundary
Only Items with status `PUBLISHED` are represented in public read-model collections.

### Review visibility boundary
Only reviews with status `APPROVED` are included in public-facing review lists and aggregate calculations.

### Synchronization triggers
Read-model synchronization must run after:
- item create
- item update
- item delete
- review moderation where public aggregates may change
- seed initialization / rebuild when required

### API boundary implication
Public API must not expose admin-only fields even if those fields exist in canonical collections.

---

## Alternatives considered

### Alternative A: public API reads canonical collections directly
Rejected.

Reason:
- easier initially
- but mixes public delivery concerns with admin data shape
- increases risk of accidental data exposure
- makes future optimization harder

### Alternative B: separate database for read-models
Rejected for MVP.

Reason:
- possible later evolution
- but operational overhead is unnecessary for MVP
- single MongoDB database is sufficient as long as code separation is clean

### Alternative C: compute public projections on every request
Rejected.

Reason:
- acceptable for tiny prototypes
- but weakens architectural clarity
- repeats logic on read path
- complicates future performance tuning

---

## Consequences

### Positive consequences
- cleaner separation between public and admin concerns
- safer public data exposure
- simpler public query paths
- easier future optimization for catalog/details rendering
- clearer alignment with scaling intent of project

### Negative consequences
- requires synchronization logic
- introduces possibility of drift if sync is broken
- adds some implementation complexity in MVP

---

## Operational consequences

The project must include:

- reusable read-model synchronization functions
- startup rebuild logic for seeded baseline
- tests proving aggregate refresh after moderation and item changes
- explicit documentation of which API reads which data layer

---

## Validation consequences

The following behaviors must be testable:

- public catalog shows only `PUBLISHED` items
- public item details use read-model data
- newly approved review changes public aggregates
- declined review does not become publicly visible
- deleted or unpublished item no longer appears in public catalog

---

## Follow-up notes

Possible future evolution:
- event-driven projection refresh
- outbox pattern
- separate projection workers
- separate physical storage or caching layers

For MVP, synchronous in-process update after relevant writes is acceptable as long as behavior is explicit and tested.
