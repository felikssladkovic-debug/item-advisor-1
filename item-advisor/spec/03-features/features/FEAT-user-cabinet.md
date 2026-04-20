# FEAT-user-cabinet

## Purpose

Provide an authenticated user with a personal area where they can inspect the reviews they have submitted and see moderation outcomes.

This feature closes the loop of the review contribution flow.
Without it, the user submits content but has no transparent visibility into what happened afterward.

---

## Scope

### Included
- protected cabinet route
- current user's reviews listing
- newest-first ordering
- display of related Item summary
- display of rating and review text
- display of moderation status
- display of manager comment when present
- display of decline reason when present
- display of created_at

### Excluded
- editing submitted review
- deleting submitted review
- cabinet profile management
- notification center
- account settings
- favorites / bookmarks

---

## Actors

- Authenticated user

---

## Entry points

### UI
- `UI-site-cabinet-page`
- header link to cabinet

### API
- `API-public-reviews-my`

---

## User-facing behavior

Authenticated user opens `/cabinet`.

The page shows a list of the current user's reviews sorted newest first.

For each review, the page shows:
- related Item title or summary
- rating
- review text
- review status
- manager comment if available
- decline reason if available
- created_at

The user can inspect whether each review is:
- `PENDING`
- `APPROVED`
- `DECLINED`

If the review was declined, the cabinet explains the reason through decline metadata.

If the user is not authenticated:
- access is blocked
- user is redirected or rejected according to UI auth behavior

---

## Business rules

- `RULE-review-009`: user cabinet displays all reviews submitted by that user
- `RULE-review-010`: cabinet shows moderation result fields when available
- `RULE-auth-004`: protected public routes require authenticated user
- `RULE-review-001`: newly submitted review starts as `PENDING`

---

## Backend contracts

### API-public-reviews-my
Endpoint:
- `GET /api/v1/reviews/my`

Behavior:
- returns only current authenticated user's reviews
- sorted newest first
- includes Item summary sufficient for cabinet display
- includes status and moderation fields

### Authentication dependency
Requires valid authenticated public context.

---

## Data impact

### Canonical sources
- `DATA-reviews`
- `DATA-items`
- `DATA-users`

### Read-model dependency
Cabinet does not need to use public read-model collections as primary source.
It is a user-specific authenticated view over canonical user-owned review data.

---

## UI impact

### frontend-site
- cabinet page
- protected route
- list/table/card rendering of user reviews
- empty state
- loading state
- error state

### frontend-admin
No direct UI impact.

---

## States

### Happy state
Authenticated user sees own reviews and statuses.

### Empty state
Authenticated user has not submitted any reviews.

### Loading state
Page indicates cabinet data is being fetched.

### Error state
Page indicates fetch failure.

### Auth-blocked state
Unauthenticated visitor cannot use cabinet.

---

## Error cases

- missing token
- invalid token
- backend unavailable
- review-item join data incomplete
- partially missing moderation fields in inconsistent records

---

## Validation

### Acceptance references
- `AC-auth`
- `AC-reviews`

### Tests
- `TEST-user-cabinet-requires-auth`
- `TEST-user-cabinet-lists-current-user-reviews`
- `TEST-user-cabinet-sorts-newest-first`
- `TEST-user-cabinet-shows-pending-status`
- `TEST-user-cabinet-shows-approve-status`
- `TEST-user-cabinet-shows-decline-reason`
- `TEST-ui-cabinet-renders`

---

## Related documents

- `FEAT-review-submit`
- `FEAT-admin-review-moderation`
- `XCUT-authz`
- `SLICE-005-user-reviews`

---

## Future extensions

Potential later evolution:
- edit pending review
- delete own pending review
- account preferences
- submission notifications
- moderation history timeline
