# --- BASE ---
FROM node:22-alpine AS base
LABEL author="Rumdien113"
WORKDIR /app
COPY package.json package-lock.json ./
RUN apk add --no-cache git \
    && npm ci

# --- BUILD APP ---
FROM base AS build
LABEL author="Rumdien113"
WORKDIR /app
COPY . .
RUN npm run build

# --- PRODUCTION ---
FROM node:22-alpine AS PROD
LABEL author="Rumdien113"
WORKDIR /app
ENV NODE_ENV=production

COPY --from=build /app/public ./public
COPY --from=build /app/next.config.mjs ./
COPY --from=build /app/.next/standalone ./
COPY --from=build /app/.next/static ./.next/static

EXPOSE 3000

CMD ["node", "server.js"]