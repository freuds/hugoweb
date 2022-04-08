FROM nginx:alpine

ARG NGINX_PORT="5000"
ENV NGINX_PORT=${NGINX_PORT}

ARG HUGO_ENV="development"
ARG HUGO_VERSION="0.96.0"
ARG HUGO_FILENAME="hugo_${HUGO_VERSION}_Linux-64bit.tar.gz"

ARG GITHUB_USER="freuds"
ARG GITHUB_REPO="hugoweb"

# Install dependency
RUN apk add --update --no-cache \
    libstdc++ \
    libc6-compat \
    git

# Install gohugo binary
ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_FILENAME} .
RUN tar -xf ${HUGO_FILENAME} && \
    rm -f ${HUGO_FILENAME} README.md LICENSE && \
    mv hugo /usr/bin

# Get hugo static from repo
RUN git clone https://github.com/${GITHUB_USER}/${GITHUB_REPO}.git
RUN mkdir -p /app && \
    /usr/bin/hugo --environment ${HUGO_ENV} -s ${GITHUB_REPO} -d /app/ && \
    rm -rf /${GITHUB_REPO} && rm -f /usr/bin/hugo

RUN apk del --no-cache libstdc++ \
    libc6-compat \
    git

# Nginx configurations
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./nginx/default.conf.template /etc/nginx/templates/default.conf.template

# Permissions for nginx user
RUN chown -R nginx:nginx /app /usr/share/nginx/html && chmod -R 755 /app /usr/share/nginx/html && \
        chown -R nginx:nginx /var/cache/nginx /var/log/nginx /etc/nginx/conf.d /etc/nginx/templates
RUN touch /var/run/nginx.pid && \
        chown -R nginx:nginx /var/run/nginx.pid

USER nginx

EXPOSE ${NGINX_PORT}

CMD ["nginx", "-g", "daemon off;"]