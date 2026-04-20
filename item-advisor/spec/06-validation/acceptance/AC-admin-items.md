# Acceptance Criteria: Admin Items

## Purpose

Define the acceptance-level behavior for manager Item CRUD workflows in the admin context.

This document validates that the manager can operate on canonical Item records and that public visibility updates remain coherent.

---

## Scope

Covered:
- admin item listing
- pagination and filtering
- create Item
- read Item for edit
- update Item
- delete Item
- publication status changes
- projection refresh impact on public side

Not covered:
- bulk actions
- editorial approval workflow
- version history
- advanced media management

---

## Acceptance criteria

### AC-admin-items-001
Authenticated manager can open admin items list.

### AC-admin-items-002
Admin items list supports pagination.

### AC-admin-items-003
Admin items list supports text query `q`.

### AC-admin-items-004
Admin items list supports status filter.

### AC-admin-items-005
Admin items list supports tag filter.

### AC-admin-items-006
Admin items list supports country filter.

### AC-admin-items-007
Admin items list supports region filter.

### AC-admin-items-008
Authenticated manager can create a new Item.

### AC-admin-items-009
Newly created Item is persisted in canonical collection.

### AC-admin-items-010
Authenticated manager can open an existing Item for edit.

### AC-admin-items-011
Authenticated manager can update Item fields.

### AC-admin-items-012
Authenticated manager can delete an Item.

### AC-admin-items-013
If Item is created or updated as `PUBLISHED`, corresponding public projections become available.

### AC-admin-items-014
If Item is changed to `DRAFT`, public projections become unavailable.

### AC-admin-items-015
If Item is deleted, public projections are removed.

### AC-admin-items-016
Slug uniqueness is enforced.

### AC-admin-items-017
Unauthenticated or non-manager caller cannot use admin Item CRUD routes.

### AC-admin-items-018
Public catalog reflects manager publication changes after projection refresh.

### AC-admin-items-019
Public item details reflect manager edits after projection refresh.

---

## Evidence expectations

### Backend evidence
- admin item create/update/delete tests pass
- filtering tests pass
- slug collision validation test passes
- projection refresh behavior tests pass

### Frontend evidence
- admin items page render test passes
- admin item create form render test passes
- admin item edit form render test passes

### Manual evidence
- create published Item and verify public visibility
- create draft Item and verify public invisibility
- change published Item to draft and verify disappearance
- edit Item text and verify public details update
