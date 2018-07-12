from debian:jessie-slim

MAINTAINER Ricardo Nooijen <ricardo@basenet.nl>

RUN apt-get update \
        && apt-get install -y --no-install-recommends \
        curl \
        ca-certificates \
        apt-transport-https \
        && rm -rf /var/lib/apt/lists/*

RUN echo 'deb https://riot.im/packages/debian/ jessie main' > /etc/apt/sources.list.d/matrix-riot-im.list \
        && curl -L https://riot.im/packages/debian/repo-key.asc | apt-key add - \
        && apt-get update \
        && apt-get install -y --no-install-recommends \
        libgtk-3-0 \
        libX11-xcb1 \
        libxss1 \
        libasound2 \
        riot-web \
        && rm -rf /var/lib/apt/lists/*

CMD /bin/bash
