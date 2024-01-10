#!/bin/bash

# Add an /etc/hosts entry for the IP of the Docker host machine (required for Xdebug connections to PhpStorm on the host)
echo "$(ip route|awk '/default/ { print $3 }') dockerhost.local" >> /etc/hosts

### Omeka configurations that need to happen during runtime ###
# Note: Docker volume-binds are not available during build stage.
if [[ ! -d /var/www/html/files/temp ]]
then
    mkdir /var/www/html/files/temp
    chown www-data:www-data /var/www/html/volume/files/temp
fi

# Unpack the initial ARK database
tar -xvf /tmp/init-arkandnoid-db.tar.gz -C /var/www/html/files/

### End of Omeka configurations ###


# Start the Apache daemon
service apache2 start

# End with a persistent foreground process
tail -F /var/www/html/logs/application.log \
        /var/www/html/logs/sql.log \
        /var/log/apache2/access.log \
        /var/log/apache2/error.log \
#        /var/log/apache2/other_vhosts_access.log
