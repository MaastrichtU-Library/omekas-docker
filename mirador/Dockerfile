FROM node:lts-slim

RUN apt-get update && \ 
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl \
    unzip

WORKDIR /usr/src/app

ARG ENV_MIRADOR_VERSION
# 2024-04-04: npm install hangs when building Docker image. Downloading and extracting prebuilt tar.gz from MC's dropbox instead. 
#RUN curl -L https://github.com/ProjectMirador/mirador/archive/refs/tags/v${ENV_MIRADOR_VERSION}.zip --output /tmp/mirador.zip && \
#    unzip /tmp/mirador.zip -d /tmp && \
#    cp -ra /tmp/mirador-${ENV_MIRADOR_VERSION}/* /usr/src/app/
#RUN npm install
RUN curl -L "https://www.dropbox.com/scl/fi/48kj6c6v6fkpotk9iroqq/mirador-v${ENV_MIRADOR_VERSION}-build.tar.gz?rlkey=ug2nh51zwprhbvry8kmvofu68&dl=0" --output /tmp/mirador-build.tar.gz
RUN tar -xvf /tmp/mirador-build.tar.gz -C /usr/src/app

COPY docker-entrypoint.sh /

EXPOSE 4444

ENTRYPOINT ["/docker-entrypoint.sh"]

