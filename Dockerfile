FROM nginx:1.25.2-alpine3.18-slim

COPY conf/nginx.conf /etc/nginx/nginx.conf

COPY script/entrypoint.sh /entrypoint.sh
COPY script/le.sh /le.sh

RUN \
 rm /etc/nginx/conf.d/default.conf && \
 chmod +x /entrypoint.sh && \
 chmod +x /le.sh && \
 apk add --no-cache --update \
    certbot=2.6.0-r0 \
    tzdata=2023c-r1 \
    openssl=3.1.3-r0

CMD ["/entrypoint.sh"]
