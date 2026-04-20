# FEAT-admin-item-crud

## Purpose

Allow a manager to create, inspect, edit, and delete canonical Item records through the admin panel and admin API.

This feature is the core content-management workflow of the MVP.

It is also one of the main sources of change for public read-model synchronization.

---

## Scope

### Included
- admin items listing
- filters and pagination
- item details fetch for edit
- create Item
- update Item
- delete Item
- status field management (`DRAFT` / `PUBLISHED`)
- public read-model synchronization after relevant writes

### Excluded
- bulk item actions
- item version history
- item editorial approvals
- advanced media management
- soft delete recovery UI
- multilingual item editing

---

## Actors

- Manager

---

## Entry points

### UI
- `UI-admin-items-list-page`
- `UI-admin-item-create-page`
- `UI-admin-item-edit-page`

### API
- `API-admin-items-list`
- `API-admin-item-create`
- `API-admin-item-get`
- `API-admin-item-update`
- `API-admin-item-delete`

---

## User-facing behavior

Manager logs into admin panel and opens items list.

The list supports:
- pagination
- free-text search
- filtering by status
- filtering by tag
- filtering by country
- filtering by region

Manager may:
- create a new Item
- open an existing Item
- edit fields
- change publication status
- delete an Item

When an Item write is completed:
- canonical data is updated
- relevant public projections are refreshed

If an Item is `PUBLISHED`, it may appear publicly.
If an Item is `DRAFT`, it must remain hidden from public site.

---

## Business rules

- `RULE-public-001`: only `PUBLISHED` Items appear in public catalog
- `RULE-public-003`: only `PUBLISHED` Items have public details availability
- `RULE-readmodel-001`: admin API owns canonical Item writes
- `RULE-readmodel-003`: sync after item create
- `RULE-readmodel-004`: sync after item update
- `RULE-readmodel-005`: sync after item delete
- `RULE-readmodel-007`: only `PUBLISHED` Items may exist in public projections
- `RULE-auth-005`: protected admin routes require manager authentication

---

## Backend contracts

### API-admin-items-list
Endpoint:
- `GET /api/v1/admin/items`

Supports:
- `page`
- `page_size`
- `q`
- `status`
- `tag`
- `country`
- `region`

### API-admin-item-create
Endpoint:
- `POST /api/v1/admin/items`

Creates canonical Item record.

### API-admin-item-get
Endpoint:
- `GET /api/v1/admin/items/{id}`

Returns canonical Item details for edit form.

### API-admin-item-update
Endpoint:
- `PUT /api/v1/admin/items/{id}`

Updates canonical Item and triggers projection sync.

### API-admin-item-delete
Endpoint:
- `DELETE /api/v1/admin/items/{id}`

Deletes canonical Item and removes public projections as needed.

---

## Data impact

### Canonical collections
- `DATA-items`

### Projection impact
- `DATA-public_item_cards`
- `DATA-public_item_details`

### Fields managed
- slug
- title
- short_description
- full_description
- country
- region
- location_label
- tags
- status
- hero_image_url
- created_at
- updated_at

---

## UI impact

### frontend-admin
- items list page
- item filters
- item create form
- item edit form
- delete action
- success/error feedback

### frontend-site
Indirect impact:
- published Items appear or disappear from public site
- changed Item data becomes visible in catalog/details projections

---

## States

### Happy state
Manager manages Item records successfully and projections stay coherent.

### Empty list state
No Items match current admin filters.

### Form validation state
Required fields or invalid combinations are rejected.

### Error state
Create/update/delete/listing fails visibly.

---

## Error cases

- slug collision
- item not found
- invalid publication status
- projection refresh failure after write
- delete target missing
- malformed filter values

---

## Validation

### Acceptance references
- `AC-admin-items`
- `AC-public-catalog`
- `AC-item-details`

### Tests
- `TEST-admin-items-list`
- `TEST-admin-item-create`
- `TEST-admin-item-update`
- `TEST-admin-item-delete`
- `TEST-admin-item-filtering`
- `TEST-public-catalog-updates-after-publish`
- `TEST-public-catalog-hides-draft-item`
- `TEST-public-item-details-updates-after-edit`

---

## Related documents

- `XCUT-read-model-sync`
- `XCUT-authz`
- `SLICE-006-admin-item-crud`
- `ADR-003-canonical-vs-read-model`

---

## Future extensions

Potential later evolution:
- soft delete
- version history
- editorial workflow
- preview mode
- scheduled publication
- hero image upload management
