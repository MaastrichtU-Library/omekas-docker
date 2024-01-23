FROM solr:8.11.1

# 2022-10-20
# Apache commons-text < v1.10 contains a security vulnerability (CVE-2022-42889)
# See https://www.ncsc.nl/actueel/advisory?id=NCSC-2022-0650
# This fix replaces v1.6 with v1.10 until the Docker image is fixed by Solr developers.
USER root

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    nano

# RUN rm /opt/solr/server/solr-webapp/webapp/WEB-INF/lib/commons-text-1.6.jar
# COPY ./commons-text-1.10.0.jar /opt/solr/server/solr-webapp/webapp/WEB-INF/lib/commons-text-1.10.0.jar


USER $SOLR_USER



COPY ./docker-entrypoint.sh /opt/docker-entrypoint.sh

ENTRYPOINT ["/opt/docker-entrypoint.sh"]

