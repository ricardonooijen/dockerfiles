FROM debian:buster
LABEL maintainer "Ricardo Nooijen <ricardo@nooijen.net>"

RUN apt-get update && apt-get install -y \
        openjdk-8-jdk \
        tar \
        --no-install-recommends \
        && rm -rf /var/lib/apt/lists/*

ADD https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/oxygen/3a/eclipse-jee-oxygen-3a-linux-gtk-x86_64.tar.gz&mirror_id=1 /opt/eclipse/eclipse-oxygen.tar.gz

RUN mkdir /opt/eclipse/oxygen \
        && tar xvzf /opt/eclipse/eclipse-oxygen.tar.gz eclipse -C /opt/eclipse/oxygen \

ENTRYPOINT [ "/opt/eclipse/oxygen/eclipse" ]
