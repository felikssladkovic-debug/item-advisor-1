# XCUT-authz

## Purpose

Define authentication and authorization behavior across all ItemAdvisor contexts.

This is a cross-cutting concern because it affects:

- public site routes
- admin routes
- public API endpoints
- admin API endpoints
- user identity handling
- manager-only actions
- frontend navigation state
- protected data boundaries

---

## Problem statement

ItemAdvisor has more than one kind of authenticated behavior.

It contains:

- anonymous public browsing
- authenticated public user actions
- manager-only admin actions

Without an explicit authz model, the system would risk:
- blurred boundaries between public and admin
- accidental exposure of management workflows
- inconsistent backend and frontend protection
- unclear expectations for future features

---

## Auth contexts

### Context 1: anonymous public
Capabilities:
- browse catalog
- open item details
- open login/register pages

Restrictions:
- cannot submit review
- cannot open cabinet
- cannot access admin surface

### Context 2: authenticated public user
Capabilities:
- all anonymous public actions
- submit review
- open cabinet
- inspect own review history

Restrictions:
- cannot access manager-only admin functionality

### Context 3: authenticated manager
Capabilities:
- login to admin panel
- manage Items
- moderate Reviews
- access dashboard summary

Restrictions:
- manager capability must be enforced through admin auth boundary, not assumed implicitly

---

## Identity model

### Roles
- `USER`
- `MANAGER`

### Baseline assumptions
- public register creates only `USER`
- admin login accepts only `MANAGER`
- role is part of authenticated identity and must be available to authorization logic

---

## Backend protection model

### Public API
Supports:
- anonymous routes
- authenticated public routes

Examples of anonymous routes:
- catalog
- item details
- approved reviews list
- register
- login

Examples of protected public routes:
- create review
- my reviews
- me

### Admin API
Supports:
- authenticated manager routes only

Examples:
- admin items
- admin reviews
- moderation actions
- dashboard summary

---

## Frontend protection model

### frontend-site
Must reflect authenticated state in:
- header links
- login/register visibility
- cabinet visibility
- review form access path
- route protection for cabinet

### frontend-admin
Must reflect manager authentication in:
- login flow
- route guards
- redirect-to-login behavior for protected pages
- logout flow

---

## Authorization principles

### Principle 1
Authentication and authorization must be enforced at backend level.
Frontend protection alone is never sufficient.

### Principle 2
Frontend should reflect backend auth truth and avoid presenting protected flows as available when they are not.

### Principle 3
Public and admin tokens or auth states may be implemented similarly in MVP, but the interaction contexts must remain conceptually separate.

### Principle 4
Admin login is not simply “public login to a different page”.
It is a manager-only authorization boundary.

---

## Route categories

### Public anonymous-safe routes
Examples:
- `/`
- `/items/:slug`
- `/login`
- `/register`

### Public authenticated routes
Examples:
- `/cabinet`
- review submission action

### Admin protected routes
Examples:
- `/`
- `/items`
- `/items/new`
- `/items/:id`
- `/reviews`
- `/reviews/:id`

---

## API protection examples

### Public anonymous-safe endpoints
- `GET /api/v1/items`
- `GET /api/v1/items/{slug}`
- `GET /api/v1/items/{slug}/reviews`
- `POST /api/v1/auth/register`
- `POST /api/v1/auth/login`

### Public authenticated endpoints
- `POST /api/v1/reviews`
- `GET /api/v1/reviews/my`
- `GET /api/v1/me`

### Admin authenticated endpoints
- `POST /api/v1/auth/login` (admin service)
- `GET /api/v1/admin/items`
- `POST /api/v1/admin/items`
- `PUT /api/v1/admin/items/{id}`
- `DELETE /api/v1/admin/items/{id}`
- `GET /api/v1/admin/reviews`
- `POST /api/v1/admin/reviews/{id}/approve`
- `POST /api/v1/admin/reviews/{id}/decline`

---

## Failure behavior expectations

### Missing token
Protected route must reject access.

### Invalid token
Protected route must reject access.

### Wrong role
Admin route must reject non-manager identity.

### Expired token
Protected route must reject access and frontend should recover appropriately for MVP behavior.

---

## Validation expectations

The following behaviors must be testable:

- anonymous user can browse public catalog
- anonymous user cannot open cabinet as usable protected flow
- authenticated user can submit review
- authenticated user cannot use admin routes
- manager can use admin routes
- non-manager cannot log into admin context

---

## Related documents

- `FEAT-auth-register`
- `FEAT-auth-login`
- `FEAT-review-submit`
- `FEAT-user-cabinet`
- `FEAT-admin-item-crud`
- `FEAT-admin-review-moderation`
- `AC-auth`
- `ADR-005-jwt-auth`

---

## Future evolution

Possible future enhancements:
- refresh tokens
- session revocation
- finer-grained permissions
- admin sub-roles
- brute-force protection
- audit logging for sensitive actions
