FROM nginx:alpine

ARG HUGO_VERSION="0.80.0"
ARG ENVIRONMENT="development"
ARG NGINX_PORT="8080"

ENV HUGO_RELEASE="hugo_extended"
ENV HUGO_ARCH="Linux-64bit"
ENV GITHUB_USERNAME="freuds"
ENV DOCKER_IMAGE_NAME="hugoweb"

# Install dependency
RUN apk add --update --no-cache \
    git \
    libstdc++ \
    libc6-compat \
    g++ \
    ca-certificates

# Install gohugo binary
ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_RELEASE}_${HUGO_VERSION}_${HUGO_ARCH}.tar.gz .
RUN tar -xf ${HUGO_RELEASE}_${HUGO_VERSION}_${HUGO_ARCH}.tar.gz && \
    rm -f ${HUGO_RELEASE}_${HUGO_VERSION}_${HUGO_ARCH}.tar.gz README.md LICENSE && \
    mv hugo /usr/bin

# Get hugo static from repo
RUN git clone https://github.com/${GITHUB_USERNAME}/${DOCKER_IMAGE_NAME}.git
RUN hugo --environment ${ENVIRONMENT} -s ${DOCKER_IMAGE_NAME} -d /usr/share/nginx/html/ && \
    rm -rf /${DOCKER_IMAGE_NAME}

# copy nginx configurations
COPY ./docker/nginx.conf /etc/nginx/nginx.conf
COPY ./docker/default.conf /etc/nginx/conf.d/default.conf
RUN sed -i -- s/NGINX_PORT/${NGINX_PORT}/ /etc/nginx/conf.d/default.conf

# add permissions for nginx user
RUN chown -R nginx:nginx /usr/share/nginx/html && chmod -R 755 /usr/share/nginx/html && \
        chown -R nginx:nginx /var/cache/nginx && \
        chown -R nginx:nginx /var/log/nginx && \
        chown -R nginx:nginx /etc/nginx/conf.d
RUN touch /var/run/nginx.pid && \
        chown -R nginx:nginx /var/run/nginx.pid

USER nginx

CMD nginx -g "daemon off;"
