# Acceptance Criteria: Item Details

## Purpose

Define the acceptance-level behavior for the public Item details experience.

This document validates that the details page behaves correctly with respect to:
- publication rules
- public-safe rendering
- approved review visibility
- review pagination
- auth-aware contribution entry point

---

## Scope

Covered:
- details route by slug
- published Item visibility
- draft Item invisibility
- public-safe details rendering
- approved review rendering
- review pagination
- login-aware review submission entry point

Not covered:
- related item recommendations
- map rendering
- advanced media galleries
- editorial modules

---

## Acceptance criteria

### AC-item-details-001
Anonymous user can open a published Item details page by slug.

### AC-item-details-002
Authenticated public user can open the same published Item details page.

### AC-item-details-003
Details page renders full public-safe Item information.

### AC-item-details-004
Details page renders location metadata and tags.

### AC-item-details-005
Details page renders review summary values derived from approved reviews only.

### AC-item-details-006
Details page shows approved reviews only.

### AC-item-details-007
Pending reviews are not visible on public item page.

### AC-item-details-008
Declined reviews are not visible on public item page.

### AC-item-details-009
Review list pagination works.

### AC-item-details-010
If Item slug does not exist, page returns not found behavior.

### AC-item-details-011
If Item exists but is not `PUBLISHED`, public details behavior remains unavailable.

### AC-item-details-012
If authenticated user opens the page, review submission entry point is available.

### AC-item-details-013
If anonymous user opens the page, review submission requires auth flow.

### AC-item-details-014
If there are no approved reviews yet, the page remains usable and shows appropriate empty review state.

---

## Evidence expectations

### Backend evidence
- item details by slug success test passes
- item details not found test passes
- hidden draft item test passes
- approved-only review visibility test passes
- review pagination test passes

### Frontend evidence
- item details page render test passes
- empty state handling test passes
- login-aware review form entry behavior is testable

### Manual evidence
- open seeded published Item
- verify approved reviews appear
- verify pending/declined seeded reviews do not appear
- verify draft Item slug is not publicly usable
