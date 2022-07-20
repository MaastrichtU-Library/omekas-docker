#!/bin/bash

### Omeka configurations that need to happen during runtime ###
# Note: Docker volume-binds are not available during build stage.
mkdir /var/www/html/files/temp
chown www-data:www-data /var/www/html/volume/files/temp
### End of Omeka configurations ###

# End with a persistent foreground process
apache2-foreground