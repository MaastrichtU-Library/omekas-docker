FROM giocomai/omeka-s-docker:v3.2.0

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    nano

CMD ["apache2-foreground"]
