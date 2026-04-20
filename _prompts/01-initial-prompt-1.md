You are generating a FULL working monorepo from scratch.

Project name: item-advisor

Goal:
Build an MVP web application conceptually similar to TripAdvisor, but focused on unusual places:
- places respected in spiritual traditions
- mysterious / legendary / occult / myth-related places

These entities are called "Item".

Important:
This is NOT a toy scaffold.
Generate a complete, runnable MVP with scalable architecture decisions so the project can later evolve toward a much larger product.

The system must consist of:
1) public website
2) admin panel
3) public backend API
4) admin backend API
5) shared backend library
6) MongoDB
7) local file storage for uploaded review photos (for MVP)

Everything must run locally with a single command.

Do NOT ask questions.
Do NOT leave TODOs.
Do NOT use placeholders.
Generate complete working code.

==================================================
1. STRICT TECH STACK (NO ALTERNATIVES)
==================================================

Frontend:
- Vue 3
- Vite
- Tailwind CSS
- PrimeVue v4
- Vue Router
- Pinia
- Axios

Backend:
- Python 3.12
- FastAPI
- Pydantic
- Motor (async MongoDB driver)
- PyJWT or python-jose for JWT
- passlib/bcrypt for password hashing

Database:
- MongoDB

Testing:
- Backend: pytest
- Frontend: Vitest
- Use simple but real integration tests where possible

Infra:
- Docker
- docker-compose

==================================================
2. ARCHITECTURE PRINCIPLES
==================================================

Use a monorepo with clear separation between:
- public API (serves public website and authenticated end-user cabinet)
- admin API (serves admin panel and moderation / management workflows)
- shared backend library (models, config, db utilities, auth helpers, common schemas)

Scalability-oriented architecture:
- public API must read from read-model collections optimized for public site rendering
- admin API writes canonical collections and refreshes / synchronizes public read-model collections
- public API must NOT expose admin-only fields
- admin API must support CRUD, moderation, pagination, filtering

For MVP keep everything in one MongoDB database, but with clean separation in code.

==================================================
3. MONOREPO STRUCTURE (STRICT)
==================================================

Create this structure:

/item-advisor
  /backend-shared
  /backend-public-api
  /backend-admin-api
  /frontend-site
  /frontend-admin
  /infra
    /mongo-init
  /storage
    /review-photos
  docker-compose.yml
  README.md

==================================================
4. DOMAIN MODEL
==================================================

The application has 3 main actor types:

1) Anonymous user
- browse catalog
- open item page
- register
- login

2) Authenticated user
- browse catalog
- open item page
- submit review for item
- open personal cabinet
- see own reviews, their statuses, manager decision, decline reason
- upload review photos

3) Manager
- login to admin panel
- search items with filters and pagination
- create/edit/delete items
- browse new reviews
- open review details
- approve review
- decline review with required textual reason

==================================================
5. DATA MODEL (MONGODB)
==================================================

Use these canonical collections:

5.1 items
{
  _id: ObjectId,
  slug: string,                  // unique, URL-friendly
  title: string,
  short_description: string,
  full_description: string,
  country: string,
  region: string,
  location_label: string,
  tags: string[],
  status: "DRAFT" | "PUBLISHED",
  hero_image_url: string | null,
  created_at: datetime,
  updated_at: datetime
}

5.2 users
{
  _id: ObjectId,
  email: string,                // unique
  password_hash: string,
  role: "USER" | "MANAGER",
  created_at: datetime
}

5.3 reviews
{
  _id: ObjectId,
  item_id: ObjectId,
  user_id: ObjectId,
  rating: integer,              // 1..5
  text: string,
  photos: string[],             // public URLs or relative URLs for uploaded photos
  status: "PENDING" | "APPROVED" | "DECLINED",
  manager_comment: string | null,
  decline_reason: string | null,
  created_at: datetime,
  moderated_at: datetime | null,
  moderated_by: ObjectId | null
}

Also create read-model collections for public API:

5.4 public_item_cards
Optimized for catalog page:
{
  _id: ObjectId,
  slug: string,
  title: string,
  short_description: string,
  country: string,
  region: string,
  location_label: string,
  tags: string[],
  hero_image_url: string | null,
  approved_reviews_count: integer,
  average_rating: number | null,
  updated_at: datetime
}

5.5 public_item_details
Optimized for item page:
{
  _id: ObjectId,
  slug: string,
  title: string,
  short_description: string,
  full_description: string,
  country: string,
  region: string,
  location_label: string,
  tags: string[],
  hero_image_url: string | null,
  approved_reviews_count: integer,
  average_rating: number | null,
  updated_at: datetime
}

Read-model behavior:
- admin API owns canonical writes
- after item create/update/delete or review moderation, synchronize affected read-model documents
- public API reads only from read-model collections plus approved reviews
- only PUBLISHED items appear on public site

==================================================
6. AUTH AND SECURITY
==================================================

Implement JWT authentication.

Requirements:
- password hashing with bcrypt
- short-lived access token is sufficient for MVP
- role-based protection
- backend-public-api supports:
  - anonymous routes
  - authenticated USER routes
- backend-admin-api supports:
  - authenticated MANAGER routes only

Seed one manager account:
- email: manager@example.com
- password: manager123

Seed one normal user account:
- email: user@example.com
- password: user123

==================================================
7. STARTUP / SEED LOGIC
==================================================

On startup:
- connect to MongoDB
- create indexes
- ensure required collections exist
- seed initial users if absent
- seed at least 3 sample items if absent
- at least 2 items must be PUBLISHED
- seed several reviews in mixed statuses if absent
- build / rebuild read-model documents for seeded data if absent

Sample content should feel realistic to the product theme:
examples of mysterious / spiritual / legendary locations.

==================================================
8. API DESIGN
==================================================

Use JSON everywhere.
Use /api/v1 prefix.
Return structured error responses.
Use Pydantic schemas for request/response models.

--------------------------------------------------
8.1 PUBLIC API
--------------------------------------------------

Service name: backend-public-api

Base path:
- /api/v1

Health:
GET /health
Response:
{
  "service": "public-api",
  "mongo_ok": true,
  "items_published_count": 2,
  "timestamp": "..."
}

Auth:
POST /api/v1/auth/register
Request:
{
  "email": "user@example.com",
  "password": "secret123"
}
Response:
{
  "access_token": "...",
  "token_type": "bearer",
  "user": {
    "id": "...",
    "email": "user@example.com",
    "role": "USER"
  }
}

POST /api/v1/auth/login
Same response format.

Catalog:
GET /api/v1/items
Supports query params:
- page
- page_size
- q                 // search in title and short_description
- tag
- country
- region

Response:
{
  "items": [...],
  "page": 1,
  "page_size": 10,
  "total": 123
}

Item details:
GET /api/v1/items/{slug}
Response includes:
- item detail data
- summary stats
- latest approved reviews (first page)
- pagination metadata for reviews

Approved reviews listing:
GET /api/v1/items/{slug}/reviews
Query params:
- page
- page_size
Response:
{
  "reviews": [...],
  "page": 1,
  "page_size": 10,
  "total": 42
}

Authenticated user routes:
POST /api/v1/reviews
Multipart/form-data or JSON + file upload support.
For MVP, support:
- item_id
- rating
- text
- optional photos (up to 3 files)
Behavior:
- created review status = PENDING

GET /api/v1/reviews/my
Return current user's reviews sorted newest first with:
- item summary
- status
- manager_comment
- decline_reason
- created_at

GET /api/v1/me
Return current authenticated user info.

--------------------------------------------------
8.2 ADMIN API
--------------------------------------------------

Service name: backend-admin-api

Base path:
- /api/v1

Health:
GET /health
Response:
{
  "service": "admin-api",
  "mongo_ok": true,
  "items_total": 3,
  "reviews_pending": 2,
  "timestamp": "..."
}

Admin auth:
POST /api/v1/auth/login
Only manager login needed here.
Return JWT token and user info.

Admin items:
GET /api/v1/admin/items
Supports:
- page
- page_size
- q
- status
- tag
- country
- region

POST /api/v1/admin/items
PUT /api/v1/admin/items/{id}
DELETE /api/v1/admin/items/{id}
GET /api/v1/admin/items/{id}

When item changes:
- synchronize read-model if needed

Admin reviews:
GET /api/v1/admin/reviews
Supports:
- page
- page_size
- status
- item_id
- q

GET /api/v1/admin/reviews/{id}

POST /api/v1/admin/reviews/{id}/approve
Request:
{
  "manager_comment": "optional comment"
}

POST /api/v1/admin/reviews/{id}/decline
Request:
{
  "decline_reason": "required text",
  "manager_comment": "optional comment"
}

Rules:
- approve changes status to APPROVED
- decline changes status to DECLINED
- decline_reason is mandatory for decline
- moderation updates moderated_at and moderated_by
- moderation refreshes affected public read-model aggregates

Admin dashboard summary:
GET /api/v1/admin/dashboard/summary
Response example:
{
  "items_total": 3,
  "items_published": 2,
  "reviews_pending": 2,
  "reviews_approved": 5,
  "reviews_declined": 1
}

==================================================
9. FILE UPLOADS
==================================================

For MVP use local storage:
- save uploaded review photos into /storage/review-photos
- generate accessible URLs
- expose them via static file serving in public API
- keep implementation simple and working in docker-compose

Validation:
- max 3 photos per review
- allow common image extensions
- reject non-image files

==================================================
10. FRONTEND: PUBLIC SITE
==================================================

Service name: frontend-site

Create a Vue 3 app with these routes:

1) /
Catalog page
Features:
- search input
- filters: tag, country, region
- paginated item cards
- card shows title, short description, location, tags, rating summary
- click opens item page

2) /items/:slug
Item details page
Features:
- full description
- metadata
- list of approved reviews
- if logged in: review submission form
- review form fields:
  - rating
  - text
  - optional photo upload

3) /login
4) /register

5) /cabinet
Authenticated user cabinet
Features:
- list of current user's reviews
- for each review show:
  - item title
  - text
  - rating
  - status
  - manager comment if exists
  - decline reason if exists
  - created_at

Global layout:
- header
- main content
- footer

Header:
- app name ItemAdvisor
- links to catalog
- login/register or cabinet/logout depending on auth state

UI requirements:
- clean modern layout
- use PrimeVue v4 components where helpful
- use Tailwind for spacing/layout
- make pages usable, not barebones
- no broken navigation
- loading/error states must exist

==================================================
11. FRONTEND: ADMIN PANEL
==================================================

Service name: frontend-admin

Create a separate Vue 3 app with its own routes:

1) /login
Manager login

2) /
Admin dashboard
Show summary counters

3) /items
Table with filters, pagination, edit/delete actions

4) /items/new
Create item form

5) /items/:id
Edit item form

6) /reviews
Moderation queue/list with filters

7) /reviews/:id
Review details page with:
- review text
- photos
- author email if convenient
- item summary
- approve action
- decline action with required textarea for decline reason

Admin UX:
- protected routes
- if token missing -> redirect to login
- clear forms and table UX
- use PrimeVue v4 data table / form controls if helpful
- avoid deprecated PrimeVue v3 APIs

==================================================
12. SHARED BACKEND LIBRARY
==================================================

Create /backend-shared with reusable code:
- settings/config
- db connection helpers
- common Pydantic schemas
- auth helpers
- password hashing
- JWT helpers
- Mongo serialization helpers
- enums/constants
- read-model synchronization functions

Both backend services must import shared code cleanly.

==================================================
13. QUALITY REQUIREMENTS
==================================================

Code quality:
- typed Python where practical
- modular structure, not one giant file
- no duplicated business logic if it can live in shared layer
- clear folder structure
- sensible naming
- environment-based config with .env support
- include example env files if useful

Backend error handling:
- 404 for missing resources
- 401/403 for auth/permission errors
- 400 for invalid input
- consistent response shape for errors

==================================================
14. TESTS
==================================================

Implement real tests, not placeholders.

Backend tests:
For public API:
- /health works
- register/login works
- catalog returns published items
- item details returns expected item
- authenticated user can create review
- /reviews/my returns created review

For admin API:
- manager login works
- items CRUD works
- pending review listing works
- approve flow works
- decline flow requires reason
- moderation updates public aggregates

Frontend tests:
Public site:
- catalog page renders
- item page renders mocked data
- cabinet page renders mocked data

Admin:
- items table page renders
- reviews moderation page renders mocked data

Keep tests practical and runnable.

==================================================
15. DOCKER / INFRA
==================================================

Provide docker-compose.yml that runs:
- mongodb
- backend-public-api
- backend-admin-api
- frontend-site
- frontend-admin

Requirements:
- all services connected correctly
- environment variables configured
- mounted local storage for review photos
- frontend apps point to correct backend URLs
- everything starts with:

  docker-compose up --build

Expected local URLs:
- public site: http://localhost:3000
- admin panel: http://localhost:3001
- public API docs: http://localhost:8000/docs
- admin API docs: http://localhost:8001/docs

If ports need internal consistency, keep exactly these external ports.

==================================================
16. README
==================================================

Create a useful README.md with:
- project overview
- architecture explanation
- folder structure
- how to run locally
- seeded credentials
- service URLs
- test commands
- main API overview
- note explaining public read-model vs canonical collections

==================================================
17. IMPLEMENTATION DETAILS TO RESPECT
==================================================

Important functional rules:
- public catalog shows only PUBLISHED items
- public reviews show only APPROVED reviews
- newly created reviews are always PENDING
- manager can approve/decline reviews
- decline requires text reason
- user cabinet shows all user's reviews with statuses
- admin panel can manage items and moderation
- read-model synchronization must happen after relevant writes

Important generation rules:
- generate complete files
- no "left as exercise"
- no fake adapters
- no mock backend in actual app runtime
- app must be runnable

==================================================
18. FINAL OUTPUT EXPECTATION
==================================================

Generate the entire monorepo codebase exactly as specified.

The output must be a coherent repository that can be started locally and explored immediately.

Do not ask follow-up questions.
Do not reduce scope.
Do not simplify architecture.
Implement the project.
