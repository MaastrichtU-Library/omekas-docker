#!/bin/bash

### Omeka configurations that need to happen during runtime ###
# Note: Docker volume-binds are not available during build stage.
if [[ ! -d /var/www/html/files/temp ]]
then
    mkdir /var/www/html/files/temp
    chown www-data:www-data /var/www/html/volume/files/temp
fi

### End of Omeka configurations ###

# Start the Apache daemon
service apache2 start

# End with a persistent foreground process
tail -F /var/www/html/logs/application.log