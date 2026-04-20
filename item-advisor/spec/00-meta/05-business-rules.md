# Business Rules

## Purpose

This document defines stable product rules that describe intended system behavior independently of code details.

Rules in this document are referenced by feature documents, validation documents, and change requests.

---

## Publication and visibility rules

### RULE-public-001
Public catalog shows only Items with status `PUBLISHED`.

### RULE-public-002
Items in status `DRAFT` must not appear in public catalog results.

### RULE-public-003
Public item details must only be available for `PUBLISHED` Items.

### RULE-public-004
Public API must not expose admin-only fields.

---

## Review visibility and moderation rules

### RULE-review-001
A newly created review always starts with status `PENDING`.

### RULE-review-002
Only reviews with status `APPROVED` are visible on public item pages.

### RULE-review-003
A manager may change review status from `PENDING` to `APPROVED`.

### RULE-review-004
A manager may change review status from `PENDING` to `DECLINED`.

### RULE-review-005
Declining a review requires non-empty `decline_reason`.

### RULE-review-006
Moderation action may optionally include `manager_comment`.

### RULE-review-007
Moderation action must set `moderated_at`.

### RULE-review-008
Moderation action must set `moderated_by`.

### RULE-review-009
Authenticated user cabinet must display all reviews submitted by that user, regardless of moderation status.

### RULE-review-010
User cabinet must show moderation result fields when available, including `manager_comment` and `decline_reason`.

---

## Authentication and authorization rules

### RULE-auth-001
Public register route creates a standard `USER` account.

### RULE-auth-002
Public login route authenticates end users and returns an access token for public authenticated routes.

### RULE-auth-003
Admin login route authenticates only `MANAGER` users.

### RULE-auth-004
Protected public routes require authenticated `USER` or compatible authenticated identity.

### RULE-auth-005
Protected admin routes require authenticated `MANAGER`.

### RULE-auth-006
Passwords must never be stored in plain text.

---

## Data synchronization rules

### RULE-readmodel-001
Admin API owns canonical write operations for item management.

### RULE-readmodel-002
Public API reads from public read-model collections for catalog and item details.

### RULE-readmodel-003
Read-model synchronization must happen after item create.

### RULE-readmodel-004
Read-model synchronization must happen after item update.

### RULE-readmodel-005
Read-model synchronization must happen after item delete.

### RULE-readmodel-006
Read-model synchronization must happen after review moderation when public aggregates are affected.

### RULE-readmodel-007
Only `PUBLISHED` Items may exist in public read-model collections.

### RULE-readmodel-008
Only `APPROVED` reviews may affect public rating aggregates.

---

## Review photo rules

### RULE-photo-001
Review photo upload is optional.

### RULE-photo-002
A review may contain at most 3 uploaded photos in MVP.

### RULE-photo-003
Only valid image files may be accepted.

### RULE-photo-004
Uploaded review photos must be stored in local storage for MVP.

### RULE-photo-005
Uploaded review photos must become accessible through public static URLs.

---

## Startup and seed rules

### RULE-seed-001
System startup must ensure required collections and indexes exist.

### RULE-seed-002
System startup must seed one manager account if absent.

### RULE-seed-003
System startup must seed one normal user account if absent.

### RULE-seed-004
System startup must seed at least 3 sample Items if absent.

### RULE-seed-005
At least 2 seeded Items must be `PUBLISHED`.

### RULE-seed-006
System startup must seed sample reviews in mixed statuses if absent.

### RULE-seed-007
System startup must build or rebuild public read-model data for seeded records when necessary.

---

## API behavior rules

### RULE-api-001
All application APIs use JSON except where file upload requires multipart form submission.

### RULE-api-002
Application APIs must use `/api/v1` prefix.

### RULE-api-003
Missing resource returns `404`.

### RULE-api-004
Authentication failure returns `401` or `403` according to context.

### RULE-api-005
Invalid input returns `400` or schema validation error response.

### RULE-api-006
Error responses must have a consistent structured shape.

---

## Runtime rules

### RULE-runtime-001
The full MVP must run locally with a single command.

### RULE-runtime-002
Public site, admin panel, public API, admin API, and MongoDB must all be available through local Docker-based startup.

### RULE-runtime-003
Static review photo serving must work in the local Docker-based runtime.
