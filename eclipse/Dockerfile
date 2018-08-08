FROM debian:buster
LABEL maintainer "Ricardo Nooijen <ricardo@nooijen.net>"

ENV eclipse_download_url https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/oxygen/3a/eclipse-jee-oxygen-3a-linux-gtk-x86_64.tar.gz&mirror_id=1

RUN apt-get update && apt-get install -y \
        openjdk-8-jdk \
        tar \
        gosu \
        --no-install-recommends \
        && rm -rf /var/lib/apt/lists/*

ADD ${eclipse_download_url} /opt/eclipse/eclipse-oxygen.tar.gz

RUN cd /opt/eclipse \
        && tar -xvzf /opt/eclipse/eclipse-oxygen.tar.gz --transform='s#^eclipse/#oxygen/#g' \
        && rm /opt/eclipse/eclipse-oxygen.tar.gz \
        && groupadd eclipse \
        && useradd eclipse -d /home/eclipse -g eclipse \
        && chown -R eclipse:eclipse /opt/eclipse

COPY resources/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /home/eclipse

ENTRYPOINT [ "/entrypoint.sh" ]
