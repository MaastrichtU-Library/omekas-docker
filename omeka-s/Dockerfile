ARG ENV_OMEKAS_DOCKER_IMAGE_VERSION
FROM giocomai/omeka-s-docker:${ENV_OMEKAS_DOCKER_IMAGE_VERSION}

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    nano

# Remove the modules-symlink to volume/
RUN rm /var/www/html/modules && \
    rm -fr /var/www/html/volume/modules/ && \
    mkdir /var/www/html/modules/

# Remove the themes-symlink to volume/
RUN rm /var/www/html/themes && \
    rm -fr /var/www/html/volume/themes/ && \
    mkdir /var/www/html/themes/

# Remove the config-symlinks to volume/
RUN rm /var/www/html/config/* && \
    rm -fr /var/www/html/volume/config/
# and add our own config files
COPY config/ /var/www/html/config/
    
# The only symlink to volume/ that remains is '/var/www/html/files'


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
ARG ENV_MODULE_AdvancedSearch_VERSION
RUN curl -L https://github.com/Daniel-KM/Omeka-S-module-AdvancedSearch/releases/download/${ENV_MODULE_AdvancedSearch_VERSION}/AdvancedSearch-${ENV_MODULE_AdvancedSearch_VERSION}.zip --output /tmp/AdvancedSearch.zip && \
    unzip /tmp/AdvancedSearch.zip -d modules/ && \
    rm /tmp/AdvancedSearch.zip

ARG ENV_MODULE_ArchiveRepertory_VERSION
RUN curl -L https://github.com/Daniel-KM/Omeka-S-module-ArchiveRepertory/releases/download/${ENV_MODULE_ArchiveRepertory_VERSION}/ArchiveRepertory-${ENV_MODULE_ArchiveRepertory_VERSION}.zip --output /tmp/ArchiveRepertory.zip && \
    unzip /tmp/ArchiveRepertory.zip -d modules/ && \
    rm /tmp/ArchiveRepertory.zip

ARG ENV_MODULE_Ark_VERSION
RUN curl -L https://gitlab.com/Daniel-KM/Omeka-S-module-Ark/-/archive/${ENV_MODULE_Ark_VERSION}/Omeka-S-module-Ark-${ENV_MODULE_Ark_VERSION}.zip --output /tmp/Ark.zip && \
    unzip /tmp/Ark.zip -d modules/ && \
    # Archives downloaded from gitlab contain a long and versioned module name so we rename it.
    mv modules/Omeka-S-module-Ark-${ENV_MODULE_Ark_VERSION} modules/Ark && \
    # install module's dependencies via composer
    cd modules/Ark && \
    composer update && \
    composer install --no-dev && \
    rm /tmp/Ark.zip

ARG ENV_MODULE_BlocksDisposition_VERSION
RUN curl -L https://github.com/Daniel-KM/Omeka-S-module-BlocksDisposition/releases/download/${ENV_MODULE_BlocksDisposition_VERSION}/BlocksDisposition-${ENV_MODULE_BlocksDisposition_VERSION}.zip --output /tmp/BlocksDisposition.zip && \
    unzip /tmp/BlocksDisposition.zip -d modules/ && \
    rm /tmp/BlocksDisposition.zip

ARG ENV_MODULE_BulkEdit_VERSION
RUN curl -L https://github.com/Daniel-KM/Omeka-S-module-BulkEdit/releases/download/${ENV_MODULE_BulkEdit_VERSION}/BulkEdit-${ENV_MODULE_BulkEdit_VERSION}.zip --output /tmp/BulkEdit.zip && \
    unzip /tmp/BulkEdit.zip -d modules/ && \
    rm /tmp/BulkEdit.zip

ARG ENV_MODULE_CleanUrl_VERSION
RUN curl -L https://github.com/mcoonen/Omeka-S-module-CleanUrl/archive/refs/tags/${ENV_MODULE_CleanUrl_VERSION}.zip --output /tmp/CleanUrl.zip && \
    unzip /tmp/CleanUrl.zip -d modules/ && \
    mv modules/Omeka-S-module-CleanUrl-${ENV_MODULE_CleanUrl_VERSION} modules/CleanUrl && \
    # install module's dependencies via composer
    cd modules/CleanUrl && \
    composer update && \
    composer install --no-dev && \
    rm /tmp/CleanUrl.zip

ARG ENV_MODULE_CSVImport_VERSION
RUN curl -L https://github.com/omeka-s-modules/CSVImport/releases/download/v${ENV_MODULE_CSVImport_VERSION}/CSVImport-${ENV_MODULE_CSVImport_VERSION}.zip --output /tmp/CSVImport.zip && \
    unzip /tmp/CSVImport.zip -d modules/ && \
    rm /tmp/CSVImport.zip

ARG ENV_MODULE_CustomVocab_VERSION
RUN curl -L https://github.com/omeka-s-modules/CustomVocab/releases/download/v${ENV_MODULE_CustomVocab_VERSION}/CustomVocab-${ENV_MODULE_CustomVocab_VERSION}.zip --output /tmp/CustomVocab.zip && \
    unzip /tmp/CustomVocab.zip -d modules/ && \
    rm /tmp/CustomVocab.zip

ARG ENV_MODULE_EUCookieBar_VERSION
RUN curl -L https://github.com/Daniel-KM/Omeka-S-module-EUCookieBar/releases/download/${ENV_MODULE_EUCookieBar_VERSION}/EUCookieBar-${ENV_MODULE_EUCookieBar_VERSION}.zip --output /tmp/EUCookieBar.zip && \
    unzip /tmp/EUCookieBar.zip -d modules/ && \
    rm /tmp/EUCookieBar.zip

ARG ENV_MODULE_ExtractText_VERSION
RUN curl -L https://github.com/omeka-s-modules/ExtractText/releases/download/v${ENV_MODULE_ExtractText_VERSION}/ExtractText-${ENV_MODULE_ExtractText_VERSION}.zip --output /tmp/ExtractText.zip && \
    unzip /tmp/ExtractText.zip -d modules/ && \
    rm /tmp/ExtractText.zip

ARG ENV_MODULE_FileSideload_VERSION
RUN curl -L https://github.com/omeka-s-modules/FileSideload/releases/download/v${ENV_MODULE_FileSideload_VERSION}/FileSideload-${ENV_MODULE_FileSideload_VERSION}.zip --output /tmp/FileSideload.zip && \
    unzip /tmp/FileSideload.zip -d modules/ && \
    rm /tmp/FileSideload.zip

ARG ENV_MODULE_Generic_VERSION
RUN curl -L https://github.com/Daniel-KM/Omeka-S-module-Generic/releases/download/${ENV_MODULE_Generic_VERSION}/Generic-${ENV_MODULE_Generic_VERSION}.zip --output /tmp/Generic.zip && \
    unzip /tmp/Generic.zip -d modules/ && \
    rm /tmp/Generic.zip

ARG ENV_MODULE_HideProperties_VERSION
RUN curl -L https://github.com/zerocrates/HideProperties/releases/download/v${ENV_MODULE_HideProperties_VERSION}/HideProperties-${ENV_MODULE_HideProperties_VERSION}.zip --output /tmp/HideProperties.zip && \
    unzip /tmp/HideProperties.zip -d modules/ && \
    rm /tmp/HideProperties.zip

#RUN curl -L https://github.com/omeka-s-modules/MetadataBrowse/releases/download/v1.4.1/MetadataBrowse-1.4.1.zip --output /tmp/MetadataBrowse.zip && \
#    unzip /tmp/MetadataBrowse.zip -d modules/ && \
#    rm /tmp/MetadataBrowse.zip

ARG ENV_MODULE_ModelViewer_VERSION
#RUN curl -L https://github.com/Daniel-KM/Omeka-S-module-ModelViewer/releases/download/${ENV_MODULE_ModelViewer_VERSION}/ModelViewer-${ENV_MODULE_ModelViewer_VERSION}.zip --output /tmp/ModelViewer.zip && \
#    unzip /tmp/ModelViewer.zip -d modules/ && \
#    rm /tmp/ModelViewer.zip
RUN curl -L https://gitlab.com/mcoonen/Omeka-S-module-ModelViewer/-/archive/${ENV_MODULE_ModelViewer_VERSION}/Omeka-S-module-ModelViewer-${ENV_MODULE_ModelViewer_VERSION}.zip --output /tmp/ModelViewer.zip && \
    unzip /tmp/ModelViewer.zip -d modules/ && \
    mv modules/Omeka-S-module-ModelViewer-${ENV_MODULE_ModelViewer_VERSION} modules/ModelViewer && \
    # install module's dependencies via composer
    cd modules/ModelViewer && \
    composer update && \
    composer install --no-dev && \    
    rm /tmp/ModelViewer.zip

ARG ENV_MODULE_NumericDataTypes_VERSION
RUN curl -L https://github.com/omeka-s-modules/NumericDataTypes/releases/download/v${ENV_MODULE_NumericDataTypes_VERSION}/NumericDataTypes-${ENV_MODULE_NumericDataTypes_VERSION}.zip --output /tmp/NumericDataTypes.zip && \
    unzip /tmp/NumericDataTypes.zip -d modules/ && \
    rm /tmp/NumericDataTypes.zip

ARG ENV_MODULE_PdfViewer_VERSION
#RUN curl -L https://github.com/Daniel-KM/Omeka-S-module-PdfViewer/releases/download/${ENV_MODULE_PdfViewer_VERSION}/PdfViewer-${ENV_MODULE_PdfViewer_VERSION}.zip --output /tmp/PdfViewer.zip && \
#    unzip /tmp/PdfViewer.zip -d modules/ && \
#    rm /tmp/PdfViewer.zip
RUN curl -L https://github.com/mcoonen/Omeka-S-module-PdfViewer/archive/refs/tags/${ENV_MODULE_PdfViewer_VERSION}.zip --output /tmp/PdfViewer.zip && \
    unzip /tmp/PdfViewer.zip -d modules/ && \
    mv modules/Omeka-S-module-PdfViewer-${ENV_MODULE_PdfViewer_VERSION} modules/PdfViewer && \
    # install module's dependencies via composer
    cd modules/PdfViewer && \
    composer update && \
    composer install --no-dev && \    
    rm /tmp/PdfViewer.zip
    
ARG ENV_MODULE_SearchSolr_VERSION
RUN curl -L https://github.com/Daniel-KM/Omeka-S-module-SearchSolr/releases/download/${ENV_MODULE_SearchSolr_VERSION}/SearchSolr-${ENV_MODULE_SearchSolr_VERSION}.zip --output /tmp/SearchSolr.zip && \
    unzip /tmp/SearchSolr.zip -d modules/ && \
    rm /tmp/SearchSolr.zip

ARG ENV_MODULE_ValueSuggest_VERSION
RUN curl -L https://github.com/omeka-s-modules/ValueSuggest/releases/download/v${ENV_MODULE_ValueSuggest_VERSION}/ValueSuggest-${ENV_MODULE_ValueSuggest_VERSION}.zip --output /tmp/ValueSuggest.zip && \
    unzip /tmp/ValueSuggest.zip -d modules/ && \
    rm /tmp/ValueSuggest.zip



# NOTE: Downloaded modules need to be installed in the Admin UI. The Installation-Status survives a rebuild of the Omeka S container, so I guess the installation makes changes to the database only.


# Install the default theme
# Our own themes will be volume-binded in docker-compose.yml
ARG ENV_THEME_Default_VERSION
RUN curl -L https://github.com/omeka-s-themes/default/releases/download/v${ENV_THEME_Default_VERSION}/default-${ENV_THEME_Default_VERSION}.zip --output /tmp/theme-default.zip && \
    unzip /tmp/theme-default.zip -d themes/ && \
    rm /tmp/theme-default.zip


# Copy other files and folders into the container
COPY .htaccess /var/www/html/.htaccess
COPY init-arkandnoid-db.tar.gz /tmp/
COPY docker-entrypoint.sh /

# Set correct ownership on www folders
RUN chown -R www-data:www-data /var/www/html/

ENTRYPOINT ["/docker-entrypoint.sh"]
