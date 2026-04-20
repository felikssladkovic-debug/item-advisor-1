# SLICE-002-auth-foundation

## Goal

Establish the authentication and authorization baseline for both public and admin contexts.

This slice makes the system meaningfully protected and enables all later authenticated workflows.

Without this slice:
- cabinet cannot exist
- review submission cannot be real
- admin panel cannot be real
- route boundaries remain theoretical only

---

## Why this slice exists

The bootstrap slice creates runnable structure.
This slice creates identity-aware structure.

It is the transition from “services are running” to “real protected system behavior exists”.

---

## Included

### Public auth
- register
- login
- token issuance
- current user endpoint
- authenticated public route support

### Admin auth
- manager login
- manager route protection

### Shared auth building blocks
- password hashing
- token generation
- token validation
- auth dependencies / guards
- role checks

### Frontend integration
- public login page
- register page
- admin login page
- auth stores
- protected route behavior
- header auth state awareness
- logout baseline behavior

---

## Excluded

- refresh tokens
- password reset
- email verification
- remember-me
- SSO
- MFA
- advanced session management

---

## Touched services and components

### backend-shared
- password hashing helper
- JWT helper
- auth schemas
- current identity helpers

### backend-public-api
- register endpoint
- login endpoint
- `/me`
- protected review/cabinet dependencies

### backend-admin-api
- manager login endpoint
- manager-only protection on admin routes

### frontend-site
- login page
- register page
- auth store
- route protection
- header state

### frontend-admin
- login page
- auth store
- route guards

---

## Expected repository state after this slice

After this slice:

- end user can register
- end user can login
- end user can call protected public endpoint
- manager can login to admin
- non-manager cannot use admin context
- frontends reflect authenticated vs unauthenticated state
- later slices can rely on real auth boundaries

---

## Acceptance criteria

### AC-auth-foundation-001
Register works for new user credentials.

### AC-auth-foundation-002
Public login works for valid user credentials.

### AC-auth-foundation-003
Admin login works for valid manager credentials.

### AC-auth-foundation-004
Admin login rejects non-manager credentials.

### AC-auth-foundation-005
Protected public route rejects unauthenticated request.

### AC-auth-foundation-006
Protected admin route rejects unauthenticated request.

### AC-auth-foundation-007
Protected admin route rejects wrong-role request.

### AC-auth-foundation-008
Frontend route protection and visible auth state behave coherently.

---

## Evidence

### Automated evidence
- auth backend tests
- frontend login render tests
- protected route behavior tests where practical

### Manual evidence
- login as seeded `user@example.com / user123`
- login as seeded `manager@example.com / manager123`
- verify header/login/cabinet/admin route behavior

---

## Risks

### Risk 1
Backend auth may work but frontend auth state becomes inconsistent.

### Risk 2
Public and admin login semantics may drift apart unintentionally.

### Risk 3
Role checks may be missing from some admin endpoints.

### Risk 4
Token handling may exist but not actually protect UI flows.

---

## Done definition

This slice is done when:
- auth is real in both contexts
- manager boundary is enforced
- protected routes are meaningful
- later feature slices can assume authenticated behavior exists
