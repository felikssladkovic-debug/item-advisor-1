# Acceptance Criteria: Public Catalog

## Purpose

Define the acceptance-level behavior for the public catalog experience.

The public catalog is the main entry point for anonymous discovery and must behave consistently with publication and projection rules.

---

## Scope

Covered:
- catalog route
- public Items listing
- pagination
- text query
- tag filter
- country filter
- region filter
- item card rendering
- navigation to details

Not covered:
- advanced sorting
- map search
- saved searches
- personalized ranking

---

## Acceptance criteria

### AC-public-catalog-001
Anonymous user can open the public catalog page.

### AC-public-catalog-002
Authenticated public user can also use the same catalog page.

### AC-public-catalog-003
Catalog returns only `PUBLISHED` Items.

### AC-public-catalog-004
`DRAFT` Items do not appear in public catalog results.

### AC-public-catalog-005
Each catalog item exposes only public-safe fields.

### AC-public-catalog-006
Catalog supports `page` and `page_size`.

### AC-public-catalog-007
Catalog supports text query `q`.

### AC-public-catalog-008
Catalog supports `tag` filter.

### AC-public-catalog-009
Catalog supports `country` filter.

### AC-public-catalog-010
Catalog supports `region` filter.

### AC-public-catalog-011
Catalog page renders item cards with title, short description, location, tags, and rating summary.

### AC-public-catalog-012
Clicking a catalog item opens the corresponding public item details page.

### AC-public-catalog-013
If no Items match filters, the catalog renders a usable empty state.

### AC-public-catalog-014
If backend request fails, the catalog renders a usable error state.

### AC-public-catalog-015
Catalog behavior remains consistent after relevant admin Item changes and projection refresh.

---

## Evidence expectations

### Backend evidence
- published-only listing test passes
- search/filter tests pass
- pagination test passes

### Frontend evidence
- catalog page render test passes
- filter UI render test passes
- item card navigation test passes

### Manual evidence
- inspect seeded published Items
- verify seeded draft Item is absent from public catalog
- verify admin publish/unpublish affects public visibility

---

## Related documents

- `FEAT-public-catalog`
- `FEAT-admin-item-crud`
- `XCUT-read-model-sync`
- `ADR-003-canonical-vs-read-model`
- `SLICE-003-public-catalog`
