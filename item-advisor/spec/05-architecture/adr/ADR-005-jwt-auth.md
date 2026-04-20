# ADR-005: Use JWT-based authentication for MVP

## Status

Accepted

---

## Context

ItemAdvisor MVP has two authenticated interaction contexts:

- public authenticated user context
- admin manager context

The project requires:
- simple local runtime
- real protected routes
- role-based access control
- low infrastructure overhead
- compatibility with separate frontend apps and separate backend APIs

The authentication mechanism must be practical for MVP and sufficiently explicit for later evolution.

---

## Decision

Use JWT-based authentication for MVP.

### Public auth usage
Public login returns a short-lived access token used for protected public routes.

### Admin auth usage
Admin login returns a short-lived access token used for protected admin routes.

### Role usage
Authenticated identity includes role information required for authorization checks.

Passwords are stored only as secure password hashes.

---

## Why this decision fits MVP

JWT-based access tokens are appropriate because they provide:

- simple stateless request authentication
- easy local development
- clean separation between frontend and backend contexts
- straightforward role-based protection
- low operational complexity for MVP

The project does not require full session infrastructure at this stage.

---

## Decision details

### Token type
Use bearer token style access token.

### Password handling
Passwords must be stored as password hashes only.

### Role checks
Admin API must enforce manager role.
Public protected routes require authenticated user context.

### MVP scope choice
Short-lived access token is sufficient for MVP.
Refresh tokens are not required in MVP.

---

## Alternatives considered

### Alternative A: server-side session storage
Rejected for MVP.

Reason:
- valid approach in many systems
- but introduces extra session state and infrastructure concerns
- less aligned with the lightweight split frontend/backend runtime of MVP

### Alternative B: external identity provider
Rejected for MVP.

Reason:
- unnecessary complexity
- external dependency not required for current goal
- distracts from core product behavior

### Alternative C: one shared login surface with weak role gating
Rejected.

Reason:
- weakens conceptual separation of public and admin contexts
- increases risk of accidental boundary confusion

---

## Consequences

### Positive consequences
- simple protected API requests
- clean frontend integration
- practical for two frontend apps
- practical for two backend APIs
- clear path for role-based checks

### Negative consequences
- token expiry handling remains simplified
- no refresh token flow in MVP
- revocation strategy is minimal
- frontend token storage choices must be handled carefully even in MVP

---

## Operational consequences

The implementation must include:

- password hashing helper
- token creation helper
- token parsing/validation helper
- current user dependency or equivalent
- current manager dependency or equivalent
- route guards in frontends
- consistent auth error behavior

---

## Validation consequences

The following behaviors must be verifiable:

- public login succeeds for valid user
- public login fails for invalid credentials
- admin login succeeds for manager
- admin login fails for non-manager
- protected public route rejects missing or invalid token
- protected admin route rejects missing, invalid, or wrong-role token

---

## Future evolution

Possible later evolution:
- refresh tokens
- secure token rotation
- token revocation
- password reset
- SSO integration
- stronger audit and auth event logging

For MVP, JWT-based access authentication is the most appropriate balance between simplicity and real protected behavior.
