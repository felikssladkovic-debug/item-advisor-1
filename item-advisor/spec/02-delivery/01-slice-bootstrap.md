# SLICE-001-bootstrap

## Goal

Establish the minimal fully runnable end-to-end skeleton of ItemAdvisor so that the project can start locally with one command and expose all major services.

This slice is about runtime truth, structure, and initial seed coherence.

---

## Why this slice exists

Before implementing detailed product behavior, the project needs a stable execution baseline.

Without this slice:

- later features are harder to validate
- service boundaries stay vague
- local startup becomes fragile
- spec-to-code alignment is harder to maintain

This slice creates the “living chassis” of the system.

---

## Included

- monorepo structure
- Docker and docker-compose runtime
- MongoDB service
- backend-public-api service
- backend-admin-api service
- frontend-site service
- frontend-admin service
- backend-shared package
- local storage path for review photos
- health endpoints for both APIs
- startup DB connection
- collection/index creation
- initial seed users
- initial seed items
- initial seed reviews
- initial read-model build or rebuild logic
- basic frontend app boot with routing shell
- initial README run instructions

---

## Excluded

- complete auth UX
- full review submission UX
- full item CRUD UX
- moderation UX
- final polished UI
- full contract coverage
- final test coverage

This slice may contain only minimal shell pages on the frontends, as long as runtime wiring is real.

---

## Touched services and components

### Infra
- docker-compose
- Mongo container
- mounted storage for review photos

### Backend shared
- settings/config
- Mongo connection helpers
- common enums/constants
- seed utilities
- read-model bootstrap utilities

### Public API
- `/health`
- startup hooks
- static file serving baseline

### Admin API
- `/health`
- startup hooks

### Frontend site
- app shell
- router shell
- API connectivity baseline

### Frontend admin
- app shell
- router shell
- API connectivity baseline

---

## Expected repository state after this slice

The repo contains separated folders for:

- backend-shared
- backend-public-api
- backend-admin-api
- frontend-site
- frontend-admin
- infra
- storage

The full stack starts locally with one command.

The intended local URLs are reachable.

---

## Seed expectations

Startup must ensure:

- manager account exists
- normal user account exists
- at least 3 sample Items exist
- at least 2 sample Items are `PUBLISHED`
- sample reviews exist across mixed statuses
- public read-model collections are populated for relevant seeded records

Seeded content should match the ItemAdvisor theme.

---

## Acceptance criteria

### AC-bootstrap-001
`docker-compose up --build` starts the full stack.

### AC-bootstrap-002
MongoDB is reachable by both APIs.

### AC-bootstrap-003
Public API health endpoint returns service identity and Mongo health indicator.

### AC-bootstrap-004
Admin API health endpoint returns service identity and Mongo health indicator.

### AC-bootstrap-005
Seed data exists after startup.

### AC-bootstrap-006
Public read-model collections exist after startup.

### AC-bootstrap-007
Frontends boot and are reachable on configured local ports.

### AC-bootstrap-008
Review photo storage path exists and is mounted into runtime.

---

## Evidence

### Automated evidence
- backend test for public health endpoint
- backend test for admin health endpoint
- startup smoke test if practical

### Manual evidence
- open local URLs
- inspect seeded catalog behavior in DB or API
- inspect health endpoints
- confirm static storage mount exists

---

## Risks

### Risk 1
All services may start, but internal URLs may not be correctly wired.

### Risk 2
Seed logic may create canonical collections but forget to rebuild public read-models.

### Risk 3
Frontends may boot but not truly point to real APIs.

### Risk 4
Local photo storage may exist in code but not in docker-compose runtime.

---

## Done definition

This slice is done when:

- the project is truly runnable
- runtime boundaries are real
- seed baseline is coherent
- service shells exist
- later slices can safely build on top of this foundation
