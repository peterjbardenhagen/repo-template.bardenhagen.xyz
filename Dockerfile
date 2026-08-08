# Use an official runtime as the base image
# Replace with your project's actual base image and build steps.
# Node 20 LTS is the current stable baseline; adjust to match your project's engine.
FROM node:25-alpine AS base

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
# The template has no package.json — guard so the image still builds.
RUN if [ -f package.json ]; then npm ci --only=production; else echo "No package.json — skipping npm ci"; fi

# Copy application code
COPY . .

# Build the application
# The template has no build script — guard so the image still builds.
RUN if [ -f package.json ] && jq -e '.scripts.build' package.json >/dev/null 2>&1; then npm run build; else echo "No build script — skipping npm run build"; fi

# Production stage
FROM node:25-alpine AS production
WORKDIR /app

COPY --from=base /app/node_modules ./node_modules
COPY --from=base /app/dist ./dist
COPY --from=base /app/package*.json ./

EXPOSE 3000

CMD ["node", "dist/index.js"]
