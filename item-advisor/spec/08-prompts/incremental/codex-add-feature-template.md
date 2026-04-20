# Codex Incremental Feature Prompt Template

## Purpose

This template is used to generate a constrained implementation packet for Codex when adding or modifying a single feature or a tightly related group of features.

The goal is to avoid vague free-form prompts and instead derive implementation work from the spec repository.

This prompt must be filled using current spec documents, not from memory.

---

## Template

You are working inside the ItemAdvisor monorepo.

Implement the requested change as a real code change across the existing repository.

Do not ask follow-up questions.
Do not reduce scope.
Do not leave TODOs.
Do not replace real behavior with mocks in runtime code.

### 1. Objective

Implement the following change:

`<short change statement>`

### 2. Business intent

`<why this behavior exists in product terms>`

### 3. Affected spec documents

Use these documents as the source of truth:

- `<conceptual docs>`
- `<feature docs>`
- `<cross-cutting docs>`
- `<acceptance docs>`
- `<ADR docs>`
- `<delivery slice docs if relevant>`

### 4. Affected services / apps

Touch only the areas required by this change:

- `<backend-public-api | backend-admin-api | backend-shared | frontend-site | frontend-admin | infra>`

### 5. Behavioral requirements

Implement all of the following behavior:

- `<behavior 1>`
- `<behavior 2>`
- `<behavior 3>`

### 6. Rules that must remain true

Do not violate these rules:

- `<RULE-...>`
- `<RULE-...>`
- `<RULE-...>`

### 7. API / UI / data implications

#### API
`<changed or added endpoints, params, request/response shape>`

#### UI
`<affected routes, pages, components, states>`

#### Data
`<affected collections, fields, projection logic, validation rules>`

### 8. Validation requirements

Update or add tests so that the following are covered:

- `<TEST-...>`
- `<TEST-...>`
- `<AC-...>`
- `<BDD file if relevant>`

### 9. Constraints

- keep architecture separation between public and admin contexts
- keep shared logic in backend-shared when appropriate
- do not bypass read-model synchronization if the feature affects public projections
- keep runtime working under docker-compose
- keep code modular and typed where practical
- preserve existing working behavior unless spec explicitly changes it

### 10. Required deliverables

Your output must include:

- implementation changes in code
- updated tests
- updated spec documents only if this prompt explicitly includes a spec-sync task
- any required config/env/example changes
- brief summary of changed files and behavior

### 11. Done conditions

The task is complete only when:

- requested behavior works in code
- relevant tests pass
- no required rule is violated
- no placeholder implementation remains
- runtime coherence is preserved

---

## Recommended fill pattern

When using this template, fill it with identifiers from spec-repo.

Example structure:

- Objective: `Implement manager item delete with public projection removal`
- Affected docs:
  - `FEAT-admin-item-crud`
  - `XCUT-read-model-sync`
  - `AC-admin-items`
  - `ADR-003-canonical-vs-read-model`
- Rules:
  - `RULE-readmodel-005`
  - `RULE-readmodel-007`
  - `RULE-auth-005`
- Tests:
  - `TEST-admin-item-delete`
  - `TEST-public-catalog-hides-deleted-item`

---

## Usage note

This template is intentionally strict.

It exists to keep Codex aligned with:
- business intent
- architecture intent
- validation intent
- runtime truth

rather than letting implementation drift from a loosely remembered prompt.
