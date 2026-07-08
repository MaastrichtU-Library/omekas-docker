ARG ENV_PHP_VERSION=8.2
FROM php:${ENV_PHP_VERSION}-fpm-bookworm AS php-builder

# Install development headers required for installing the PHP extensions
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libfreetype6-dev \
    zlib1g-dev \
    libpng-dev \
    libjpeg-dev \
    libtiff-dev \
    imagemagick \
    ghostscript

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
    # for module ImageServer
    exif \
    ffi \
    ## For the module config's "Image processor" setting we need the deprecated 'php-vips-ext' php-extension, as the image processor does not work with the newer 'php-vips' a.k.a. 'jcupitt/vips' package
    vips \
    # for module NumericDataTypes
    intl

# Section for module ImageServer's Fast Tile script
# The Fast Tile script (ImageServer/data/scripts/iiiftile.php) uses the 'jcupitt/vips' package and PHP extension 'ffi' to call the OS's 'libvips' library
# Modify the config for FFI
RUN echo "ffi.enable = true" >> /usr/local/etc/php/conf.d/docker-php-ext-ffi.ini



FROM php-builder AS php-debug
# Install extension for remote debugging in IDE (e.g. PhpStorm)
RUN install-php-extensions xdebug \
    && echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    # Uncomment this to write xdebug logs to a file
#    && echo "xdebug.log = /tmp/xdebug.log" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    # Uncomment this one to start debugger on every request, regardless of the cookie set by the browser extension
#    && echo "xdebug.start_with_request = yes" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.client_host = dockerhost.local" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini



FROM php:${ENV_PHP_VERSION}-fpm-bookworm AS os-builder

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    # Common software
    apache2 \
    curl \
    nano \
    unzip \
    # to test database connectivity during entrypoint script
    default-mysql-client \
    # iproute2 is used to retrieve the IP of the docker host machine (needed for Xdebug connections)
    iproute2 \
    # runtime libraries (runtime equivalents) for the PHP extensions we compiled in the previous stage
    libfreetype6 \
    zlib1g \
    libpng16-16 \
    libjpeg62-turbo \
    libtiff6 \
    libavif15 \
    libzip4 \
    libxpm4 \
    imagemagick \
    ghostscript \
    # for reading the modules.json file \
    jq \
    # for (IIIF) image processing
    libvips-tools \
    # for module ExtractText
    poppler-utils \
    # for Omeka S module NumericDataTypes
    libicu-dev

# Some modules require composer
# In Docker it cannot be installed via apt because of unmet php dependencies
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Imagemagick config
# Thumbnails in Omeka S created by Imagemagick
# Processing PDF was disabled in ImageMagick config because of a vulnerability in GhostScript < 9.24 (see https://www.kb.cert.org/vuls/id/332928/)
# We're using GhostScript version 10.00.0 or higher, so we can safely re-enable the ImageMagick processing for PDF
RUN sed -i 's_<policy domain="coder" rights="none" pattern="PDF" />_<policy domain="coder" rights="read|write" pattern="PDF" />_g' /etc/ImageMagick-6/policy.xml

# PHP config
COPY php-config/99-omeka.ini $PHP_INI_DIR/conf.d/

# PHP-FPM config
RUN sed -i 's|error_log = /proc/self/fd/2|error_log = /var/log/php-fpm.log|g' /usr/local/etc/php-fpm.d/docker.conf && \
    sed -i 's|access.log = /proc/self/fd/2|access.log = /var/log/php-fpm.log|g' /usr/local/etc/php-fpm.d/docker.conf

# Override the default listen address on port 9000 to a Unix socket.
# As of January 2026, the file `zz-docker.conf` only contains daemonize = no under the [global] directive. This should not be overridden.
# It is recommended to place user configuration in its own .conf file within /usr/local/etc/php-fpm.d/
# Source: readme on https://hub.docker.com/_/php
RUN printf '[www]\nlisten = /run/php-fpm.sock\nlisten.owner = www-data\nlisten.group = www-data\n' \ > /usr/local/etc/php-fpm.d/zz-socket-user-config.conf

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
# TODO: module IiifServer also sets CORS headers in its config by default. This invalidates the Apache CORS headers. Two options: 1) remove CORS headers from apache config file, 2) unattendedly configure the module and unchecking the "Append CORS headers to web server response" checkbox
RUN a2enmod headers



FROM os-builder AS omeka-runtime

# Copy compiled extensions and ini files from the php-builder stage
COPY --from=php-builder /usr/local/lib/php/extensions/ /usr/local/lib/php/extensions/
COPY --from=php-builder /usr/local/etc/php/conf.d/ /usr/local/etc/php/conf.d/

# Add Omeka-S cli tool from GhentCDH
ARG ENV_OMEKAS_CLI_VERSION
RUN curl -L https://github.com/GhentCDH/Omeka-S-Cli/releases/download/v${ENV_OMEKAS_CLI_VERSION}/omeka-s-cli.phar --output /usr/local/bin/omeka-s-cli && \
    chmod +x /usr/local/bin/omeka-s-cli

# Download Omeka S core
ARG ENV_OMEKAS_BASE_PATH
ARG ENV_OMEKAS_VERSION
RUN rm -fr ${ENV_OMEKAS_BASE_PATH}/* && \
    omeka-s-cli core:download ${ENV_OMEKAS_BASE_PATH}/ ${ENV_OMEKAS_VERSION}

# Put files/ folder in data volume and symlink to it from Omeka S folder
RUN mkdir -p ${ENV_OMEKAS_BASE_PATH}/volume/files/ && \
    rm -Rf ${ENV_OMEKAS_BASE_PATH}/files/ && \
    ln -s ${ENV_OMEKAS_BASE_PATH}/volume/files/ ${ENV_OMEKAS_BASE_PATH}/files
VOLUME ${ENV_OMEKAS_BASE_PATH}/volume/

# Precreate the IIIF manifest cache folders
RUN mkdir -p ${ENV_OMEKAS_BASE_PATH}/files/iiif/2 && \
    mkdir -p ${ENV_OMEKAS_BASE_PATH}/files/iiif/3

# For module ImageServer
# Copy the modified composer.json and composer.lock files, which mention the `jcupitt/vips' package, into the container.
# This has the advantage that we do not need to provide a GitHub API token to the Docker build (composer would otherwise resolve the entire dependency tree, whereby it needs API access to GitHub).
COPY composer/composer.json composer/composer.lock ${ENV_OMEKAS_BASE_PATH}

# Download default themes
# Our own themes will be volume-binded in docker-compose.yml
ARG ENV_THEME_Default_VERSION
RUN omeka-s-cli theme:download default:${ENV_THEME_Default_VERSION}
RUN omeka-s-cli theme:download freedom

# Download all modules defined in modules.json
# When url is null, the module is downloaded via the omeka-s-cli registry shorthand (Name:version).
# When url is set, the {version} placeholder is replaced and the full URL is passed to omeka-s-cli.
COPY install/modules.json /opt/modules.json
RUN jq -r '.[] | "\(.name) \(.version) \(if .url == null then "null" else .url end)"' /opt/modules.json | \
    while read -r name version url; do \
        if [ "$url" = "null" ]; then \
            omeka-s-cli module:download "${name}:${version}"; \
        else \
            resolved_url=$(echo "$url" | sed "s/{version}/${version}/g"); \
            omeka-s-cli module:download "${resolved_url}"; \
        fi; \
    done

# copy files into Omeka folder
COPY config/ ${ENV_OMEKAS_BASE_PATH}/config/
COPY .htaccess ${ENV_OMEKAS_BASE_PATH}/.htaccess

# Set correct ownership on www folders
RUN chown -R www-data:www-data ${ENV_OMEKAS_BASE_PATH}/

# Copy other files and folders into the container
COPY init-arkandnoid-db.tar.gz /tmp/
COPY install/vocabularies.json /opt/vocabularies.json
COPY install/resource-templates.json /opt/resource-templates.json
COPY docker-entrypoint.sh /

# Expose ports to Docker network
# Port 9000 remains exposed by the upstream image, but is not used here as we're connecting to PHP-FPM over an unix socket instead of TCP/IP
EXPOSE 80

ENTRYPOINT ["/docker-entrypoint.sh"]



FROM omeka-runtime AS omeka-debug
# Copy compiled extensions and ini files from the php-debug stage
COPY --from=php-debug /usr/local/lib/php/extensions/ /usr/local/lib/php/extensions/
COPY --from=php-debug /usr/local/etc/php/conf.d/ /usr/local/etc/php/conf.d/

