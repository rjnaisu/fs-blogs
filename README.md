# Blog List App

Full stack blog list app with a React + Vite frontend and an Express + MongoDB backend.

## Structure

```text
fs-blogs/
├── blogs/              # backend
├── bloglist-frontend/  # frontend
├── package.json        # root scripts
└── pnpm-workspace.yaml
```

## Setup

Install dependencies from the repo root:

```bash
pnpm install
```

Create `blogs/.env`:

```env
PORT=3001
MONGODB_URI=mongodb://127.0.0.1:27017/bloglist
TEST_MONGODB_URI=mongodb://127.0.0.1:27017/bloglist_test
SECRET=replace-this-with-a-real-secret
```

## Root Scripts

Run both backend and frontend in development:

```bash
pnpm dev
```

Run one app:

```bash
pnpm dev:backend
pnpm dev:frontend
```

Check, test, and build:

```bash
pnpm lint
pnpm test
pnpm test:e2e
pnpm build
```

Start the production backend:

```bash
pnpm start
```

The frontend dev server runs on Vite's default port and proxies `/api` to the backend on `http://localhost:3001`.
