FROM node:22-alpine AS builder
WORKDIR /app

RUN npm install -g pnpm


COPY . .
ENV CI=true
RUN pnpm install --frozen-lockfile
RUN pnpm build

FROM nginx:stable-alpine
COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
