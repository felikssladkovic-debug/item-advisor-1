# FEAT-item-details

## Purpose

Provide a public details page for one published Item.

This feature is the second half of the core discovery flow after the public catalog.
It allows a user to move from summary-level browsing to full contextual inspection of an Item.

The item details page is also the main entry point for review reading and review submission.

---

## Scope

### Included
- public item details route
- item lookup by slug
- full public-safe Item details rendering
- location and tag display
- hero image display when present
- approved review summary values
- latest approved reviews display
- pagination support for approved reviews
- auth-aware display of review submission form

### Excluded
- related Items recommendations
- editorial timelines
- maps
- complex media galleries
- Item bookmarking
- personalized ranking
- advanced structured metadata beyond MVP fields

---

## Actors

- Anonymous user
- Authenticated user

---

## Entry points

### UI
- `UI-site-item-details-page`

### API
- `API-public-item-details`
- `API-public-item-reviews-list`

---

## User-facing behavior

User opens `/items/:slug`.

If the slug belongs to a published Item:
- item details page is rendered
- full public-safe description is shown
- metadata is shown
- approved review summary is shown
- latest approved reviews are shown
- pagination for reviews is available

If user is authenticated:
- review submission form is visible

If user is anonymous:
- page remains readable
- review submission requires login flow

If slug does not resolve to a published Item:
- user receives not found behavior

---

## Business rules

- `RULE-public-003`: public item details must only be available for `PUBLISHED` Items
- `RULE-public-004`: public API must not expose admin-only fields
- `RULE-review-002`: only `APPROVED` reviews are visible publicly
- `RULE-readmodel-002`: public API reads from public read-model collections
- `RULE-readmodel-007`: only `PUBLISHED` Items may exist in public read-model collections
- `RULE-readmodel-008`: only `APPROVED` reviews affect public aggregates

---

## Backend contracts

### API-public-item-details
Endpoint:
- `GET /api/v1/items/{slug}`

Response includes:
- item details projection
- public aggregate summary
- latest approved reviews
- review pagination metadata

### API-public-item-reviews-list
Endpoint:
- `GET /api/v1/items/{slug}/reviews`

Query params:
- `page`
- `page_size`

Response includes:
- approved reviews only
- pagination metadata

---

## Data impact

### Read model
- `DATA-public_item_details`

### Canonical dependencies
- `DATA-items`
- `DATA-reviews`

### Aggregate dependencies
- approved review count
- average rating

The item details endpoint should primarily rely on public details projection and public-safe review query behavior.

---

## UI impact

### frontend-site
- item details page
- review list block
- review summary block
- login-aware review form entry point
- loading state
- error state
- not found state

### frontend-admin
No direct UI impact.

---

## States

### Happy state
Published Item details and approved reviews render correctly.

### Empty review state
Item exists but no approved reviews are available yet.

### Loading state
Page indicates data fetch in progress.

### Error state
Page indicates request failure.

### Not found state
Slug does not resolve to a published Item.

---

## Error cases

- slug not found
- Item exists but is not published
- read-model inconsistency
- approved review query failure
- malformed pagination params

---

## Validation

### Acceptance references
- `AC-item-details`
- `AC-reviews`

### Tests
- `TEST-item-details-renders-published-item`
- `TEST-item-details-by-slug-not-found`
- `TEST-item-details-hides-draft-item`
- `TEST-item-details-shows-approved-reviews-only`
- `TEST-item-details-review-pagination`
- `TEST-ui-item-details-renders`

---

## Related documents

- `FEAT-public-catalog`
- `FEAT-review-submit`
- `XCUT-read-model-sync`
- `SLICE-004-item-details`
- `ADR-003-canonical-vs-read-model`

---

## Future extensions

Potential later evolution:
- related items
- recommendation blocks
- media gallery
- map widget
- structured folklore / tradition sections
- editorial annotations
