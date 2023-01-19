FROM giocomai/omeka-s-docker:v3.2.3

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    nano

# Remove the modules-symlink to volume/
RUN rm /var/www/html/modules && \
    rm -fr /var/www/html/volume/modules/ && \
    mkdir /var/www/html/modules/


# Some Omeka S modules require additional PHP extensions
# As the PHP Docker image is kept as small as possible (see https://hub.docker.com/_/php), we need to install these extensions.
# The helper script `docker-php-ext-install` can be used to compile extensions into PHP.
# The helper script 'docker-php-extension-installer' is even more convenient, as it simplifies the installation of PHP extensions by automatically adding and removing Debian (apt) and Alpine (apk) packages.
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions \
    # for module Ark
    dba bcmath


# Some modules require composer
# In Docker it cannot be installed via apt because of unmet php dependencies
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install modules
RUN curl -L https://github.com/Daniel-KM/Omeka-S-module-AdvancedSearch/releases/download/3.3.6.18/AdvancedSearch-3.3.6.18.zip --output /tmp/AdvancedSearch.zip && \
    unzip /tmp/AdvancedSearch.zip -d modules/ && \
    rm /tmp/AdvancedSearch.zip

RUN curl -L https://gitlab.com/Daniel-KM/Omeka-S-module-Ark/-/archive/3.5.13.3/Omeka-S-module-Ark-3.5.13.3.zip --output /tmp/Ark.zip && \
    unzip /tmp/Ark.zip -d modules/ && \
    # Archives downloaded from gitlab contain a long and versioned module name so we rename it.
    mv modules/Omeka-S-module-Ark-3.5.13.3 modules/Ark && \
    # install module's dependencies via composer
    cd modules/Ark && \
    composer update && \
    composer install --no-dev && \
    rm /tmp/Ark.zip

RUN curl -L https://github.com/Daniel-KM/Omeka-S-module-BulkEdit/releases/download/3.3.13.4/BulkEdit-3.3.13.4.zip --output /tmp/BulkEdit.zip && \
    unzip /tmp/BulkEdit.zip -d modules/ && \
    rm /tmp/BulkEdit.zip

RUN curl -L https://github.com/Daniel-KM/Omeka-S-module-CleanUrl/archive/refs/tags/3.17.4.4.zip --output /tmp/CleanUrl.zip && \
    unzip /tmp/CleanUrl.zip -d modules/ && \
    mv modules/Omeka-S-module-CleanUrl-3.17.4.4 modules/CleanUrl && \
    # install module's dependencies via composer
    cd modules/CleanUrl && \
    composer update && \
    composer install --no-dev && \
    rm /tmp/CleanUrl.zip

RUN curl -L https://github.com/omeka-s-modules/ExtractText/releases/download/v1.2.1/ExtractText-1.2.1.zip --output /tmp/ExtractText.zip && \
    unzip /tmp/ExtractText.zip -d modules/ && \
    rm /tmp/ExtractText.zip

RUN curl -L https://github.com/zerocrates/HideProperties/releases/download/v1.3.0/HideProperties-1.3.0.zip --output /tmp/HideProperties.zip && \
    unzip /tmp/HideProperties.zip -d modules/ && \
    rm /tmp/HideProperties.zip

RUN curl -L https://github.com/omeka-s-modules/FacetedBrowse/releases/download/v1.1.0/FacetedBrowse-1.1.0.zip --output /tmp/FacetedBrowse.zip && \
    unzip /tmp/FacetedBrowse.zip -d modules/ && \
    rm /tmp/FacetedBrowse.zip

RUN curl -L https://github.com/omeka-s-modules/MetadataBrowse/releases/download/v1.4.1/MetadataBrowse-1.4.1.zip --output /tmp/MetadataBrowse.zip && \
    unzip /tmp/MetadataBrowse.zip -d modules/ && \
    rm /tmp/MetadataBrowse.zip

RUN curl -L https://github.com/Daniel-KM/Omeka-S-module-PdfViewer/releases/download/3.3.4.2/PdfViewer-3.3.4.2.zip --output /tmp/PdfViewer.zip && \
    unzip /tmp/PdfViewer.zip -d modules/ && \
    rm /tmp/PdfViewer.zip

RUN curl -L https://github.com/Daniel-KM/Omeka-S-module-Reference/releases/download/3.4.37.3/Reference-3.4.37.3.zip --output /tmp/Reference.zip && \
    unzip /tmp/Reference.zip -d modules/ && \
    rm /tmp/Reference.zip

RUN curl -L https://github.com/Daniel-KM/Omeka-S-module-SearchSolr/releases/download/3.5.34.3/SearchSolr-3.5.34.3.zip --output /tmp/SearchSolr.zip && \
    unzip /tmp/SearchSolr.zip -d modules/ && \
    rm /tmp/SearchSolr.zip

# NOTE: Downloaded modules need to be installed in the Admin UI. The Installation-Status survives a rebuild of the Omeka S container, so I guess the installation makes changes to the database only.


# Remove the config-symlinks to volume/
RUN rm /var/www/html/config/* && \
    rm -fr /var/www/html/volume/config/
# and add our own config files
COPY config/ /var/www/html/config/


# Copy other files and folders into the container
COPY .htaccess /var/www/html/.htaccess
COPY docker-entrypoint.sh /

# Set correct ownership on www folders
RUN chown -R www-data:www-data /var/www/html/

ENTRYPOINT ["/docker-entrypoint.sh"]
