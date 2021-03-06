FROM nginx:alpine

ARG HUGO_VERSION="0.85.0"
ARG HUGO_ENV="development"
ARG NGINX_PORT="5000"

ENV HUGO_RELEASE="hugo_extended"
ENV HUGO_ARCH="Linux-64bit"
ENV GITHUB_USERNAME="freuds"
ENV GITHUB_REPOSITORY="hugoweb"
ENV NGINX_PORT=${NGINX_PORT}
ENV HUGO_ENV=${HUGO_ENV}

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
RUN git clone https://github.com/${GITHUB_USERNAME}/${GITHUB_REPOSITORY}.git
RUN mkdir -p /app && \
    hugo --environment ${HUGO_ENV} -s ${GITHUB_REPOSITORY} -d /app/ && \
    rm -rf /${GITHUB_REPOSITORY}

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