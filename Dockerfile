# Java 8 environment
# Cf. https://github.com/docker-library/openjdk/blob/baaaf7714f9c66e4c5decf2c108a2738b7186c7f/8-jdk/Dockerfile
# from Tianon Gravi
FROM dgricci/jessie:0.0.3
MAINTAINER Didier Richard <didier.richard@ign.fr>

RUN \
    apt-get -qy update && \
    apt-get -qy --no-install-recommends install \
        bzip2 \
        unzip \
        xz-utils && \
    rm -rf /var/lib/apt/lists/* && \
    echo 'deb http://httpredir.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list && \
    # add a simple script that can auto-detect the appropriate JAVA_HOME value
    # based on whether the JDK or only the JRE is installed
    { \
        echo '#!/bin/sh'; \
        echo 'set -e'; \
        echo; \
        echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
    } > /usr/local/bin/docker-java-home && \
    chmod +x /usr/local/bin/docker-java-home

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV JAVA_VERSION 8u102
ENV JAVA_DEBIAN_VERSION 8u102-b14.1-1~bpo8+1
# see https://bugs.debian.org/775775
# and https://github.com/docker-library/java/issues/19#issuecomment-70546872
ENV CA_CERTIFICATES_JAVA_VERSION 20140324

RUN \
    apt-get -qy update && \
    apt-get install -qy \
        openjdk-8-jdk="$JAVA_DEBIAN_VERSION" \
        ca-certificates-java="$CA_CERTIFICATES_JAVA_VERSION" && \
    rm -rf /var/lib/apt/lists/* && \
    set -x && [ "$JAVA_HOME" = "$(docker-java-home)" ] && \
    # see CA_CERTIFICATES_JAVA_VERSION notes above
    /var/lib/dpkg/info/ca-certificates-java.postinst configure

