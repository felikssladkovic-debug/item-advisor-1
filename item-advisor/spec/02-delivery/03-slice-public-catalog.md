# SLICE-003-public-catalog

## Goal

Deliver the first real public discovery experience: a catalog of published Items with filtering and pagination.

This slice turns ItemAdvisor from a structurally running system into a visibly useful product for anonymous users.

---

## Why this slice exists

After bootstrap and auth foundation, the system still needs a core public value loop.

The catalog is that value loop.

It is the first place where:
- public read-model strategy becomes visible
- Item publication rules become user-visible
- catalog UX becomes concrete
- public-facing product identity starts to feel real

---

## Included

- public Items list endpoint
- public card projection usage
- catalog route `/`
- item cards
- pagination
- text query
- tag filter
- country filter
- region filter
- empty/loading/error states
- navigation from card to item details

---

## Excluded

- item details page itself
- review submission
- map exploration
- sorting beyond MVP scope
- recommendation blocks

---

## Touched services and components

### backend-shared
- projection helpers where needed
- shared schemas for item cards
- serialization helpers

### backend-public-api
- items listing endpoint
- query handling
- public projection read path

### frontend-site
- catalog page
- filter controls
- card list rendering
- pagination controls
- route navigation to details page

### backend-admin-api
Indirectly relevant because admin writes must eventually influence catalog projections, but full admin item CRUD is not part of this slice.

---

## Expected repository state after this slice

After this slice:

- public catalog page is useful for anonymous users
- published Items can be browsed
- filters and pagination work
- only public-safe projection data is shown
- draft Items remain hidden

---

## Acceptance criteria

### AC-public-catalog-slice-001
Anonymous user can open catalog and browse published Items.

### AC-public-catalog-slice-002
Draft Items do not appear publicly.

### AC-public-catalog-slice-003
Filters narrow visible Items correctly.

### AC-public-catalog-slice-004
Pagination works.

### AC-public-catalog-slice-005
Item cards navigate to intended details route.

### AC-public-catalog-slice-006
Empty and error states are usable.

---

## Evidence

### Automated evidence
- public catalog API tests
- frontend catalog render tests
- filter and pagination tests

### Manual evidence
- inspect seeded Items in catalog
- verify only published seeded Items appear
- verify draft seeded Item remains hidden
- verify navigation path to details slug

---

## Risks

### Risk 1
Endpoint may read canonical data instead of projection data and accidentally expose wrong fields.

### Risk 2
Filters may work incorrectly due to inconsistent projection fields.

### Risk 3
Frontend may render a list but not handle empty/error/loading states properly.

### Risk 4
Catalog may appear functional while draft visibility rule is broken.

---

## Done definition

This slice is done when:
- public catalog works end-to-end
- it uses the intended public data path
- publication boundary is respected
- anonymous discovery is demonstrably real
