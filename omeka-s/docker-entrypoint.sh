#!/bin/bash

### Omeka configurations that need to happen during runtime ###
# Note: Docker volume-binds are not available during build stage.
if [[ ! -d /var/www/html/files/temp ]]
then
    mkdir /var/www/html/files/temp
    chown www-data:www-data /var/www/html/volume/files/temp
fi

### End of Omeka configurations ###

# Start the Shibboleth daemon for single-sign on
service shibd start

# Start the Apache daemon
service apache2 start

# Download the IdP signing certificate
curl -L ${SAML_IDP_SIGN_CERT_URL} --output /etc/shibboleth/idp-sign-cert.pem

# End with a persistent foreground process
echo "--- Omeka S startup DONE ---"
tail -F /var/www/html/logs/application.log
