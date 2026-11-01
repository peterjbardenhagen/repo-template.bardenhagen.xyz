# Use an official Node runtime. Override the major version to match the target project.
FROM node:26-alpine AS base

RUN apk add --no-cache jq
WORKDIR /app

# Copy the repository first: package*.json is optional in this multi-stack template.
COPY . .

# Install production dependencies only when a Node manifest exists.
RUN if [ -f package.json ]; then \
      if [ -f package-lock.json ]; then npm ci --omit=dev; \
      else npm install --omit=dev; fi; \
    else echo "No package.json found; skipping npm dependency installation"; fi

# Run the build script when supplied. Keep a minimal health-serving entry point
# for an otherwise empty starter template so the image remains runnable.
RUN if [ -f package.json ] && jq -e '.scripts.build' package.json >/dev/null 2>&1; then npm run build; fi \
    && if [ ! -f dist/index.js ]; then \
         mkdir -p dist; \
         printf '%s\n' 'const http = require("node:http");' 'const server = http.createServer((_req, res) => { res.writeHead(200, { "content-type": "text/plain; charset=utf-8" }); res.end("Template container is running\\n"); });' 'server.listen(process.env.PORT || 3000, "0.0.0.0");' > dist/index.js; \
       fi

FROM node:26-alpine AS production
ENV NODE_ENV=production
WORKDIR /app

# Copy the complete prepared application; no optional paths are assumed.
COPY --from=base --chown=node:node /app /app
USER node
EXPOSE 3000
CMD ["node", "dist/index.js"]
