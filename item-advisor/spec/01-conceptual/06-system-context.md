# System Context

## Purpose

This document describes ItemAdvisor from the outside and places it into a system context that is understandable for product, architecture, implementation, and AI-assisted development.

It answers:

- what the system is
- who interacts with it
- what major external/runtime dependencies it has
- what internal application contexts it contains

This is the “boundary map” of the MVP.

---

## System under consideration

**ItemAdvisor** is a web application for discovering unusual places and managing user-contributed reviews around them.

The system includes:

- a public website for discovery and contribution
- an admin panel for content management and moderation
- two backend APIs
- a shared backend library
- MongoDB
- local file storage for uploaded review photos

---

## Primary human actors

### Anonymous visitor
Uses public site for:
- browsing catalog
- opening Item pages
- deciding whether to register

### Authenticated user
Uses public site for:
- browsing
- submitting reviews
- checking review statuses in cabinet

### Manager
Uses admin panel for:
- managing Items
- moderating Reviews
- checking admin summary state

---

## Internal application contexts

### Public web context
Contains:
- catalog browsing
- item details
- register/login
- review submission
- user cabinet

### Admin web context
Contains:
- manager login
- dashboard
- item CRUD
- review moderation

### Public API context
Supports:
- public read behavior
- authenticated public user actions

### Admin API context
Supports:
- manager-only operational behavior

### Shared backend context
Contains shared logic used by both APIs.

---

## Runtime dependencies

### MongoDB
Purpose:
- store canonical collections
- store public read-model collections

Why it matters:
- central persistence and projection baseline

### Local file storage
Purpose:
- store uploaded review photos for MVP

Why it matters:
- review submission is not complete without actual file storage behavior

### Docker / docker-compose runtime
Purpose:
- provide reproducible local startup

Why it matters:
- runtime reproducibility is part of project truth, not only convenience

---

## Internal structural elements

### Canonical data model
Canonical operational data lives in:
- `items`
- `users`
- `reviews`

### Public projection model
Public rendering data lives in:
- `public_item_cards`
- `public_item_details`

### Projection principle
Public site must not depend directly on raw operational shape when a dedicated public projection exists.

---

## High-level interaction map

### Discovery flow
Anonymous or authenticated user:
1. opens public catalog
2. filters/searches Items
3. opens item details
4. reads approved reviews

### Contribution flow
Authenticated user:
1. logs in
2. opens published Item
3. submits review with optional photos
4. later opens cabinet to inspect moderation result

### Moderation flow
Manager:
1. logs into admin panel
2. opens review queue
3. inspects review
4. approves or declines it
5. public state and user-visible state are updated accordingly

### Content management flow
Manager:
1. logs into admin panel
2. creates or edits Item
3. adjusts publication status
4. public projections update accordingly

---

## System boundaries

### Inside ItemAdvisor
- public site
- admin panel
- public API
- admin API
- shared backend package
- MongoDB persistence layout
- review photo storage behavior
- local runtime behavior

### Outside ItemAdvisor
The MVP does not yet include:
- external SSO provider
- external object storage
- external CDN
- email provider
- background job platform
- third-party editorial systems

These may appear later but are out of scope for MVP.

---

## Security boundaries

### Public boundary
Public site and public API must remain safe for anonymous consumption and authenticated public use.

### Admin boundary
Admin panel and admin API must be manager-only.

### Data boundary
Admin-only data must not leak into public delivery payloads.

---

## System intent summary

ItemAdvisor MVP is a deliberately small but structurally serious product.

Its system context is defined by three main design forces:

1. public discovery
2. controlled user contribution
3. manager-curated publication and moderation

These forces explain why the system contains:
- separate public/admin surfaces
- separate public/admin APIs
- canonical data plus public projections
- authz boundaries
- real runtime infrastructure even in MVP
