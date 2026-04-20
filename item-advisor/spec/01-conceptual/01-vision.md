# ItemAdvisor Vision

## Product idea

ItemAdvisor is a web application conceptually similar to TripAdvisor, but focused on unusual places rather than general travel attractions.

The core domain object is called **Item**.

In ItemAdvisor, an Item is a place associated with one or more of the following qualities:

- respected in spiritual traditions
- connected to legends or myths
- mysterious or occult in popular imagination
- culturally perceived as unusual, sacred, hidden, enigmatic, or charged with meaning

## MVP intention

The MVP is intentionally narrow in scope but not trivial in architecture.

The MVP must prove that the system can support:

- public discovery of Items
- user registration and authentication
- user review submission
- manager moderation workflows
- canonical data management
- public read-model delivery
- future growth toward a larger product

## Product promise

For end users, ItemAdvisor should feel like a clean and credible discovery experience around meaningful or mysterious places.

For internal evolution, the system should already contain the architectural split required for later scaling:

- public-facing site and APIs
- admin-facing workflows and APIs
- shared backend logic
- canonical write model
- public read-model collections

## MVP user journeys

### Journey 1: discovery
An anonymous user opens the public site, browses the catalog, filters items, opens an item page, and reads approved reviews.

### Journey 2: contribution
A registered user logs in, opens an item page, submits a review, optionally uploads review photos, and later checks moderation result in the personal cabinet.

### Journey 3: curation
A manager logs into the admin panel, edits item data, reviews incoming submissions, and approves or declines reviews with explicit moderation state.

## Strategic architecture intent

The MVP must not be a toy scaffold.

It must be a working application built with architecture choices that support later evolution:

- separate public and admin APIs
- protect admin-only data from public exposure
- keep shared backend logic centralized
- maintain public read-model collections optimized for rendering
- preserve clear contracts and validation behavior

## Out of scope for MVP

The following may be added later, but are not required for MVP:

- advanced recommendation algorithms
- social graph / follow mechanics
- multilingual content
- moderation queues with bulk actions
- geo search and map-heavy UI
- rich media workflows beyond basic review photos
- editorial workflows beyond manager CRUD and moderation

## Success criteria for MVP

The MVP is considered successful when:

- it runs locally with a single command
- public site works end-to-end
- admin panel works end-to-end
- public and admin data boundaries are respected
- review moderation changes public-facing aggregates correctly
- tests cover the core happy paths and key invariants
