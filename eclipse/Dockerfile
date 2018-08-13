FROM debian:buster-slim
LABEL maintainer "Ricardo Nooijen <ricardo@nooijen.net>"

ENV eclipse_download_url https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/oxygen/3a/eclipse-jee-oxygen-3a-linux-gtk-x86_64.tar.gz&mirror_id=1

# Hack for openjdk-8-jdk installation below; https://github.com/debuerreotype/docker-debian-artifacts/issues/24
RUN mkdir -p /usr/share/man/man1

RUN apt-get update && apt-get install -y --no-install-recommends \
        openjdk-8-jdk \
        gosu \
        && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
        tar \
        curl \
        && cd /opt/eclipse \
        && curl -Lo /opt/eclipse/eclipse-oxygen.tar.gz ${eclipse_download_url} \
        && tar -xvzf /opt/eclipse/eclipse-oxygen.tar.gz --transform='s#^eclipse/#oxygen/#g' \
        && rm /opt/eclipse/eclipse-oxygen.tar.gz \
        && apt-get purge tar curl \
        && rm -rf /var/lib/apt/lists/* \
        && groupadd eclipse \
        && useradd eclipse -d /home/eclipse -g eclipse \
        && chown -R eclipse:eclipse /opt/eclipse

COPY resources/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /home/eclipse

ENTRYPOINT [ "/entrypoint.sh" ]
