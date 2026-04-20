# Actors and Goals

## Overview

The ItemAdvisor MVP has three main actor types:

1. Anonymous user
2. Authenticated user
3. Manager

These actors have different capabilities, interfaces, and security boundaries.

---

## Actor: Anonymous user

### Description
A visitor who has not authenticated.

### Primary goals
- discover unusual places
- browse the catalog
- open item pages
- inspect approved reviews
- decide whether to register

### Allowed actions
- open public catalog
- use search and filters
- open public item details page
- read approved reviews
- open register page
- open login page

### Not allowed
- submit review
- open personal cabinet
- access admin panel
- access admin API routes

### Relevant UI surfaces
- public catalog page
- item details page
- login page
- register page

---

## Actor: Authenticated user

### Description
A standard end user authenticated in the public website context.

### Primary goals
- continue discovery
- contribute reviews
- track moderation status of own reviews

### Allowed actions
- do everything anonymous user can do
- submit review for item
- upload up to allowed number of review photos
- open personal cabinet
- inspect own submitted reviews
- inspect moderation status
- inspect decline reason and manager comment when present

### Not allowed
- access admin panel
- access manager-only endpoints
- edit items
- moderate reviews
- see admin-only item fields if such fields appear later

### Relevant UI surfaces
- public catalog page
- public item details page
- review submission form
- personal cabinet page
- header auth state / logout flow

---

## Actor: Manager

### Description
An internal operator responsible for content management and moderation.

### Primary goals
- manage item catalog
- inspect incoming reviews
- approve valid reviews
- decline invalid reviews with required reason
- maintain public-facing content quality

### Allowed actions
- login to admin panel
- use admin item list with filters and pagination
- create item
- edit item
- delete item
- inspect review queue
- inspect review details
- approve review
- decline review with textual reason
- inspect admin dashboard summary

### Not allowed
- use public manager-only shortcuts in place of admin security model
- bypass moderation requirements
- decline review without reason

### Relevant UI surfaces
- admin login page
- admin dashboard
- admin items table
- admin item create form
- admin item edit form
- admin reviews list
- admin review details page

---

## Security boundaries

### Public surface
Anonymous user and authenticated user operate through public site and public API.

### Admin surface
Manager operates through admin panel and admin API.

### Required separation
Public API must not expose admin-only fields.

Admin API must support management and moderation workflows.

Role protection is required at API and UI levels.

---

## Identity summary

| Actor | Authenticated | Role | Public site | Public API | Admin panel | Admin API |
|---|---:|---|---:|---:|---:|---:|
| Anonymous user | No | none | Yes | Anonymous routes only | No | No |
| Authenticated user | Yes | USER | Yes | USER routes allowed | No | No |
| Manager | Yes | MANAGER | Not primary workflow | Not primary workflow | Yes | Yes |

---

## Actor-based design consequence

The MVP is not only a set of pages and endpoints.

It is a permissioned system with two interaction contexts:

- public context for discovery and contribution
- admin context for management and moderation

This separation must be visible in code, routes, APIs, tests, and architecture.

