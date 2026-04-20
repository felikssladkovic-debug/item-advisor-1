# Acceptance Criteria: Reviews

## Purpose

Define acceptance-level behavior for the end-to-end review flow in ItemAdvisor MVP.

This includes:
- review submission
- moderation lifecycle visibility
- public review visibility rules
- cabinet visibility rules

---

## Scope

Covered:
- authenticated review submission
- optional review photo upload
- pending status after submission
- public visibility only after approval
- user cabinet visibility
- decline reason visibility
- aggregate update relevance

Not covered:
- editing reviews
- deleting reviews
- notifications
- moderation history timeline
- abuse reporting

---

## Acceptance criteria

### AC-reviews-001
Authenticated user can submit a review for a published Item.

### AC-reviews-002
Unauthenticated user cannot submit a review through protected flow.

### AC-reviews-003
A newly submitted review is stored with status `PENDING`.

### AC-reviews-004
Review submission supports rating and text.

### AC-reviews-005
Review submission supports optional photo upload.

### AC-reviews-006
Review submission rejects more than 3 photos.

### AC-reviews-007
Review submission rejects non-image files.

### AC-reviews-008
A `PENDING` review is not visible in public review list.

### AC-reviews-009
An `APPROVED` review becomes visible in public review list.

### AC-reviews-010
A `DECLINED` review is not visible in public review list.

### AC-reviews-011
Authenticated user cabinet shows submitted review regardless of moderation status.

### AC-reviews-012
If review was declined, cabinet shows decline reason.

### AC-reviews-013
If manager comment exists, cabinet shows manager comment.

### AC-reviews-014
Only approved reviews affect public aggregate values.

### AC-reviews-015
Approved review count and average rating stay consistent after moderation actions.

---

## Evidence expectations

### Backend evidence
- review submit success test passes
- pending status test passes
- auth-required submit test passes
- image validation tests pass
- public review visibility tests pass
- aggregate refresh tests pass

### Frontend evidence
- item page review form render test passes
- cabinet render test passes
- moderation outcome display test passes where applicable

### Manual evidence
- submit review as seeded user
- verify it appears in cabinet as `PENDING`
- approve it as manager and verify public visibility
- decline another review and verify cabinet decline reason

---

## Related documents

- `FEAT-review-submit`
- `FEAT-user-cabinet`
- `FEAT-admin-review-moderation`
- `AC-admin-moderation`
- `XCUT-read-model-sync`
