# syntax = docker/dockerfile:1

# Adjust NODE_VERSION as desired
ARG NODE_VERSION=22
FROM node:${NODE_VERSION}-slim AS base

LABEL fly_launch_runtime="Node.js"

# Node.js app lives here
WORKDIR /app

# Set production environment
ENV NODE_ENV="production"
ENV PORT=3000
ENV CI=true

# Install pnpm
ARG PNPM_VERSION=10.24.0
RUN npm install -g pnpm@$PNPM_VERSION


# Throw-away build stage to reduce size of final image
FROM base AS build

# Install packages needed to build node modules
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential node-gyp pkg-config python-is-python3

# Install node modules
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY blogs/package.json blogs/package.json
COPY bloglist-frontend/package.json bloglist-frontend/package.json

RUN pnpm install --frozen-lockfile --prod=false

# Copy application code
COPY . .

# Build application
RUN pnpm run build

# Create a production-only copy of the backend workspace package
RUN pnpm --filter blogs deploy --prod --legacy /app/deploy


# Final stage for app image
FROM base

# Copy built application
COPY --from=build /app/deploy /app

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD [ "node", "index.js" ]
