# Delivery Roadmap

## Purpose

This roadmap defines the recommended implementation order for ItemAdvisor as a sequence of vertical slices.

A vertical slice is a limited but end-to-end increment that crosses all required layers:

- database
- backend
- frontend
- validation
- runtime / deployment

The goal is to avoid one giant implementation wave and instead build the MVP in steps that can be checked, demoed, and stabilized.

---

## Delivery principles

### Principle 1: prefer vertical slices over layer-first work
Do not fully finish backend first and frontend later.
Prefer slices that produce demonstrable end-to-end value.

### Principle 2: every slice must have acceptance evidence
A slice is not done because code was written.
A slice is done when behavior is validated.

### Principle 3: start with runtime baseline
The project must become runnable very early.

### Principle 4: treat architecture-critical concerns early
Authentication boundaries, public/admin split, and read-model behavior must appear early enough to shape the system correctly.

### Principle 5: spec stays ahead of code
For each slice, specification must be explicit before or together with implementation.

---

## Slice sequence

### SLICE-001-bootstrap
Create repository skeleton and local runnable baseline.

Focus:
- monorepo structure
- docker-compose
- MongoDB
- backend-public-api
- backend-admin-api
- frontend-site
- frontend-admin
- shared backend library
- startup seed logic
- health endpoints

Main output:
- full project starts locally with one command
- health endpoints respond
- sample data exists
- frontends can boot and connect to their backends

---

### SLICE-002-auth-foundation
Establish authentication baseline for public and admin contexts.

Focus:
- register
- public login
- admin login
- JWT
- password hashing
- role checks
- protected routes
- `/me`

Main output:
- user can authenticate in public site
- manager can authenticate in admin panel
- protected routes are enforced

---

### SLICE-003-public-catalog
Deliver the public catalog experience.

Focus:
- read-model collection for item cards
- public items endpoint
- filters
- pagination
- catalog page
- loading and error states

Main output:
- anonymous user can browse published items with filters

---

### SLICE-004-item-details
Deliver public item details page.

Focus:
- item details read-model
- item details endpoint
- approved reviews listing
- item details page
- metadata and summaries

Main output:
- anonymous user can open published item details page with approved review data

---

### SLICE-005-user-reviews
Deliver authenticated contribution flow.

Focus:
- review submission endpoint
- review validation
- photo upload
- user cabinet endpoint
- user cabinet page

Main output:
- authenticated user can submit a pending review and inspect own review history

---

### SLICE-006-admin-item-crud
Deliver manager item management workflow.

Focus:
- admin items list
- admin item filters
- create item
- edit item
- delete item
- read-model refresh after item writes

Main output:
- manager can manage canonical Item data through admin panel

---

### SLICE-007-review-moderation
Deliver manager moderation workflow.

Focus:
- admin reviews list
- review details
- approve action
- decline action with mandatory reason
- moderation fields update
- aggregate refresh

Main output:
- manager can process incoming reviews and affect public-facing aggregates correctly

---

### SLICE-008-hardening
Stabilize the MVP.

Focus:
- test coverage completion
- consistent error responses
- env examples
- README quality
- regression checklist
- final local demo polish

Main output:
- MVP is stable, understandable, and reproducible

---

## Recommended checkpoints

### Checkpoint A
After SLICE-001:
- the whole system boots
- seeded runtime is visible
- health checks are green

### Checkpoint B
After SLICE-002:
- auth boundary exists
- protected flows are real

### Checkpoint C
After SLICE-004:
- discovery flow is real for anonymous users

### Checkpoint D
After SLICE-005:
- contribution flow is real for authenticated users

### Checkpoint E
After SLICE-007:
- manager workflow is real
- public and admin behaviors are integrated

### Checkpoint F
After SLICE-008:
- MVP is ready for local exploration, regression review, and further increments

---

## Relationship to prompts

A full-build agent prompt may cover all slices.

However, future change prompts should usually target one slice or a small set of adjacent features rather than the entire system.

