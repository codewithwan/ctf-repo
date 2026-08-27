FROM node:20-alpine AS client-build

WORKDIR /build/client
COPY client/package.json client/package-lock.json ./
RUN npm ci
COPY client/ ./
RUN npm run build

FROM node:20-alpine

WORKDIR /app

# Server dependencies
COPY server/package.json server/package-lock.json ./
RUN npm ci --omit=dev

# Server source
COPY server/src/ ./src/
COPY server/media/ ./media/

# Built client
COPY --from=client-build /build/client/dist ./client-dist/

ENV CLIENT_DIST=/app/client-dist

EXPOSE 3000

# Seed Redis and start server
CMD ["sh", "-c", "node src/seed.js && node src/index.js"]
