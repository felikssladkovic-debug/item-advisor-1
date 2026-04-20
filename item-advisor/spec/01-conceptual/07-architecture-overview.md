# Architecture Overview

## Purpose

This document explains the intended high-level architecture of ItemAdvisor MVP.

It is not a low-level code design document.
It is the conceptual architecture map that connects product intent to runtime structure.

---

## Architecture goals

The MVP architecture must satisfy two constraints simultaneously:

### Constraint 1: real working MVP
The system must run locally with one command and provide a complete end-to-end experience.

### Constraint 2: non-toy structural baseline
The MVP must already reflect the future-oriented boundaries needed for a larger product.

This leads to a design that is still small enough to build quickly, but already separates concerns clearly.

---

## Main runtime parts

The system consists of:

1. public website
2. admin panel
3. public backend API
4. admin backend API
5. shared backend library
6. MongoDB
7. local file storage for uploaded review photos

---

## High-level split

### Public side
The public side serves:
- catalog browsing
- item details
- authentication for end users
- review submission
- personal cabinet

This side must be safe for anonymous and authenticated public users.

### Admin side
The admin side serves:
- manager login
- item CRUD
- review moderation
- dashboard summary

This side must be protected and manager-only.

### Shared backend layer
Shared backend code exists to avoid duplication of:
- config
- DB connection logic
- auth helpers
- common schemas
- serialization helpers
- read-model sync logic

---

## Why two backend APIs

The MVP intentionally uses two backend APIs:

- `backend-public-api`
- `backend-admin-api`

### Reason
Public and admin contexts are not merely different pages.
They have different security boundaries, data exposure expectations, and operational concerns.

### Consequences
- public routes remain focused on public-safe behavior
- admin routes remain focused on management workflows
- public API avoids accidental exposure of admin-only fields
- admin API can evolve management features independently

---

## Why two frontend apps

The MVP intentionally uses two frontend apps:

- `frontend-site`
- `frontend-admin`

### Reason
Public site and admin panel have different route structures, user expectations, and security context.

### Consequences
- public UX remains clean and focused on discovery
- admin UX remains focused on operational workflows
- route guards and auth stores can remain context-appropriate
- deployments can later evolve independently if needed

---

## Data architecture

### Canonical collections
Canonical write-oriented collections:
- `items`
- `users`
- `reviews`

These collections support operational truth.

### Public read-model collections
Read-optimized public collections:
- `public_item_cards`
- `public_item_details`

These collections support public rendering truth.

### Aggregates
Public-facing review summary metrics such as:
- approved reviews count
- average rating

must be derived only from approved reviews.

---

## Read path vs write path

### Write path
Admin and authenticated user actions modify canonical records.

Examples:
- manager creates or edits Item
- user submits Review
- manager approves or declines Review

### Read path
Public site reads from read-optimized public projections plus approved reviews.

Examples:
- public catalog page
- public item details page

### Architectural implication
The system is intentionally not a pure CRUD-through-one-model application.

It has:
- operational write models
- projected read models
- synchronization behavior between them

---

## Synchronization model

When relevant canonical data changes, the system must refresh affected public projections.

Examples:
- item create
- item update
- item delete
- publication status change
- review moderation that changes public aggregates

For MVP, synchronous in-process update after relevant writes is acceptable.

The critical thing is not sophistication of infrastructure.
The critical thing is explicitness and testability of synchronization behavior.

---

## Authentication model

### Public auth
Public site supports:
- register
- login
- authenticated `/me`
- token-based access to protected public routes

### Admin auth
Admin panel supports:
- manager login
- token-based access to protected admin routes

### Security principle
Role-based protection must exist at backend level and be reflected in frontend route behavior.

---

## File storage model

For MVP, uploaded review photos are stored in local file storage and exposed through public static URLs.

### Why this is acceptable for MVP
- simple to run locally
- easy to validate
- avoids premature infrastructure complexity

### Limitation
This is not the final scalable media architecture, but it is acceptable as an MVP-local-runtime choice.

---

## Runtime model

Local runtime is Docker-based.

The project must start through one command and expose:
- public site
- admin panel
- public API docs
- admin API docs

This requirement is architectural because reproducible runtime is part of system truth.

---

## Architecture qualities

The architecture should optimize for:

- clear separation of concerns
- safe data exposure
- local reproducibility
- understandable service boundaries
- support for incremental development
- support for AI-assisted implementation and evolution

---

## Architecture risks

### Risk 1: drift between canonical and public read-models
Mitigation:
- explicit sync utilities
- validation tests
- startup rebuild support

### Risk 2: accidental duplication across public and admin backend logic
Mitigation:
- backend-shared package
- disciplined shared helpers

### Risk 3: public/admin auth behavior becoming inconsistent
Mitigation:
- cross-cutting authz document
- acceptance tests
- separate but parallel auth feature packets

### Risk 4: frontends become fake shells disconnected from real runtime
Mitigation:
- real API wiring early
- bootstrap slice
- local-run checklist

---

## Architecture consequences for implementation

The codebase should reflect the following truths explicitly:

- public and admin are separate application contexts
- shared logic lives in shared backend package
- public API reads public projections
- admin API owns management writes
- review moderation affects public-facing aggregates
- local storage is a real runtime dependency
- Docker startup is part of the expected operating model
