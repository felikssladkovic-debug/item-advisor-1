# Acceptance Criteria: Authentication

## Purpose

Define the acceptance-level behavior for authentication and authorization in ItemAdvisor MVP.

This document validates both:
- public auth context
- admin auth context

---

## Scope

Covered:
- register
- public login
- admin login
- `/me`
- route protection
- role boundary behavior

Not covered:
- password reset
- refresh tokens
- email verification
- advanced session lifecycle

---

## Acceptance criteria

### AC-auth-001
Anonymous visitor can open public login page.

### AC-auth-002
Anonymous visitor can open register page.

### AC-auth-003
Register with valid new credentials creates a standard `USER` account and returns auth payload.

### AC-auth-004
Register with duplicate email is rejected.

### AC-auth-005
Public login with valid `USER` credentials succeeds and returns access token plus user info.

### AC-auth-006
Public login with invalid password is rejected.

### AC-auth-007
Public login with unknown email is rejected.

### AC-auth-008
Authenticated public user can call `/api/v1/me` successfully.

### AC-auth-009
Unauthenticated access to protected public route is rejected.

### AC-auth-010
Manager can authenticate through admin login with valid manager credentials.

### AC-auth-011
Non-manager account cannot authenticate into admin context.

### AC-auth-012
Unauthenticated access to protected admin route is rejected.

### AC-auth-013
Authenticated manager can access protected admin route.

### AC-auth-014
Passwords are never persisted in plain text.

### AC-auth-015
Frontend route protection reflects backend auth truth and does not expose protected pages as usable when token is absent.

---

## Evidence expectations

### Backend evidence
- register test passes
- public login success/failure tests pass
- admin login success/failure tests pass
- `/me` test passes
- protected-route auth tests pass

### Frontend evidence
- public login page renders
- admin login page renders
- protected route redirects or blocks correctly

### Manual evidence
- seeded `user@example.com / user123` works in public context
- seeded `manager@example.com / manager123` works in admin context

---

## Related documents

- `FEAT-auth-register`
- `FEAT-auth-login`
- `XCUT-authz`
- `SLICE-002-auth-foundation`
- `ADR-005-jwt-auth`
