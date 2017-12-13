#!/bin/bash

PLEX_HOSTNAME=plex.caphm.de
PLEX_CERT_ENCKEY={{plex_cert_enc_key}}

pushd {{appdata}}/plex/certs > /dev/null
openssl pkcs12 -export \
   -out {{appdata}}/plex/certs/${PLEX_HOSTNAME}.pfx \
   -inkey {{appdata}}/nginx-reverse-proxy/certs/${PLEX_HOSTNAME}.key \
   -in {{appdata}}/nginx-reverse-proxy/certs/${PLEX_HOSTNAME}.crt \
   -certfile {{appdata}}/nginx-reverse-proxy/certs/${PLEX_HOSTNAME}.chain.pem \
   -name "${PLEX_HOSTNAME}" \
   -passout pass:${PLEX_CERT_ENCKEY}
popd

# Set the right ownership and permissions to the generated PKCS #12 container file:
chmod 600 {{appdata}}/plex/certs/${PLEX_HOSTNAME}.pfx
chown caphm:caphm {{appdata}}/plex/certs/${PLEX_HOSTNAME}.pfx
