# FEAT-review-submit

## Purpose

Allow an authenticated public user to submit a review for an Item.

This feature is the main contribution flow of the MVP.

A submitted review does not become public immediately.
It enters moderation first.

---

## Scope

### Included
- review submission from public item page
- authenticated-only access
- rating input
- text input
- optional photo upload
- validation of photo count and file type
- creation of canonical Review record
- initial status `PENDING`
- user feedback after submission

### Excluded
- edit own review after submission
- delete own review
- draft review saving
- rich text review editor
- photo reordering
- moderation notification delivery

---

## Actors

- Authenticated user

---

## Entry points

### UI
- `UI-site-item-details-page`
- review submission form shown for authenticated user

### API
- `API-public-review-create`

---

## User-facing behavior

Authenticated user opens a published Item details page.

The page shows a review submission form.

The form allows:
- choosing rating
- entering review text
- optionally uploading up to 3 photos

When user submits a valid review:
- system creates a canonical Review record
- review status is set to `PENDING`
- user receives success feedback
- review does not yet appear publicly unless later approved
- review becomes visible in user cabinet

If submission is invalid:
- user sees validation error feedback
- invalid files are rejected
- excessive photo count is rejected

If user is not authenticated:
- review submission is not allowed through protected flow

---

## Business rules

- `RULE-review-001`: newly submitted review starts as `PENDING`
- `RULE-photo-001`: photo upload is optional
- `RULE-photo-002`: review may contain at most 3 photos
- `RULE-photo-003`: only valid image files may be accepted
- `RULE-photo-004`: uploaded photos use local storage in MVP
- `RULE-photo-005`: uploaded photos become accessible through static URLs
- `RULE-auth-004`: protected public routes require authentication

---

## Backend contracts

### API-public-review-create
Endpoint:
- `POST /api/v1/reviews`

Supported payload:
- item_id
- rating
- text
- optional photos

Payload format may be JSON or multipart according to runtime implementation, but runtime behavior must support real file upload.

Effect:
- create canonical Review
- store uploaded photos when present
- return success response
- associate review with current authenticated user

---

## Data impact

### Canonical collection
- `DATA-reviews`

### Fields populated
- item_id
- user_id
- rating
- text
- photos
- status = `PENDING`
- created_at
- manager_comment = null
- decline_reason = null
- moderated_at = null
- moderated_by = null

### Storage impact
Uploaded image files are written to local review-photo storage.

---

## UI impact

### frontend-site
- review form on item details page
- auth-gated visibility
- submit action
- client-side validation assistance
- success/error messaging
- file picker / upload handling

### frontend-admin
No direct UI impact at submission moment, but submitted review later appears in moderation queue.

---

## Error cases

- unauthenticated user tries to submit
- item not found
- item is not publicly available
- invalid rating
- empty or invalid text according to validation rules
- too many uploaded photos
- non-image file upload
- file storage failure
- backend validation failure

---

## Validation

### Acceptance references
- `AC-reviews`
- `AC-auth`

### Tests
- `TEST-review-submit-authenticated-success`
- `TEST-review-submit-creates-pending-review`
- `TEST-review-submit-with-photo-success`
- `TEST-review-submit-rejects-too-many-photos`
- `TEST-review-submit-rejects-non-image-file`
- `TEST-review-submit-requires-auth`
- `TEST-user-cabinet-shows-submitted-review`

---

## Related documents

- `FEAT-item-details`
- `FEAT-user-cabinet`
- `FEAT-admin-review-moderation`
- `XCUT-static-file-serving`
- `SLICE-005-user-reviews`

---

## Future extensions

Potential later evolution:
- user edits pending review
- duplicate-review prevention rules
- per-Item contribution constraints
- moderation notifications
- asynchronous image processing
