# MVP Demo Checklist

## Purpose

This checklist is used to demonstrate that the ItemAdvisor MVP is working as a product, not only as a set of containers and endpoints.

The demo should show:
- public discovery
- public auth
- contribution
- manager moderation
- public-state change after moderation
- item management impact on public state

---

## Demo preparation

### DEMO-001
Start the system locally.

### DEMO-002
Ensure seeded data exists.

### DEMO-003
Know the two seeded credentials:
- manager: `manager@example.com / manager123`
- user: `user@example.com / user123`

### DEMO-004
Prepare one published Item and one pending Review if needed.

---

## Part 1: Public discovery

### DEMO-010
Open public catalog.

Show:
- item cards
- tags
- locations
- public-facing structure

### DEMO-011
Explain that only published Items appear publicly.

### DEMO-012
Open one Item details page.

Show:
- full description
- metadata
- approved reviews section
- public-safe rendering

---

## Part 2: Public authentication

### DEMO-020
Login as public user.

Show:
- successful login
- header state change
- cabinet visibility

### DEMO-021
Open cabinet.

Show:
- current user review history
- moderation statuses if data exists

---

## Part 3: Review contribution

### DEMO-030
Open a published Item details page while authenticated.

### DEMO-031
Show review submission form.

### DEMO-032
Submit a review with:
- rating
- text
- optional image file if supported in current build

### DEMO-033
Explain that new review starts as `PENDING`.

### DEMO-034
Return to cabinet and show the new pending review.

---

## Part 4: Admin moderation

### DEMO-040
Open admin panel in a separate session.

### DEMO-041
Login as manager.

### DEMO-042
Open admin reviews list.

### DEMO-043
Open the submitted pending review.

### DEMO-044
Approve the review or decline it with reason.

If declining:
- explicitly show that reason is required

---

## Part 5: Public impact of moderation

### DEMO-050
Return to public side.

If approved:
- show review now visible publicly
- show aggregate change if visible

If declined:
- show review is not public
- show cabinet now contains decline reason

---

## Part 6: Admin Item management

### DEMO-060
Open admin items list.

### DEMO-061
Create or edit an Item.

### DEMO-062
Change publication state if useful for demo.

### DEMO-063
Show public-side result:
- published Item appears
- draft Item disappears
- edited Item details are updated

---

## Part 7: Architecture explanation

### DEMO-070
Explain public/admin split.

### DEMO-071
Explain canonical vs public read-model split.

### DEMO-072
Explain why moderation exists between user submission and public visibility.

### DEMO-073
Explain that local runtime is fully reproducible with one startup command.

---

## Demo completion rule

The MVP demo is successful if an observer can clearly see:

- the product idea
- the public flow
- the authenticated contribution flow
- the manager flow
- the moderation boundary
- the public-state consequences of admin actions
