#!/bin/bash

# Add an /etc/hosts entry for the IP of the Docker host machine (required for Xdebug connections to PhpStorm on the host)
echo "$(ip route|awk '/default/ { print $3 }') dockerhost.local" >> /etc/hosts

### Omeka configurations that need to happen during runtime ###

# Generate database configuration file
echo "Creating database.ini in /var/www/html/config/ ..."
rm -f /var/www/html/config/database.ini
echo "user     = \"$MYSQL_USER\"" > /var/www/html/config/database.ini
echo "password = \"$MYSQL_PASSWORD\"" >> /var/www/html/config/database.ini
echo "dbname   = \"$MYSQL_DATABASE\"" >> /var/www/html/config/database.ini
echo "host     = \"$MYSQL_HOST\"" >> /var/www/html/config/database.ini
echo "Done creating database.ini !"

# Ensure that some of the necessary directories exist and are owned by www-data
dirs=(
    "/var/www/html/files/temp"
    "/var/www/html/files/datacatalogs"
    "/var/www/html/files/datadumps"
)

for dir in "${dirs[@]}"; do
    if [[ ! -d "$dir" ]]; then
        echo "Creating directory $dir..."
        mkdir -p "$dir"
        chown www-data:www-data "$dir"
    fi
done

# Unpack the initial ARK database
tar -xvf /tmp/init-arkandnoid-db.tar.gz -C /var/www/html/files/

### End of Omeka runtime configurations ###


# Start Apache and PHP-FPM
service apache2 start
php-fpm -D

# End with a persistent foreground process
tail -F /var/www/html/logs/application.log \
        /var/www/html/logs/sql.log \
        /var/log/apache2/access.log \
        /var/log/apache2/error.log \
        /var/log/php-fpm.log

