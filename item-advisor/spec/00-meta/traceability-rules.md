# Traceability Rules

## Purpose

This document defines how different artifacts in the ItemAdvisor spec repository connect to one another.

The goal is to preserve coherence between:

- conceptual understanding
- feature intent
- architecture decisions
- API behavior
- UI behavior
- data behavior
- validation
- prompts
- code changes

Without traceability, the repository becomes a pile of markdown files.
With traceability, it becomes an operational coordination system.

---

## Core principle

Every meaningful behavioral change should be traceable across at least these layers:

1. conceptual intent
2. feature or cross-cutting concern
3. validation expectation
4. implementation impact

If architecture changes, ADR traceability is also required.

---

## Primary traceability chain

Preferred chain:

`Conceptual docs -> Feature/XCUT docs -> Acceptance/BDD docs -> Prompt packets -> Code`

Optional additional chain:

`Feature/XCUT docs -> ADR docs -> Prompt packets -> Code`

---

## Minimum traceability requirements

### Requirement 1
Every `FEAT-*` document must reference:
- relevant business rules
- relevant validation docs
- related slice
- related ADRs when applicable

### Requirement 2
Every `XCUT-*` document must reference:
- affected features
- affected acceptance or BDD docs
- relevant ADRs

### Requirement 3
Every `AC-*` document should reference:
- the feature(s) or cross-cutting concern(s) it validates

### Requirement 4
Every `SLICE-*` document should reference:
- the feature packets it is expected to enable or depend on

### Requirement 5
Every `CR-*` document must list:
- affected conceptual docs
- affected feature/XCUT docs
- affected validation docs
- affected ADRs if any

### Requirement 6
Prompts must name the spec documents they rely on.
Prompts must never rely on undocumented memory alone.

---

## Traceability directions

### From conceptual to feature
Conceptual docs describe stable product/system truth.

Feature docs translate that truth into bounded implementation intent.

Example:
- `05-business-rules.md`
- `FEAT-review-submit.md`

### From feature to validation
Validation docs test whether feature behavior is real.

Example:
- `FEAT-admin-review-moderation.md`
- `AC-admin-moderation.md`
- `review-moderation.feature`

### From feature to architecture
When behavior depends on a structural decision, feature docs must point to relevant ADR.

Example:
- `FEAT-public-catalog.md`
- `ADR-003-canonical-vs-read-model.md`

### From change request to all impacted areas
A change request is the explicit trace bundle for a new change.

It must connect:
- why
- what changes
- what must be revalidated
- what architecture assumptions are touched

---

## Reference style

### Preferred reference style inside docs
Use identifier references in prose or bullet lists.

Good examples:
- `RULE-review-005`
- `FEAT-user-cabinet`
- `AC-reviews`
- `ADR-005-jwt-auth`

### Preferred “Related documents” section
Most feature and cross-cutting documents should end with:

- `Related documents`
- `Validation`
- `Future extensions`

This keeps trace structure predictable.

---

## Impact analysis rule

When a change is proposed, perform trace-based impact analysis.

At minimum ask:

1. Which business rules change?
2. Which features are affected?
3. Which cross-cutting concerns are affected?
4. Which acceptance or BDD docs must change?
5. Which ADRs are affected or required?
6. Which code areas are likely affected?

This is why `CR-*` documents exist.

---

## No-orphan rule

The following artifacts should not exist as orphans:

### Orphan feature
A `FEAT-*` doc without:
- business rules
- validation references
- related documents

### Orphan acceptance doc
An `AC-*` doc without a clear feature or concern being validated

### Orphan ADR
An ADR that no feature, slice, or change request ever refers to

### Orphan prompt
A prompt that does not cite the spec docs it depends on

---

## Allowed asymmetry

Not every conceptual document must point down to every feature.
That would create noise.

Traceability should be strongest in these directions:

- feature -> rules
- feature -> validation
- feature -> ADR
- change request -> impacted artifacts
- prompt -> source spec docs

This keeps the graph useful without making it unreadable.

---

## Code traceability

Code traceability does not need to be complete at all times, but should be added when useful.

Recommended places:
- `CR-*` documents
- `dependency-map.md`
- implementation summaries after agent changes

Useful examples:
- `backend-public-api/app/routes/items.py`
- `frontend-site/src/pages/CatalogPage.vue`
- `backend-shared/readmodels/sync.py`

---

## Prompt traceability rule

Every full-build or incremental prompt must contain a section like:

`Use these documents as the source of truth: ...`

This is mandatory.

A prompt without source-doc references is considered weakly grounded.

---

## Drift detection rule

When behavior in code appears to conflict with spec:

1. do not patch only the prompt
2. identify the primary artifact that should express the truth
3. update spec if product intent changed
4. update code if implementation drifted
5. update validation if expected behavior changed
6. record the change through a `CR-*` document when non-trivial

---

## Final principle

Traceability is not bureaucracy.

In this repository, traceability is the mechanism that keeps:

- English specification
- coding-agent work
- code
- tests
- runtime truth

from drifting apart.
