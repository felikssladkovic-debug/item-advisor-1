# Change Request Template

## Header
- ID: `CR-YYYY-MM-DD-XXX`
- Title:
- Status: `Draft | Approved | In Progress | Done | Rejected`
- Author:
- Date:
- Target slice(s):
- Target release / milestone:

---

## 1. Why

Describe why this change exists.

Questions this section should answer:
- what problem are we solving?
- who needs this?
- why now?
- what becomes better after this change?

---

## 2. Requested behavior

Describe the desired behavior in concise business language.

Prefer:
- observable behavior
- concrete outcomes
- actor-based wording

Avoid:
- vague technical wishes
- implementation assumptions without behavioral meaning

---

## 3. Scope

### Included
- 
- 
- 

### Excluded
- 
- 
- 

This section protects the change from uncontrolled growth.

---

## 4. Affected actors

List all actors touched by the change.

Example:
- Anonymous user
- Authenticated user
- Manager

---

## 5. Affected conceptual documents

List conceptual documents that must be updated.

Example:
- `01-conceptual/01-vision.md`
- `01-conceptual/05-business-rules.md`

---

## 6. Affected feature packets

List feature and cross-cutting documents touched by this change.

Example:
- `FEAT-auth-login`
- `FEAT-user-cabinet`
- `XCUT-authz`

---

## 7. New or changed business rules

List new rules or changed rules.

Example:
- `RULE-auth-007`: ...
- `RULE-review-011`: ...

If an existing rule changes, explicitly state old behavior and new behavior.

---

## 8. Affected API contracts

List contract documents and endpoint identifiers.

Example:
- `API-public-auth-login`
- `API-admin-review-approve`

Include:
- new endpoints
- changed request shapes
- changed response shapes
- changed error behavior

---

## 9. Affected UI surfaces

List relevant UI surfaces.

Example:
- `UI-site-login-page`
- `UI-admin-review-details-page`

For each affected surface, describe:
- what user-visible change happens
- what new state must be handled
- what validation or messaging changes appear

---

## 10. Affected data model

Describe collections, fields, indexes, read-models, or storage concerns touched by this change.

Example:
- canonical collection changes
- read-model changes
- new derived fields
- seed changes
- migration implications

---

## 11. Architecture impact

State whether this is:
- no architecture impact
- minor architecture impact
- significant architecture impact

If architecture impact exists, specify:
- affected ADRs
- whether a new ADR is required
- what architectural tradeoff changed

---

## 12. Validation impact

List validation assets that must be updated or created.

### Acceptance
- `AC-...`

### BDD
- `...feature`

### Tests
- `TEST-...`

### Checklists
- demo or regression checklist impact

---

## 13. Code impact estimate

List likely code areas to touch.

Example:
- `backend-public-api/...`
- `backend-admin-api/...`
- `backend-shared/...`
- `frontend-site/...`
- `frontend-admin/...`

This is not required to be perfect, but should guide implementation.

---

## 14. Prompt packet for coding agent

Provide a concise implementation packet for Codex or another coding agent.

Recommended structure:
1. objective
2. touched areas
3. behavioral constraints
4. required tests
5. forbidden shortcuts
6. done conditions

---

## 15. Done when

List objective completion criteria.

Example:
- new behavior is implemented
- affected spec files are updated
- tests pass
- regression checklist updated
- no known contradiction remains between spec and code

---

## 16. Notes and open questions

Capture unresolved issues separately from the main requested behavior.

Use this section to prevent ambiguity from silently leaking into implementation.
