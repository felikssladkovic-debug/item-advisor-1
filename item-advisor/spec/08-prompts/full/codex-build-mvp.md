# Codex Full Build Prompt: ItemAdvisor MVP

You are generating a full working monorepo for the ItemAdvisor MVP.

Implement the repository as real code, not as a toy scaffold.

Do not ask follow-up questions.
Do not reduce scope.
Do not leave TODOs.
Do not replace runtime behavior with mocks.
Generate complete working code, tests, and runtime wiring.

## 1. Objective

Build the full ItemAdvisor MVP monorepo so that it runs locally with one command and provides:

- public website
- admin panel
- public backend API
- admin backend API
- shared backend library
- MongoDB
- local file storage for uploaded review photos

## 2. Use these spec documents as source of truth

### Conceptual
- `spec/01-conceptual/01-vision.md`
- `spec/01-conceptual/03-actors-and-goals.md`
- `spec/01-conceptual/04-domain-model.md`
- `spec/01-conceptual/05-business-rules.md`
- `spec/01-conceptual/06-system-context.md`
- `spec/01-conceptual/07-architecture-overview.md`

### Delivery
- `spec/02-delivery/00-roadmap.md`
- `spec/02-delivery/01-slice-bootstrap.md`
- `spec/02-delivery/02-slice-auth-foundation.md`
- `spec/02-delivery/03-slice-public-catalog.md`

### Features
- `spec/03-features/features/FEAT-auth-register.md`
- `spec/03-features/features/FEAT-auth-login.md`
- `spec/03-features/features/FEAT-public-catalog.md`
- `spec/03-features/features/FEAT-item-details.md`
- `spec/03-features/features/FEAT-review-submit.md`
- `spec/03-features/features/FEAT-user-cabinet.md`
- `spec/03-features/features/FEAT-admin-item-crud.md`
- `spec/03-features/features/FEAT-admin-review-moderation.md`

### Cross-cutting
- `spec/03-features/cross-cutting/XCUT-authz.md`
- `spec/03-features/cross-cutting/XCUT-read-model-sync.md`
- `spec/03-features/cross-cutting/XCUT-static-file-serving.md`

### Architecture
- `spec/05-architecture/adr/ADR-003-canonical-vs-read-model.md`
- `spec/05-architecture/adr/ADR-005-jwt-auth.md`

### Validation
- `spec/06-validation/acceptance/AC-auth.md`
- `spec/06-validation/acceptance/AC-public-catalog.md`
- `spec/06-validation/acceptance/AC-item-details.md`
- `spec/06-validation/acceptance/AC-reviews.md`
- `spec/06-validation/acceptance/AC-admin-items.md`
- `spec/06-validation/acceptance/AC-admin-moderation.md`
- `spec/06-validation/bdd/review-moderation.feature`
- `spec/06-validation/checklists/local-run-checklist.md`
- `spec/06-validation/checklists/mvp-demo-checklist.md`

## 3. Strict technology stack

### Frontend
- Vue 3
- Vite
- Tailwind CSS
- PrimeVue v4
- Vue Router
- Pinia
- Axios

### Backend
- Python 3.12
- FastAPI
- Pydantic
- Motor
- JWT library suitable for FastAPI MVP
- bcrypt-compatible password hashing

### Database
- MongoDB

### Testing
- pytest
- Vitest

### Infra
- Docker
- docker-compose

## 4. Required repository structure

Create the monorepo with this structure:

- `/backend-shared`
- `/backend-public-api`
- `/backend-admin-api`
- `/frontend-site`
- `/frontend-admin`
- `/infra`
- `/storage/review-photos`
- `docker-compose.yml`
- `README.md`

## 5. Core architecture requirements

Implement all of the following:

- separate public and admin frontend apps
- separate public and admin backend APIs
- shared backend library
- canonical collections for operational truth
- public read-model collections for public rendering
- admin API owns canonical Item writes
- public API reads public projections for catalog/details
- review moderation updates public-facing aggregates
- local photo storage is real and reachable
- local runtime works with one startup command

## 6. Canonical collections

Implement canonical collections for:
- `items`
- `users`
- `reviews`

Implement public read-model collections for:
- `public_item_cards`
- `public_item_details`

Use business rules and feature docs to determine fields and behavior.

## 7. Actor flows that must work

### Anonymous user
- browse public catalog
- open published Item page
- open login/register

### Authenticated user
- login/register
- open cabinet
- submit review
- upload optional review photos
- inspect moderation result

### Manager
- login to admin panel
- list/create/edit/delete Items
- list/open/moderate Reviews
- approve Review
- decline Review with required reason

## 8. Mandatory business invariants

These must remain true:

- public catalog shows only `PUBLISHED` Items
- public item details are only available for `PUBLISHED` Items
- public review list shows only `APPROVED` Reviews
- newly submitted Review starts as `PENDING`
- decline requires textual reason
- moderation sets moderation metadata
- only approved Reviews affect public aggregates
- public API must not expose admin-only fields
- admin routes require manager auth
- protected public routes require authenticated public context

## 9. Startup and seed requirements

On startup:

- connect to MongoDB
- ensure collections and indexes exist
- seed manager user if absent
- seed standard user if absent
- seed at least 3 sample Items if absent
- ensure at least 2 seeded Items are `PUBLISHED`
- seed sample Reviews in mixed statuses if absent
- build or rebuild public projections as needed

Use realistic theme-appropriate sample content.

Seeded credentials must be:
- `manager@example.com / manager123`
- `user@example.com / user123`

## 10. Runtime requirements

Everything must start with:

`docker-compose up --build`

Expected local URLs:
- public site: `http://localhost:3000`
- admin panel: `http://localhost:3001`
- public API docs: `http://localhost:8000/docs`
- admin API docs: `http://localhost:8001/docs`

## 11. Validation requirements

Implement real tests covering the core system behavior, including:

### Public/backend
- health
- register/login
- catalog published-only behavior
- item details by slug
- review submit
- my reviews

### Admin/backend
- manager login
- item CRUD
- review listing
- approve flow
- decline flow with required reason
- aggregate refresh behavior

### Frontend
- public catalog render
- item details render with mocked fetch layer if needed for isolated tests
- cabinet render
- admin items render
- admin moderation render

## 12. Code quality constraints

- keep code modular
- avoid duplicating shared backend logic
- use environment-based config
- include example env files if needed
- keep runtime behavior real
- no fake adapters in actual app runtime
- no placeholder implementations
- no “left as exercise”

## 13. Deliverables

Your output must include:

- complete working repository code
- tests
- Docker runtime wiring
- local storage wiring
- README with run instructions, URLs, credentials, and architecture explanation

## 14. Completion rule

The task is complete only when:

- the repository is coherent
- the MVP behavior matches the source spec
- the runtime is locally reproducible
- the key tests exist and are runnable
- no required feature is omitted
