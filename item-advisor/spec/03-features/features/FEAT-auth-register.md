# FEAT-auth-register

## Purpose

Allow a new public user to create a standard account and immediately enter the authenticated public context.

This feature is part of the public onboarding flow and enables later user-owned actions such as review submission and cabinet access.

---

## Scope

### Included
- public register page
- public register endpoint
- email and password submission
- account creation with role `USER`
- password hashing
- auth response after successful register
- frontend transition into authenticated state after successful register

### Excluded
- email verification
- admin account creation
- password reset
- invitation workflows
- profile enrichment during register
- social login / SSO

---

## Actors

- Anonymous user

---

## Entry points

### UI
- `UI-site-register-page`

### API
- `API-public-auth-register`

---

## User-facing behavior

Anonymous visitor opens the public register page.

The page allows entering:
- email
- password

When valid new credentials are submitted:
- new account is created
- account role is `USER`
- password is stored only as hash
- auth payload is returned
- user is considered authenticated in public context

If submitted email already exists:
- registration is rejected
- user receives clear error feedback

If payload is invalid:
- validation error is shown

---

## Business rules

- `RULE-auth-001`: public register route creates a standard `USER` account
- `RULE-auth-006`: passwords must never be stored in plain text
- `RULE-api-001`: APIs use JSON except where file upload requires multipart
- `RULE-api-006`: error responses must have consistent shape

---

## Backend contracts

### API-public-auth-register
Endpoint:
- `POST /api/v1/auth/register`

Request:
- email
- password

Response:
- access_token
- token_type
- user { id, email, role }

Behavior:
- create standard user
- hash password
- reject duplicate email

---

## Data impact

### Canonical collection
- `DATA-users`

### Fields populated
- email
- password_hash
- role = `USER`
- created_at

### Constraints
- email uniqueness must be enforced

---

## UI impact

### frontend-site
- register page
- form validation
- success/error states
- auth store update after success
- header state update after success

### frontend-admin
No direct impact.

---

## States

### Happy state
New user registers and becomes authenticated.

### Duplicate email state
Registration is rejected.

### Validation error state
Invalid payload is rejected.

### Error state
Backend failure is shown.

---

## Error cases

- duplicate email
- invalid email format if validated
- weak or invalid password according to chosen validation rules
- backend unavailable
- inconsistent auth payload after creation

---

## Validation

### Acceptance references
- `AC-auth`

### Tests
- `TEST-auth-register-success`
- `TEST-auth-register-duplicate-email`
- `TEST-auth-register-password-is-hashed`
- `TEST-ui-site-register-renders`

---

## Related documents

- `FEAT-auth-login`
- `XCUT-authz`
- `ADR-005-jwt-auth`
- `SLICE-002-auth-foundation`

---

## Future extensions

Potential later evolution:
- email verification
- stronger password policy
- captcha / abuse protection
- profile setup after register
