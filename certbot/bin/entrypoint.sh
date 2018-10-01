#!/bin/sh

until curl --output /dev/null --silent --head --fail http://"${CERT_DOMAIN}"; do
    echo "Cannot resolve ${CERT_DOMAIN}..."
    sleep 60
done

echo "Response from http://${CERT_DOMAIN}, attempting to obtain certificate..."

/usr/local/bin/run_certbot.sh -e "${ADMIN_EMAIL}" -d "${CERT_DOMAIN}" -r /challenges
