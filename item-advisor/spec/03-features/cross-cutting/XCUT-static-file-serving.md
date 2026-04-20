# XCUT-static-file-serving

## Purpose

Define the MVP behavior for uploaded review photo storage and public serving.

This is a cross-cutting concern because it affects:

- review submission
- public item page image rendering
- local runtime layout
- Docker volume wiring
- validation and demo behavior

---

## Problem statement

ItemAdvisor MVP supports optional review photo uploads.

This means the system must handle two distinct but connected concerns:

1. storing uploaded image files
2. making stored files accessible through usable URLs

A review feature is incomplete if file upload exists only as metadata persistence without real accessible file serving.

---

## MVP decision

For MVP, review photos are stored in local file storage and exposed via static file serving through the public API runtime.

This is intentionally simple and local-runtime friendly.

---

## Scope

### Included
- local directory for stored review photos
- validation of image file types
- max photo count handling
- generation of usable stored file paths / URLs
- public static serving of stored files
- Docker-mounted persistence path for local runtime

### Excluded
- object storage
- CDN
- image resizing pipeline
- virus scanning
- background media processing
- signed URL system
- media deletion workflows

---

## Business rules

- `RULE-photo-001`: review photo upload is optional
- `RULE-photo-002`: a review may contain at most 3 photos
- `RULE-photo-003`: only valid image files may be accepted
- `RULE-photo-004`: uploaded review photos must be stored in local storage for MVP
- `RULE-photo-005`: uploaded review photos must become accessible through public static URLs
- `RULE-runtime-003`: static review photo serving must work in local Docker runtime

---

## Runtime model

### Storage location
Files are stored under the repository storage path intended for review photos.

Expected logical location:
- `/storage/review-photos`

### Serving path
Public API exposes stored files via static file serving.

### Runtime dependency
Docker-based local runtime must mount storage so that uploads survive container restarts according to local dev expectations.

---

## Interaction with features

### FEAT-review-submit
Needs:
- upload validation
- file persistence
- stored photo references in Review record

### FEAT-item-details
Needs:
- usable photo URLs for approved publicly visible reviews

### FEAT-admin-review-moderation
Needs:
- review details page can display uploaded photos for moderation

---

## Failure behavior expectations

- non-image upload is rejected
- too many photos are rejected
- file write failure is surfaced as visible error
- stored path generation must not produce broken URLs
- static serving configuration failure must be visible in runtime testing

---

## Validation expectations

The following behaviors must be testable:

- valid image upload succeeds
- non-image upload fails
- more than allowed photos fail
- stored photo path is persisted in review record
- stored photo URL is actually reachable in local runtime

---

## Related documents

- `FEAT-review-submit`
- `FEAT-item-details`
- `FEAT-admin-review-moderation`
- `AC-reviews`
- `SLICE-005-user-reviews`

---

## Future evolution

Possible later evolution:
- object storage backend
- derivative image generation
- media cleanup workflows
- moderation-aware media visibility policies
- CDN-based serving
