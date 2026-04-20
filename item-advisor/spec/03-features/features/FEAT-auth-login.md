# FEAT-auth-login

## Purpose

Allow an existing account holder to authenticate and obtain an access token appropriate to the interaction context.

This feature exists in two variants:

- public login for end users
- admin login for managers

The variants are related but must remain contextually separated.

---

## Scope

### Included
- public login endpoint
- admin login endpoint
- credential verification
- password hash verification
- JWT issuance
- user info in auth response
- client-side token storage for MVP
- auth-aware route protection
- public `/me` endpoint for authenticated user context

### Excluded
- refresh tokens
- password reset
- email verification
- SSO / OAuth
- multi-factor authentication

---

## Actors

- Authenticated user candidate
- Manager

---

## Entry points

### Public site
- `UI-site-login-page`
- header action leading to login page

### Admin panel
- `UI-admin-login-page`

### APIs
- `API-public-auth-login`
- `API-admin-auth-login`
- `API-public-me`

---

## User-facing behavior

### Public login
A registered user enters email and password in the public website login page.

If credentials are valid:
- access token is returned
- user context is stored in frontend state
- UI switches to authenticated mode
- user can access authenticated pages such as cabinet and review submission

If credentials are invalid:
- user sees auth failure message
- no authenticated state is established

### Admin login
A manager enters email and password in the admin login page.

If credentials are valid and role is `MANAGER`:
- admin token is returned
- manager can access protected admin routes

If role is not `MANAGER`:
- login is rejected for admin context

---

## Business rules

- `RULE-auth-002`: public login authenticates end users and returns access token
- `RULE-auth-003`: admin login authenticates only `MANAGER` users
- `RULE-auth-004`: protected public routes require authentication
- `RULE-auth-005`: protected admin routes require manager authentication
- `RULE-auth-006`: passwords are never stored in plain text

---

## Backend contracts

### API-public-auth-login
Request:
- email
- password

Response:
- access_token
- token_type
- user { id, email, role }

### API-admin-auth-login
Request:
- email
- password

Response:
- access_token
- token_type
- user { id, email, role }

### API-public-me
Response:
- current authenticated user identity

---

## Data impact

### Canonical collection
- `DATA-users`

### Fields relied on
- email
- password_hash
- role
- created_at

No new collections are introduced by this feature.

---

## Security impact

- JWT access token is required
- password verification uses secure password hashing
- admin access must enforce role check
- protected routes must reject missing or invalid token
- public and admin auth flows must not be conflated in UI logic

---

## Frontend impact

### frontend-site
- login page
- auth store
- token persistence strategy for MVP
- conditional header links
- redirect behavior for protected pages
- logout behavior

### frontend-admin
- login page
- auth store
- route guards
- logout behavior

---

## Error cases

- unknown email
- wrong password
- valid public user attempts admin login
- missing token on protected route
- expired or malformed token

---

## Validation

### Acceptance references
- `AC-auth`

### Tests
- `TEST-auth-login-success-user`
- `TEST-auth-login-fail-invalid-password`
- `TEST-auth-login-fail-unknown-email`
- `TEST-admin-login-success-manager`
- `TEST-admin-login-fail-non-manager`
- `TEST-me-returns-current-user`
- `TEST-ui-site-login-render`
- `TEST-ui-admin-login-render`

---

## Related documents

- `FEAT-auth-register`
- `XCUT-authz`
- `ADR-005-jwt-auth`
- `SLICE-002-auth-foundation`

---

## Future extensions

Potential later evolution:
- refresh token support
- remember-me strategy
- password reset
- email confirmation
- rate limiting / brute-force mitigation
