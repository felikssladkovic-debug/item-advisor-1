# Domain Model

## Purpose

This document defines the core domain objects of ItemAdvisor at the product and system level.

It is intentionally more stable than implementation details and more structured than a narrative description.

The domain model is the shared semantic reference for:

- product understanding
- feature packets
- API contracts
- persistence model
- validation
- future change requests

---

## Domain overview

ItemAdvisor revolves around a curated catalog of unusual places called **Items**.

Users can browse these Items publicly.

Authenticated users can contribute **Reviews**.

Managers can manage Items and moderate Reviews.

The public-facing experience is not built directly from all canonical domain data.
Instead, public rendering relies on public read-model projections derived from canonical records.

---

## Core domain objects

### 1. Item

#### Meaning
An Item is a place of interest in the ItemAdvisor domain.

It represents a place that is unusual, spiritually significant, mysterious, legendary, myth-related, occult-associated, or otherwise perceived as culturally charged.

#### Responsibilities in the system
- acts as the main public catalog entity
- acts as the main details-page entity
- receives user reviews
- carries publication status
- contributes to public discovery experience

#### Core attributes
- identity
- URL slug
- title
- short description
- full description
- location fields
- tags
- publication status
- hero image URL
- timestamps

#### Important states
- `DRAFT`
- `PUBLISHED`

#### Key invariants
- slug must uniquely identify the Item in public routes
- public catalog must only expose `PUBLISHED` Items
- public item details must only expose `PUBLISHED` Items
- Item data used for public rendering must be safe for public exposure

---

### 2. User

#### Meaning
A User is an authenticated identity stored by the system.

In the MVP there are two role variants:
- standard end user
- manager

#### Responsibilities in the system
- authenticate into the system
- own submitted reviews
- determine authorization scope

#### Core attributes
- identity
- email
- password hash
- role
- creation timestamp

#### Role variants
- `USER`
- `MANAGER`

#### Key invariants
- email must be unique
- password must never be stored in plain text
- manager access must be role-restricted

---

### 3. Review

#### Meaning
A Review is user-contributed feedback attached to an Item.

It expresses the user’s experience or opinion and may include a rating, text, and optional photos.

#### Responsibilities in the system
- support contribution flow
- support moderation flow
- affect public Item aggregates when approved
- provide visible social proof on public item page

#### Core attributes
- identity
- Item reference
- User reference
- rating
- text
- optional photos
- moderation status
- manager comment
- decline reason
- timestamps
- moderator identity reference

#### Important states
- `PENDING`
- `APPROVED`
- `DECLINED`

#### Key invariants
- newly submitted review starts as `PENDING`
- only `APPROVED` reviews appear publicly
- decline requires textual reason
- moderation stores timestamp and moderator identity
- only approved reviews affect public aggregates

---

## Derived / projected domain objects

These are not canonical business entities in the same sense as Item, User, and Review.
They are system projections used for public rendering.

### 4. Public Item Card

#### Meaning
A public read-model projection optimized for catalog page rendering.

#### Responsibilities
- serve public catalog endpoint efficiently
- expose only public-safe Item data
- carry aggregate review summary values

#### Derived from
- canonical Item
- approved Reviews for that Item

#### Typical fields
- slug
- title
- short description
- location summary
- tags
- hero image URL
- approved reviews count
- average rating
- updated timestamp

---

### 5. Public Item Details

#### Meaning
A public read-model projection optimized for item details page rendering.

#### Responsibilities
- serve public details endpoint efficiently
- expose full public-safe details for one Item
- carry public aggregates

#### Derived from
- canonical Item
- approved Reviews for that Item

#### Typical fields
- all public descriptive Item fields
- review summary aggregates
- updated timestamp

---

## Relationships

### Item ↔ Review
One Item can have many Reviews.

Each Review belongs to exactly one Item.

### User ↔ Review
One User can create many Reviews.

Each Review belongs to exactly one User.

### Manager ↔ Review moderation
A manager may moderate many Reviews.

A moderated Review references the manager who performed the moderation action.

### Item ↔ Public read-models
One canonical Item may have:
- one public item card projection when published
- one public item details projection when published

If the Item is not published, it must not be represented in public read-model collections.

---

## Domain boundaries

### Public domain boundary
Public site concerns:
- browse published Items
- inspect published Item details
- inspect approved Reviews
- authenticate as standard user
- submit review
- inspect own review statuses

### Admin domain boundary
Admin concerns:
- manage canonical Item data
- inspect incoming reviews
- approve reviews
- decline reviews
- inspect dashboard summary

### Shared domain boundary
Both contexts rely on:
- settings
- auth helpers
- common schemas
- serialization helpers
- read-model synchronization utilities

---

## Domain events worth thinking about

The MVP does not require a formal event system, but the following domain events conceptually exist:

- `ItemCreated`
- `ItemUpdated`
- `ItemDeleted`
- `ItemPublished`
- `ItemUnpublished`
- `ReviewSubmitted`
- `ReviewApproved`
- `ReviewDeclined`

These events are important because they imply downstream synchronization and validation behavior.

---

## Public truth vs canonical truth

### Canonical truth
Canonical truth is stored in:
- `items`
- `users`
- `reviews`

This is the authoritative source for management and moderation workflows.

### Public truth
Public truth is served through:
- `public_item_cards`
- `public_item_details`
- approved review queries

This is the read-optimized public delivery model.

---

## Domain model consequences

The ItemAdvisor MVP is not just CRUD around one table-like entity.

It is a domain with:
- publication state
- moderation state
- role boundaries
- projection logic
- public-safe rendering constraints

This means the domain model must be reflected consistently in:
- API contracts
- feature packets
- read-model synchronization rules
- validation documents
- architecture decisions
