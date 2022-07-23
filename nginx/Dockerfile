FROM nginx:1.19.0-alpine

# Overwrite default config
RUN rm /etc/nginx/conf.d/default.conf

COPY nginx.conf /etc/nginx/nginx.conf
COPY nginxconfig.io/ /etc/nginx/nginxconfig.io
COPY sites-available/ /etc/nginx/sites-available
COPY sites-enabled/ /etc/nginx/sites-enabled
