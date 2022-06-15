FROM giocomai/omeka-s-docker:v3.2.0

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    nano

# Install modules
# TODO: Implement this using .sh script with config file of modules to be installed


# Remove the symlink to volume/
RUN rm /var/www/html/modules && \
    rm -fr /var/www/html/volume/modules/ && \
    mkdir /var/www/html/modules/

RUN curl -L https://github.com/Daniel-KM/Omeka-S-module-AdvancedSearch/releases/download/3.3.6.13/AdvancedSearch-3.3.6.13.zip --output /tmp/AdvancedSearch.zip && \
    unzip /tmp/AdvancedSearch.zip -d modules/ && \
    rm /tmp/AdvancedSearch.zip

RUN chown -R www-data:www-data /var/www/html/modules/

# Install theme
# TODO: Implement this
# TODO: Only install the theme if it doesn't exist. Prevent overriding code-changes introduced by a UB-developer

CMD ["apache2-foreground"]
