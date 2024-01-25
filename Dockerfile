FROM nginx:1.25.3-alpine3.18-slim

COPY conf/nginx.conf /etc/nginx/nginx.conf

COPY script/entrypoint.sh /entrypoint.sh
COPY script/le.sh /le.sh

RUN \
 rm /etc/nginx/conf.d/default.conf && \
 chmod +x /entrypoint.sh && \
 chmod +x /le.sh && \
 apk add --no-cache --update \
    certbot \
    tzdata \
    openssl

CMD ["/entrypoint.sh"]
