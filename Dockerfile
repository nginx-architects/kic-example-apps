FROM nginxinc/nginx-unprivileged
USER root
RUN rm /etc/nginx/conf.d/default.conf && apt-get update && apt-get install -y curl
USER nginx
COPY plain-text.conf /etc/nginx/conf.d