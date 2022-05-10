FROM jenkinsci/blueocean

USER root

# https://wiki.alpinelinux.org/wiki/Docker
RUN apk add --no-cache py-pip python3-dev libffi-dev openssl-dev gcc libc-dev make gettext \
    && pip3 install docker-compose

USER jenkins
