# FEAT-admin-review-moderation

## Purpose

Allow a manager to inspect submitted reviews and decide whether each review should become publicly visible.

This feature is central to the trust and quality boundary of the MVP.

A review is submitted by a user, but it does not become public immediately.
It first enters moderation.

---

## Scope

### Included
- admin reviews listing
- filtering reviews by moderation status
- opening review details
- approve action
- decline action
- mandatory decline reason
- optional manager comment
- persistence of moderation metadata
- refresh of affected public aggregates after moderation

### Excluded
- bulk moderation actions
- moderation history timeline
- audit dashboard beyond essential fields
- moderation assignment workflow
- notifications to users

---

## Actors

- Manager

---

## Entry points

### Admin UI
- `UI-admin-reviews-list-page`
- `UI-admin-review-details-page`

### Admin API
- `API-admin-reviews-list`
- `API-admin-review-details`
- `API-admin-review-approve`
- `API-admin-review-decline`

---

## User-facing behavior

### Reviews list
Manager opens the admin reviews page and sees a list of submitted reviews.

The list supports:
- pagination
- status filtering
- optional item-based filtering
- optional text query as supported in MVP

### Review details
Manager opens an individual review and inspects:
- review text
- rating
- uploaded photos
- item summary
- review author information if surfaced
- current moderation state

### Approve action
Manager approves a pending review.

System behavior:
- review status becomes `APPROVED`
- `moderated_at` is set
- `moderated_by` is set
- optional `manager_comment` may be stored
- public aggregates for the related Item are refreshed
- review becomes visible on public item page

### Decline action
Manager declines a pending review.

System behavior:
- review status becomes `DECLINED`
- non-empty `decline_reason` is mandatory
- `moderated_at` is set
- `moderated_by` is set
- optional `manager_comment` may be stored
- public aggregates are refreshed if needed
- review remains hidden from public item page
- review appears in user cabinet with decline information

---

## Business rules

- `RULE-review-002`: only APPROVED reviews are public
- `RULE-review-003`: manager may approve pending review
- `RULE-review-004`: manager may decline pending review
- `RULE-review-005`: decline requires non-empty decline_reason
- `RULE-review-006`: manager_comment is optional
- `RULE-review-007`: moderation sets moderated_at
- `RULE-review-008`: moderation sets moderated_by
- `RULE-review-010`: user cabinet shows moderation result fields
- `RULE-readmodel-006`: moderation refreshes public aggregates when affected
- `RULE-readmodel-008`: only APPROVED reviews affect public rating aggregates

---

## Backend contracts

### API-admin-reviews-list
Returns paginated review list with filter support.

### API-admin-review-details
Returns full moderation-relevant view for a single review.

### API-admin-review-approve
Request:
- optional manager_comment

Effect:
- status -> APPROVED
- moderation metadata updated
- read-model / aggregate sync triggered

### API-admin-review-decline
Request:
- required decline_reason
- optional manager_comment

Effect:
- status -> DECLINED
- moderation metadata updated
- related public-facing aggregates refreshed as required

---

## Data impact

### Canonical collection
- `DATA-reviews`

### Fields modified
- status
- manager_comment
- decline_reason
- moderated_at
- moderated_by

### Read-model impact
This feature affects public item aggregate fields, such as:
- approved_reviews_count
- average_rating

---

## UI impact

### frontend-admin
- reviews list page
- review details page
- approve action control
- decline action control
- required textarea for decline reason
- success/error feedback states

### frontend-site
Indirect impact only:
- approved review may appear on item page
- user cabinet may show updated moderation state

---

## Error cases

- manager tries to decline without decline_reason
- review not found
- review already moderated in incompatible way
- missing or invalid manager token
- aggregate sync failure after moderation

---

## Validation

### Acceptance references
- `AC-admin-moderation`
- `AC-reviews`

### Tests
- `TEST-admin-review-list-pending`
- `TEST-admin-review-approve-success`
- `TEST-admin-review-decline-success`
- `TEST-admin-review-decline-requires-reason`
- `TEST-admin-review-moderation-sets-fields`
- `TEST-public-aggregates-refresh-after-approve`
- `TEST-public-item-page-shows-only-approved-reviews`
- `TEST-user-cabinet-shows-decline-reason`

---

## Related documents

- `FEAT-review-submit`
- `FEAT-user-cabinet`
- `XCUT-read-model-sync`
- `ADR-003-canonical-vs-read-model`
- `SLICE-007-review-moderation`

---

## Future extensions

Potential later evolution:
- bulk approve / decline
- moderation queue prioritization
- moderation notes history
- abuse flags
- manager workload metrics
