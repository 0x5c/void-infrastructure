FROM  ghcr.io/void-linux/void-linux:latest-full-x86_64

RUN xbps-install -Suy xbps && xbps-install -Sy nginx tini

WORKDIR /srv/www
COPY nginx.conf /etc/nginx/nginx.conf
COPY root.conf /etc/nginx/locations.d/root.conf
ENTRYPOINT ["/usr/bin/tini", "--", "nginx", "-g daemon off;"]
