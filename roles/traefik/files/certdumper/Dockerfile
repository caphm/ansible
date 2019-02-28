FROM alpine

RUN apk --no-cache add inotify-tools jq openssl util-linux bash
RUN wget https://raw.githubusercontent.com/containous/traefik/master/contrib/scripts/dumpcerts.sh -O dumpcerts.sh

COPY certdumper.sh /
ENTRYPOINT ["/certdumper.sh"]
