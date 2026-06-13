FROM oven/bun:alpine AS build

WORKDIR /app

COPY package.json bun.lock ./

RUN bun install --frozen-lockfile

COPY . .

RUN bun run build

FROM ghcr.io/shadowarcanist/rustinx:v1.0

COPY --from=build /app/dist /static

COPY rustinx.toml /etc/rustinx/rustinx.toml

EXPOSE 9090
