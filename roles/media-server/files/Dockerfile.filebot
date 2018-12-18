FROM openjdk:8-jre

MAINTAINER Reinhard Pointner <rednoah@filebot.net>

ENV FILEBOT_VERSION 4.7.9
ENV FILEBOT_NODE_VERSION 0.2.4

ENV DOCKER_DATA /data
ENV DOCKER_IN /download
ENV DOCKER_OUT /out

ENV HOME $DOCKER_DATA
ENV JAVA_OPTS "-DuseGVFS=false -Djava.net.useSystemProxies=false -Dapplication.deployment=docker -Dapplication.dir=$DOCKER_DATA -Duser.home=$DOCKER_DATA -Djava.io.tmpdir=$DOCKER_DATA/tmp -Djava.util.prefs.PreferencesFactory=net.filebot.util.prefs.FilePreferencesFactory -Dnet.filebot.util.prefs.file=$DOCKER_DATA/prefs.properties"

ENV FILEBOT_NODE_AUTH NONE
ENV FILEBOT_NODE_HTTP YES
ENV FILEBOT_NODE_HTTP_PORT 5452


WORKDIR /usr/share/filebot

RUN FILEBOT_SHA256=892723dcec8fe5385ec6665db9960e7c1a88e459a60525c02afb7f1195a50523 \
 && FILEBOT_PACKAGE=filebot_${FILEBOT_VERSION}_amd64.deb \
 && curl -L -O https://downloads.sourceforge.net/project/filebot/filebot/FileBot_$FILEBOT_VERSION/$FILEBOT_PACKAGE \
 && echo "$FILEBOT_SHA256 *$FILEBOT_PACKAGE" | sha256sum --check --strict \
 && dpkg -i $FILEBOT_PACKAGE \
 && rm $FILEBOT_PACKAGE

RUN curl -sL https://deb.nodesource.com/setup_7.x | bash \
 && apt-get update && apt-get install -y \
    mediainfo \
    libchromaprint-tools \
    file \
    curl \
    inotify-tools \
    nodejs \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/local/filebot-node

RUN FILEBOT_NODE_SHA256=8d13170b4e34ac0953ba58a99d30cad18328b825f70330d3f7b91f10256df981 \
 && FILEBOT_NODE_PACKAGE=filebot-node-${FILEBOT_NODE_VERSION}-generic.tar.xz \
 && curl -L -O https://downloads.sourceforge.net/project/filebot/filebot-node/filebot-node-$FILEBOT_NODE_VERSION/$FILEBOT_NODE_PACKAGE \
 && echo "$FILEBOT_NODE_SHA256 *$FILEBOT_NODE_PACKAGE" | sha256sum --check --strict \
 && tar xvf $FILEBOT_NODE_PACKAGE \
 && rm $FILEBOT_NODE_PACKAGE \
 && find . -executable -type f -delete

COPY filebot-node /usr/bin/filebot-node

EXPOSE $FILEBOT_NODE_HTTP_PORT

VOLUME ["$DOCKER_DATA", "$DOCKER_IN", "$DOCKER_OUT"]

ENTRYPOINT ["/usr/bin/filebot-node"]
