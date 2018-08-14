FROM debian:buster-slim as builder
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
        && rm -rf /var/lib/apt/lists/*
WORKDIR /opt/eclipse
RUN curl -Lo /opt/eclipse/eclipse-oxygen.tar.gz ${eclipse_download_url} \
        && tar -xvzf /opt/eclipse/eclipse-oxygen.tar.gz --transform='s#^eclipse/#oxygen/#g' \
        && rm /opt/eclipse/eclipse-oxygen.tar.gz \
        && rm -rf /var/lib/apt/lists/*
# Install DevStyle
RUN /opt/eclipse/oxygen/eclipse -application org.eclipse.equinox.p2.director -nosplash -repository https://www.genuitec.com/updates/devstyle/ci -i com.genuitec.eclipse.theming.feature.feature.group
COPY resources/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

FROM debian:buster-slim
RUN mkdir -p /usr/share/man/man1
RUN apt-get update && apt-get install -y --no-install-recommends \
        openjdk-8-jdk \
        gosu \
        && rm -rf /var/lib/apt/lists/*
COPY --from=builder /opt/eclipse /opt/eclipse
COPY --from=builder /entrypoint.sh /entrypoint.sh
COPY --from=builder /root/.eclipse /home/eclipse/.eclipse
RUN groupadd eclipse \
        && useradd eclipse -d /home/eclipse -g eclipse \
        && chown -R eclipse:eclipse /opt/eclipse \
        && chown -R eclipse:eclipse /home/eclipse
WORKDIR /home/eclipse
ENTRYPOINT [ "/entrypoint.sh" ]
