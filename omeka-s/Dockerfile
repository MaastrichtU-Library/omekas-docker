ARG ENV_PHP_VERSION
FROM php:${ENV_PHP_VERSION}-fpm-bookworm

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    # Common software
    apache2 \
    curl \
    nano \
    unzip \
    # iproute2 is used to retrieve the IP of the docker host machine (needed for Xdebug connections)
    iproute2 \
    # dependencies for PHP extensions
    libfreetype6-dev \
    zlib1g-dev \
    libpng-dev \
    libjpeg-dev \
    libtiff-dev \
    imagemagick \
    ghostscript \
    # for (IIIF) image processing
    libvips-tools \
    # for module ExtractText
    poppler-utils \
    # for Omeka S module NumericDataTypes
    libicu-dev

# Imagemagick config
# Thumbnails in Omeka S created by Imagemagick
# Processing PDF was disabled in ImageMagick config because of a vulnerability in GhostScript < 9.24 (see https://www.kb.cert.org/vuls/id/332928/)
# We're using GhostScript version 10.00.0 or higher, so we can safely re-enable the ImageMagick processing for PDF
RUN sed -i 's_<policy domain="coder" rights="none" pattern="PDF" />_<policy domain="coder" rights="read|write" pattern="PDF" />_g' /etc/ImageMagick-6/policy.xml

# PHP config
COPY php-config/99-omeka.ini $PHP_INI_DIR/conf.d/

# PHP-FPM config
RUN sed -i 's|error_log = /proc/self/fd/2|error_log = /var/log/php-fpm.log|g' /usr/local/etc/php-fpm.d/docker.conf && \
    sed -i 's|access.log = /proc/self/fd/2|access.log = /var/log/php-fpm.log|g' /usr/local/etc/php-fpm.d/docker.conf && \
    sed -i 's|listen = 9000|listen = /run/php-fpm.sock|g' /usr/local/etc/php-fpm.d/zz-docker.conf && \
    echo 'listen.owner = www-data' >> /usr/local/etc/php-fpm.d/zz-docker.conf && \
    echo 'listen.group = www-data' >> /usr/local/etc/php-fpm.d/zz-docker.conf

# Apache config
COPY apache-config/000-default.conf /etc/apache2/sites-available/

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

RUN a2dismod mpm_prefork && \
    a2enmod mpm_event && \
    a2enmod proxy_fcgi && \
    a2enmod rewrite

# Enable http/2 to serve multiple files over the same tcp connection. This increases performance for IIIF image tiles.
RUN a2enmod http2

# Required to enable CORS for serving IIIF images to external clients.
RUN a2enmod headers

# Install Omeka S
ARG ENV_OMEKAS_VERSION
RUN rm -fr /var/www/html && \
    curl -L https://github.com/omeka/omeka-s/releases/download/v${ENV_OMEKAS_VERSION}/omeka-s-${ENV_OMEKAS_VERSION}.zip --output /var/www/latest_omeka_s.zip && \
    unzip -q /var/www/latest_omeka_s.zip -d /var/www/ && \
    rm /var/www/latest_omeka_s.zip && \
    mv /var/www/omeka-s /var/www/html && \
    chown -R www-data:www-data /var/www

# Put files/ folder in data volume and symlink to it from Omeka S folder
RUN mkdir -p /var/www/html/volume/files/ && \
    rm -Rf /var/www/html/files/ && \
    ln -s /var/www/html/volume/files/ /var/www/html/files
VOLUME /var/www/html/volume/

# Omeka S core and modules require additional PHP extensions
# As the PHP Docker image is kept as small as possible (see https://hub.docker.com/_/php), we need to install these extensions.
# The builtin helper script `docker-php-ext-install` can be used to compile extensions into PHP.
# The additional helper script 'docker-php-extension-installer' is even more convenient, as it simplifies the installation of PHP extensions by automatically adding and removing Debian (apt) and Alpine (apk) packages.
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions && \
    docker-php-ext-configure gd --with-jpeg=/usr/include/ --with-freetype=/usr/include/ && \
    install-php-extensions \
    # for Omeka S core
    gd \
    imagick \
    pdo \
    pdo_mysql \
    mysqli \
    xml \
    # for module Ark
    dba bcmath \
    # for module BulkExport
    zip \
    # for module NumericDataTypes
    intl
    
# Install extension for remote debugging in IDE (e.g. PhpStorm)
RUN install-php-extensions xdebug \
    && echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    # Uncomment this to write xdebug logs to a file
#    && echo "xdebug.log = /tmp/xdebug.log" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    # Uncomment this one to start debugger on every request, regardless of the cookie set by the browser extension
#    && echo "xdebug.start_with_request = yes" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.client_host = dockerhost.local" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Some modules require composer
# In Docker it cannot be installed via apt because of unmet php dependencies
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Switching to www-data to avoid running composer as root (see https://getcomposer.org/root)
USER www-data

# Install modules
ARG ENV_MODULE_AdvancedSearch_VERSION
RUN curl -L https://github.com/Daniel-KM/Omeka-S-module-AdvancedSearch/releases/download/${ENV_MODULE_AdvancedSearch_VERSION}/AdvancedSearch-${ENV_MODULE_AdvancedSearch_VERSION}.zip --output /tmp/AdvancedSearch.zip && \
    unzip -q /tmp/AdvancedSearch.zip -d modules/ && \
    rm /tmp/AdvancedSearch.zip

ARG ENV_MODULE_ArchiveRepertory_VERSION
RUN curl -L https://github.com/Daniel-KM/Omeka-S-module-ArchiveRepertory/releases/download/${ENV_MODULE_ArchiveRepertory_VERSION}/ArchiveRepertory-${ENV_MODULE_ArchiveRepertory_VERSION}.zip --output /tmp/ArchiveRepertory.zip && \
    unzip -q /tmp/ArchiveRepertory.zip -d modules/ && \
    rm /tmp/ArchiveRepertory.zip

ARG ENV_MODULE_Ark_VERSION
#RUN curl -L https://gitlab.com/Daniel-KM/Omeka-S-module-Ark/-/archive/${ENV_MODULE_Ark_VERSION}/Omeka-S-module-Ark-${ENV_MODULE_Ark_VERSION}.zip --output /tmp/Ark.zip && \
RUN curl -L https://gitlab.com/mcoonen/Omeka-S-module-Ark/-/archive/${ENV_MODULE_Ark_VERSION}/Omeka-S-module-Ark-${ENV_MODULE_Ark_VERSION}.zip --output /tmp/Ark.zip && \
    unzip -q /tmp/Ark.zip -d modules/ && \
    # Archives downloaded from gitlab contain a long and versioned module name so we rename it.
    mv modules/Omeka-S-module-Ark-${ENV_MODULE_Ark_VERSION} modules/Ark && \
    # install module's dependencies via composer
    cd modules/Ark && \
    composer update && \
    composer install --no-dev && \
    rm /tmp/Ark.zip

ARG ENV_MODULE_BlocksDisposition_VERSION
RUN curl -L https://github.com/Daniel-KM/Omeka-S-module-BlocksDisposition/releases/download/${ENV_MODULE_BlocksDisposition_VERSION}/BlocksDisposition-${ENV_MODULE_BlocksDisposition_VERSION}.zip --output /tmp/BlocksDisposition.zip && \
    unzip -q /tmp/BlocksDisposition.zip -d modules/ && \
    rm /tmp/BlocksDisposition.zip

ARG ENV_MODULE_BulkEdit_VERSION
RUN curl -L https://github.com/Daniel-KM/Omeka-S-module-BulkEdit/releases/download/${ENV_MODULE_BulkEdit_VERSION}/BulkEdit-${ENV_MODULE_BulkEdit_VERSION}.zip --output /tmp/BulkEdit.zip && \
    unzip -q /tmp/BulkEdit.zip -d modules/ && \
    rm /tmp/BulkEdit.zip

ARG ENV_MODULE_BulkExport_VERSION
RUN curl -L https://github.com/Daniel-KM/Omeka-S-module-BulkExport/releases/download/${ENV_MODULE_BulkExport_VERSION}/BulkExport-${ENV_MODULE_BulkExport_VERSION}.zip --output /tmp/BulkExport.zip && \
    unzip -q /tmp/BulkExport.zip -d modules/ && \
    rm /tmp/BulkExport.zip

ARG ENV_MODULE_Common_VERSION
RUN curl -L https://gitlab.com/Daniel-KM/Omeka-S-module-Common/-/archive/${ENV_MODULE_Common_VERSION}/Omeka-S-module-Common-${ENV_MODULE_Common_VERSION}.zip --output /tmp/Common.zip && \
    unzip -q /tmp/Common.zip -d modules/ && \
    # Archives downloaded from gitlab contain a long and versioned module name so we rename it.
    mv modules/Omeka-S-module-Common-${ENV_MODULE_Common_VERSION} modules/Common && \
    rm /tmp/Common.zip

ARG ENV_MODULE_CreateMissingThumbnails_VERSION
RUN curl -L https://github.com/biblibre/omeka-s-module-CreateMissingThumbnails/releases/download/v${ENV_MODULE_CreateMissingThumbnails_VERSION}/CreateMissingThumbnails-${ENV_MODULE_CreateMissingThumbnails_VERSION}.zip --output /tmp/CreateMissingThumbnails.zip && \
    unzip -q /tmp/CreateMissingThumbnails.zip -d modules/ && \
    rm /tmp/CreateMissingThumbnails.zip

ARG ENV_MODULE_CSVImport_VERSION
RUN curl -L https://github.com/omeka-s-modules/CSVImport/releases/download/v${ENV_MODULE_CSVImport_VERSION}/CSVImport-${ENV_MODULE_CSVImport_VERSION}.zip --output /tmp/CSVImport.zip && \
    unzip -q /tmp/CSVImport.zip -d modules/ && \
    rm /tmp/CSVImport.zip

ARG ENV_MODULE_CustomVocab_VERSION
RUN curl -L https://github.com/omeka-s-modules/CustomVocab/releases/download/v${ENV_MODULE_CustomVocab_VERSION}/CustomVocab-${ENV_MODULE_CustomVocab_VERSION}.zip --output /tmp/CustomVocab.zip && \
    unzip -q /tmp/CustomVocab.zip -d modules/ && \
    rm /tmp/CustomVocab.zip

ARG ENV_MODULE_EUCookieBar_VERSION
RUN curl -L https://github.com/Daniel-KM/Omeka-S-module-EUCookieBar/releases/download/${ENV_MODULE_EUCookieBar_VERSION}/EUCookieBar-${ENV_MODULE_EUCookieBar_VERSION}.zip --output /tmp/EUCookieBar.zip && \
    unzip -q /tmp/EUCookieBar.zip -d modules/ && \
    rm /tmp/EUCookieBar.zip

ARG ENV_MODULE_ExtractText_VERSION
RUN curl -L https://github.com/omeka-s-modules/ExtractText/releases/download/v${ENV_MODULE_ExtractText_VERSION}/ExtractText-${ENV_MODULE_ExtractText_VERSION}.zip --output /tmp/ExtractText.zip && \
    unzip -q /tmp/ExtractText.zip -d modules/ && \
    rm /tmp/ExtractText.zip

ARG ENV_MODULE_FileSideload_VERSION
RUN curl -L https://github.com/omeka-s-modules/FileSideload/releases/download/v${ENV_MODULE_FileSideload_VERSION}/FileSideload-${ENV_MODULE_FileSideload_VERSION}.zip --output /tmp/FileSideload.zip && \
    unzip -q /tmp/FileSideload.zip -d modules/ && \
    rm /tmp/FileSideload.zip

ARG ENV_MODULE_Generic_VERSION
RUN curl -L https://github.com/Daniel-KM/Omeka-S-module-Generic/releases/download/${ENV_MODULE_Generic_VERSION}/Generic-${ENV_MODULE_Generic_VERSION}.zip --output /tmp/Generic.zip && \
    unzip -q /tmp/Generic.zip -d modules/ && \
    rm /tmp/Generic.zip

ARG ENV_MODULE_HideProperties_VERSION
RUN curl -L https://github.com/zerocrates/HideProperties/releases/download/v${ENV_MODULE_HideProperties_VERSION}/HideProperties-${ENV_MODULE_HideProperties_VERSION}.zip --output /tmp/HideProperties.zip && \
    unzip -q /tmp/HideProperties.zip -d modules/ && \
    rm /tmp/HideProperties.zip

ARG ENV_MODULE_IiifSearch_VERSION
RUN curl -L https://github.com/smachefert/Omeka-S-module-IiifSearch/archive/refs/tags/v${ENV_MODULE_IiifSearch_VERSION}.zip --output /tmp/IiifSearch.zip && \
    unzip /tmp/IiifSearch.zip -d modules/ && \
    # Archives downloaded from commit hash or version tag contain a long and versioned module name so we rename it.
    mv modules/Omeka-S-module-IiifSearch-${ENV_MODULE_IiifSearch_VERSION} modules/IiifSearch && \
    rm /tmp/IiifSearch.zip

ARG ENV_MODULE_IiifServer_VERSION
RUN curl -L https://github.com/Daniel-KM/Omeka-S-module-IiifServer/releases/download/${ENV_MODULE_IiifServer_VERSION}/IiifServer-${ENV_MODULE_IiifServer_VERSION}.zip --output /tmp/IiifServer.zip && \
    unzip /tmp/IiifServer.zip -d modules/ && \
    rm /tmp/IiifServer.zip

ARG ENV_MODULE_ImageServer_VERSION
RUN curl -L https://github.com/Daniel-KM/Omeka-S-module-ImageServer/releases/download/${ENV_MODULE_ImageServer_VERSION}/ImageServer-${ENV_MODULE_ImageServer_VERSION}.zip --output /tmp/ImageServer.zip && \
    unzip /tmp/ImageServer.zip -d modules/ && \
    rm /tmp/ImageServer.zip    

ARG ENV_MODULE_Log_VERSION
RUN curl -L https://github.com/Daniel-KM/Omeka-S-module-Log/releases/download/${ENV_MODULE_Log_VERSION}/Log-${ENV_MODULE_Log_VERSION}.zip --output /tmp/Log.zip && \
    unzip -q /tmp/Log.zip -d modules/ && \
    rm /tmp/Log.zip

#RUN curl -L https://github.com/omeka-s-modules/MetadataBrowse/releases/download/v1.4.1/MetadataBrowse-1.4.1.zip --output /tmp/MetadataBrowse.zip && \
#    unzip -q /tmp/MetadataBrowse.zip -d modules/ && \
#    rm /tmp/MetadataBrowse.zip

ARG ENV_MODULE_Mirador_VERSION
RUN curl -L https://github.com/Daniel-KM/Omeka-S-module-Mirador/releases/download/${ENV_MODULE_Mirador_VERSION}/Mirador-${ENV_MODULE_Mirador_VERSION}.zip --output /tmp/MiradorViewer.zip && \
    unzip /tmp/MiradorViewer.zip -d modules/ && \
    rm /tmp/MiradorViewer.zip

ARG ENV_MODULE_ModelViewer_VERSION
RUN curl -L https://gitlab.com/mcoonen/Omeka-S-module-ModelViewer/-/archive/${ENV_MODULE_ModelViewer_VERSION}/Omeka-S-module-ModelViewer-${ENV_MODULE_ModelViewer_VERSION}.zip --output /tmp/ModelViewer.zip && \
    unzip -q /tmp/ModelViewer.zip -d modules/ && \
    mv modules/Omeka-S-module-ModelViewer-${ENV_MODULE_ModelViewer_VERSION} modules/ModelViewer && \
    # install module's dependencies via composer
    cd modules/ModelViewer && \
    composer update && \
    composer install --no-dev && \
    rm /tmp/ModelViewer.zip

ARG ENV_MODULE_NdeTermennetwerk_VERSION
RUN curl -L https://github.com/omeka-s-modules/NdeTermennetwerk/releases/download/v${ENV_MODULE_NdeTermennetwerk_VERSION}/NdeTermennetwerk-${ENV_MODULE_NdeTermennetwerk_VERSION}.zip --output /tmp/NdeTermennetwerk.zip && \
    unzip -q /tmp/NdeTermennetwerk.zip -d modules/ && \
    rm /tmp/NdeTermennetwerk.zip

ARG ENV_MODULE_NumericDataTypes_VERSION
RUN curl -L https://github.com/omeka-s-modules/NumericDataTypes/releases/download/v${ENV_MODULE_NumericDataTypes_VERSION}/NumericDataTypes-${ENV_MODULE_NumericDataTypes_VERSION}.zip --output /tmp/NumericDataTypes.zip && \
    unzip -q /tmp/NumericDataTypes.zip -d modules/ && \
    rm /tmp/NumericDataTypes.zip

ARG ENV_MODULE_PdfViewer_VERSION
#RUN curl -L https://github.com/Daniel-KM/Omeka-S-module-PdfViewer/releases/download/${ENV_MODULE_PdfViewer_VERSION}/PdfViewer-${ENV_MODULE_PdfViewer_VERSION}.zip --output /tmp/PdfViewer.zip && \
#    unzip -q /tmp/PdfViewer.zip -d modules/ && \
#    rm /tmp/PdfViewer.zip
RUN curl -L https://github.com/Daniel-KM/Omeka-S-module-PdfViewer/archive/refs/tags/${ENV_MODULE_PdfViewer_VERSION}.zip --output /tmp/PdfViewer.zip && \
    unzip -q /tmp/PdfViewer.zip -d modules/ && \
    mv modules/Omeka-S-module-PdfViewer-${ENV_MODULE_PdfViewer_VERSION} modules/PdfViewer && \
    # install module's dependencies via composer
    cd modules/PdfViewer && \
    composer update && \
    composer install --no-dev && \    
    rm /tmp/PdfViewer.zip
    
ARG ENV_MODULE_SearchSolr_VERSION
RUN curl -L https://github.com/Daniel-KM/Omeka-S-module-SearchSolr/releases/download/${ENV_MODULE_SearchSolr_VERSION}/SearchSolr-${ENV_MODULE_SearchSolr_VERSION}.zip --output /tmp/SearchSolr.zip && \
    unzip -q /tmp/SearchSolr.zip -d modules/ && \
    rm /tmp/SearchSolr.zip

ARG ENV_MODULE_Statistics_VERSION
RUN curl -L https://github.com/Daniel-KM/Omeka-S-module-Statistics/releases/download/${ENV_MODULE_Statistics_VERSION}/Statistics-${ENV_MODULE_Statistics_VERSION}.zip --output /tmp/Stats.zip && \
    unzip -q /tmp/Stats.zip -d modules/ && \
    rm /tmp/Stats.zip

ARG ENV_MODULE_UniversalViewer_VERSION
RUN curl -L https://github.com/Daniel-KM/Omeka-S-module-UniversalViewer/releases/download/${ENV_MODULE_UniversalViewer_VERSION}/UniversalViewer-${ENV_MODULE_UniversalViewer_VERSION}.zip --output /tmp/UniversalViewer.zip && \
    unzip /tmp/UniversalViewer.zip -d modules/ && \
    rm /tmp/UniversalViewer.zip

ARG ENV_MODULE_ValueSuggest_VERSION
RUN curl -L https://github.com/omeka-s-modules/ValueSuggest/releases/download/v${ENV_MODULE_ValueSuggest_VERSION}/ValueSuggest-${ENV_MODULE_ValueSuggest_VERSION}.zip --output /tmp/ValueSuggest.zip && \
    unzip -q /tmp/ValueSuggest.zip -d modules/ && \
    rm /tmp/ValueSuggest.zip

RUN echo "INFO: Please install the modules via the Omeka S admin panel."

# Install the default theme
# Our own themes will be volume-binded in docker-compose.yml
ARG ENV_THEME_Default_VERSION
RUN rm -fr themes/default && \
    curl -L https://github.com/omeka-s-themes/default/releases/download/v${ENV_THEME_Default_VERSION}/default-${ENV_THEME_Default_VERSION}.zip --output /tmp/theme-default.zip && \
    unzip -q /tmp/theme-default.zip -d themes/ && \
    rm /tmp/theme-default.zip

# Switch back to root user
USER root

# Copy other files and folders into the container
COPY config/ /var/www/html/config/
COPY .htaccess /var/www/html/.htaccess
COPY init-arkandnoid-db.tar.gz /tmp/
COPY docker-entrypoint.sh /

# Set correct ownership on www folders
RUN chown -R www-data:www-data /var/www/html/

# Expose ports to Docker network
# Port 9000 remains exposed by the upstream image, but is not used here as we're connecting to PHP-FPM over an unix socket instead of TCP/IP
EXPOSE 80

ENTRYPOINT ["/docker-entrypoint.sh"]
