# FEAT-public-catalog

## Purpose

Provide the main public entry point for discovering Items.

The public catalog is the first core user-facing feature of ItemAdvisor.
It allows an anonymous or authenticated public user to browse published Items, apply filters, and navigate to item details.

---

## Scope

### Included
- catalog route `/`
- public catalog endpoint
- pagination
- free-text search
- tag filter
- country filter
- region filter
- item cards with summary information
- loading state
- empty state
- error state
- navigation to item details page

### Excluded
- advanced sorting
- saved filters
- map-based exploration
- recommendation engine
- geo proximity search
- faceted analytics
- autocomplete suggestions

---

## Actors

- Anonymous user
- Authenticated user

---

## Entry points

### UI
- `UI-site-catalog-page`
- header link to catalog

### API
- `API-public-items-list`

---

## User-facing behavior

User opens the public catalog page.

The page displays a paginated list of public Item cards.

Each card shows:
- title
- short description
- location summary
- tags
- rating summary
- approved reviews count if present
- hero image if present

User may filter by:
- text query (`q`)
- tag
- country
- region

User may paginate through results.

Clicking a card opens the public item details page for that Item.

---

## Business rules

- `RULE-public-001`: public catalog shows only `PUBLISHED` Items
- `RULE-public-002`: `DRAFT` Items must not appear in catalog
- `RULE-public-004`: public API must not expose admin-only fields
- `RULE-readmodel-002`: public API reads from public read-model collections
- `RULE-readmodel-007`: only `PUBLISHED` Items may exist in public read-model collections

---

## Backend contracts

### API-public-items-list
Endpoint:
- `GET /api/v1/items`

Supported query params:
- `page`
- `page_size`
- `q`
- `tag`
- `country`
- `region`

Response shape:
- `items`
- `page`
- `page_size`
- `total`

Each returned item is a public-safe card projection.

---

## Data impact

### Read model
- `DATA-public_item_cards`

### Aggregate fields used
- approved review count
- average rating

### Canonical dependency
Catalog data is derived from canonical Item records and approved Review aggregates, but the endpoint itself should read from public card projections.

---

## UI impact

### frontend-site
- catalog page
- filter controls
- pagination controls
- card list
- route to item details

### Layout impact
- accessible through global header
- must work for anonymous and authenticated public users

---

## States

### Happy state
Published Items are returned and rendered correctly.

### Empty state
No Items match filters.

### Loading state
Page indicates data fetch in progress.

### Error state
Page indicates request failure without broken navigation.

---

## Error cases

- backend unavailable
- invalid pagination values
- zero results after applying filters
- projection inconsistency causing missing expected fields

---

## Validation

### Acceptance references
- `AC-public-catalog`

### Tests
- `TEST-public-catalog-renders`
- `TEST-public-catalog-returns-published-items-only`
- `TEST-public-catalog-search-by-q`
- `TEST-public-catalog-filter-by-tag`
- `TEST-public-catalog-filter-by-country`
- `TEST-public-catalog-filter-by-region`
- `TEST-public-catalog-pagination`
- `TEST-ui-site-catalog-renders`

---

## Related documents

- `FEAT-item-details`
- `XCUT-read-model-sync`
- `ADR-003-canonical-vs-read-model`
- `SLICE-003-public-catalog`

---

## Future extensions

Potential later evolution:
- sort by popularity
- sort by rating
- map visualization
- multi-tag filtering
- featured collections
- thematic catalog sections
