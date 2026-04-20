# Local Run Checklist

## Purpose

This checklist validates that the ItemAdvisor MVP really runs as a coherent local system.

It is not a substitute for automated tests.
It is the practical runtime checklist used after fresh startup or after major integration changes.

---

## Preconditions

- repository is present locally
- Docker is installed and usable
- required ports are available or intentionally remapped
- environment files are configured if required
- command used is the intended local startup command

---

## Startup checklist

### LR-001
Run the local startup command:
- `docker-compose up --build`

Expected:
- all intended services start
- no critical container crash loop remains

### LR-002
Confirm MongoDB container is running.

### LR-003
Confirm public API container is running.

### LR-004
Confirm admin API container is running.

### LR-005
Confirm frontend-site container is running.

### LR-006
Confirm frontend-admin container is running.

---

## Service URL checklist

### LR-010
Open public site:
- `http://localhost:3000`

Expected:
- site loads
- no blank page
- no fatal runtime error

### LR-011
Open admin panel:
- `http://localhost:3001`

Expected:
- admin frontend loads
- login page or routed admin shell appears

### LR-012
Open public API docs:
- `http://localhost:8000/docs`

Expected:
- docs page loads

### LR-013
Open admin API docs:
- `http://localhost:8001/docs`

Expected:
- docs page loads

---

## Health and seed checklist

### LR-020
Call public health endpoint.

Expected:
- service identity is correct
- Mongo health is positive
- published Item count is sensible

### LR-021
Call admin health endpoint.

Expected:
- service identity is correct
- Mongo health is positive
- item/review counts are sensible

### LR-022
Verify seeded manager credentials exist:
- `manager@example.com / manager123`

### LR-023
Verify seeded public user credentials exist:
- `user@example.com / user123`

### LR-024
Verify seeded sample Items exist.

### LR-025
Verify at least two seeded Items are publicly visible if configured as published.

---

## Public flow checklist

### LR-030
Open public catalog.

Expected:
- published Items are visible
- draft-only content is not visible publicly

### LR-031
Open a published Item details page.

Expected:
- item content renders
- approved reviews render if seeded

### LR-032
Register a new user or login with seeded public user.

Expected:
- authenticated state becomes visible in UI

### LR-033
Open cabinet as authenticated user.

Expected:
- cabinet route works
- user reviews appear if any exist

---

## Admin flow checklist

### LR-040
Login to admin panel with seeded manager account.

Expected:
- admin auth succeeds
- protected admin area becomes accessible

### LR-041
Open admin items list.

Expected:
- item list loads

### LR-042
Open admin reviews list.

Expected:
- review moderation list loads

---

## File storage checklist

### LR-050
Submit a review with valid image upload if review flow is implemented.

Expected:
- review creation succeeds
- stored photo path is recorded
- stored file is reachable via public static URL path

### LR-051
Inspect review photo storage directory or reachable static URL.

Expected:
- uploaded asset is really present and served

---

## Failure review checklist

### LR-060
If any step fails, capture:
- failing URL or action
- backend logs
- frontend console error if relevant
- whether failure is spec drift, code defect, or runtime config defect

---

## Completion rule

Local runtime is considered coherent only when:
- core services start
- public and admin surfaces load
- seed baseline exists
- core public/admin flows are reachable
- storage behavior works where implemented
