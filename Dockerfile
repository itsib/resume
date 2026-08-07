ARG VERSION=0.11.5
FROM node:24.18-slim AS builder

WORKDIR /usr/web/

COPY . .

RUN npm install -g npm@latest && \
    npm ci && \
    npm run build

FROM rtsp/lighttpd AS production
ARG VERSION

WORKDIR /var/www/html

RUN rm -rf ./*

COPY --from=builder /usr/web/dist .
COPY --from=builder /usr/web/healthcheck /usr/bin/healthcheck
COPY ./lighttpd.conf /etc/lighttpd/lighttpd.conf

ENV PORT=80
ENV VERSION=${VERSION}

ENTRYPOINT ["/usr/sbin/lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]

