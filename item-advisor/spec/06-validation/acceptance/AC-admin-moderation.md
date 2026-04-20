# Acceptance Criteria: Admin Review Moderation

## Purpose

Define the acceptance-level behavior for manager review moderation in ItemAdvisor MVP.

This document validates that the moderation flow is operationally correct and correctly connected to public-facing outcomes.

---

## Scope

Covered:
- admin review listing
- admin review details
- approve action
- decline action
- required decline reason
- moderation metadata
- public aggregate refresh
- user cabinet reflection of moderation result

Not covered:
- bulk moderation
- notifications
- moderation analytics
- moderation audit history beyond essential stored fields

---

## Acceptance criteria

### AC-admin-moderation-001
Authenticated manager can open admin reviews listing.

### AC-admin-moderation-002
Admin reviews listing supports status-based filtering.

### AC-admin-moderation-003
Authenticated manager can open a single review details page.

### AC-admin-moderation-004
Manager can approve a pending review.

### AC-admin-moderation-005
Approving a review changes its status to `APPROVED`.

### AC-admin-moderation-006
Approving a review sets `moderated_at`.

### AC-admin-moderation-007
Approving a review sets `moderated_by`.

### AC-admin-moderation-008
Approved review becomes eligible for public visibility.

### AC-admin-moderation-009
Manager can decline a pending review.

### AC-admin-moderation-010
Declining a review without `decline_reason` is rejected.

### AC-admin-moderation-011
Declining a review with valid `decline_reason` changes status to `DECLINED`.

### AC-admin-moderation-012
Declining a review sets `moderated_at`.

### AC-admin-moderation-013
Declining a review sets `moderated_by`.

### AC-admin-moderation-014
Declined review remains hidden from public review list.

### AC-admin-moderation-015
Review moderation refreshes affected public aggregate values for the related Item.

### AC-admin-moderation-016
User cabinet reflects the resulting moderation status.

### AC-admin-moderation-017
If a review was declined, user cabinet shows decline reason.

### AC-admin-moderation-018
Unauthenticated or non-manager caller cannot perform moderation actions.

---

## Evidence expectations

### Backend evidence
- pending review list test passes
- approve test passes
- decline test passes
- decline-requires-reason test passes
- moderation fields test passes
- aggregate refresh test passes

### Frontend evidence
- admin moderation page renders
- review details page renders
- approve action UI is wired
- decline action UI enforces required reason input

### Manual evidence
- approve seeded pending review and observe public impact
- decline seeded pending review and observe cabinet impact
- verify manager-only protection

---

## Related documents

- `FEAT-admin-review-moderation`
- `FEAT-review-submit`
- `FEAT-user-cabinet`
- `XCUT-read-model-sync`
- `SLICE-007-review-moderation`
- `ADR-003-canonical-vs-read-model`
