# Spec Repository for ItemAdvisor

## Purpose

This `spec/` directory is the primary structured knowledge base for the ItemAdvisor project.

Its purpose is to preserve alignment between:

- product idea
- English specification
- architecture decisions
- API contracts
- validation rules
- generated or manually edited code
- future incremental changes

The goal is not only to bootstrap the MVP once, but to support long-term evolution without losing coherence.

## Core principle

Prompts are **not** the primary source of truth.

Primary source of truth lives in structured specification documents:

- conceptual documents
- delivery slices
- feature packets
- cross-cutting concern documents
- ADRs
- acceptance and BDD validation documents
- change requests

Prompts for Codex or other coding agents are **derived artifacts** assembled from these documents.

## Directory structure

- `00-meta/` — rules for maintaining the spec system itself
- `01-conceptual/` — product meaning, domain understanding, business rules, high-level architecture
- `02-delivery/` — incremental build order using vertical slices
- `03-features/` — bounded feature packets and cross-cutting concerns
- `04-contracts/` — formal API and schema contracts
- `05-architecture/` — ADRs and architecture views
- `06-validation/` — acceptance criteria, BDD scenarios, checklists
- `07-change/` — change requests, impact records, change tracking
- `08-prompts/` — generated or curated prompts for coding agents

## Document classes

### Primary documents
These documents are edited first when behavior changes:

- conceptual docs
- feature docs
- cross-cutting docs
- ADRs
- acceptance docs
- change requests

### Derived documents
These documents are assembled from primary documents:

- full-build prompts
- incremental prompts
- review prompts
- generated summaries
- generated implementation packets

## Editing rule

If product behavior changes, do **not** edit only a prompt.

Instead:

1. update primary spec documents
2. update validation expectations
3. update ADR if architecture changed
4. regenerate or rewrite agent prompt from updated spec
5. implement code changes
6. verify against validation documents

## Audience

This spec repository is intentionally useful for several types of participants:

- product owner
- analyst
- architect
- implementation engineer
- QA / reviewer
- AI coding agent

Each audience reads a different projection of the same system, but all projections must remain traceable to one another.

## Quality bar

This spec repository must stay:

- structured
- explicit
- non-contradictory
- implementation-aware
- validation-aware
- suitable for AI-assisted development

## What this repository is not

This repository is not:

- a dumping ground for random notes
- a duplicate of source code
- a single giant prompt
- a replacement for tests
- a replacement for architecture decisions

It is the coordination layer between idea, specification, implementation, and validation.
