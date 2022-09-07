FROM giocomai/omeka-s-docker:v3.2.0

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    nano


# Remove the symlink to volume/
RUN rm /var/www/html/modules && \
    rm -fr /var/www/html/volume/modules/ && \
    mkdir /var/www/html/modules/

# Install modules
RUN curl -L https://github.com/Daniel-KM/Omeka-S-module-AdvancedSearch/releases/download/3.3.6.13/AdvancedSearch-3.3.6.13.zip --output /tmp/AdvancedSearch.zip && \
    unzip /tmp/AdvancedSearch.zip -d modules/ && \
    rm /tmp/AdvancedSearch.zip

RUN curl -L https://github.com/Daniel-KM/Omeka-S-module-BulkEdit/releases/download/3.3.13.4/BulkEdit-3.3.13.4.zip --output /tmp/BulkEdit.zip && \
    unzip /tmp/BulkEdit.zip -d modules/ && \
    rm /tmp/BulkEdit.zip

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

RUN chown -R www-data:www-data /var/www/html/modules/

# NOTE: Downloaded modules need to be installed in the Admin UI. The Installation-Status survives a rebuild of the Omeka S container, so I guess the installation makes changes to the database only.

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
