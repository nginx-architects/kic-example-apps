FROM nginxinc/nginx-unprivileged
RUN rm /etc/nginx/conf.d/default.conf 
COPY plain-text.conf /etc/nginx/conf.d