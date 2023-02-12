FROM nginx:alpine

ARG NGINX_PORT="5000"
ARG HUGO_ENV="production"
ARG HUGO_VERSION="0.110.0"
ARG HUGO_FILENAME="hugo_${HUGO_VERSION}_Linux-64bit.tar.gz"
ARG GITHUB_USER="freuds"
ARG GITHUB_REPO="hugoweb"

ENV NGINX_PORT=${NGINX_PORT}

# Install dependency (for hugo_extended version only)
RUN apk add --update --no-cache git
    # libstdc++ \
    # libc6-compat

# Create directory
RUN mkdir -p /site && mkdir -p /app

# Install gohugo binary
ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_FILENAME} .
RUN tar -xf ${HUGO_FILENAME} && \
    rm -f ${HUGO_FILENAME} README.md LICENSE && \
    mv hugo /usr/bin

COPY . /site/
RUN /usr/bin/hugo --environment ${HUGO_ENV} -s /site -d /app/ && \
    rm -f /usr/bin/hugo && rm -rf /site && apk del --no-cache git

# Nginx configurations
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./nginx/default.conf.template /etc/nginx/templates/default.conf.template

# Permissions for nginx user
RUN chown -R nginx:nginx /app /usr/share/nginx/html && \
    chmod -R 755 /app /usr/share/nginx/html && \
    chown -R nginx:nginx /var/cache/nginx /var/log/nginx /etc/nginx/conf.d /etc/nginx/templates && \
    touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid

USER nginx

EXPOSE ${NGINX_PORT}

CMD ["nginx", "-g", "daemon off;"]