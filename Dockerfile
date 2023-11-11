FROM oven/bun:alpine AS base
RUN apk add --no-cache python3 make gcc
ENV DATABASE_URL file:./dev.db

FROM base AS builder
WORKDIR /app
COPY . .
RUN bun install --frozen-lockfile
RUN bun run build

FROM base
WORKDIR /app
ENV NODE_ENV production
COPY --from=builder /app/.next/standalone .
COPY --from=builder /app/dev.db .
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/.next/server ./.next/server
EXPOSE 3000
ENV PORT 3000
ENV HOSTNAME "0.0.0.0"
CMD ["bun", "server.js"]