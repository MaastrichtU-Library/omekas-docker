FROM node:lts-slim

RUN apt-get update && \ 
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl \
    unzip \
    # Required for npm install \
    build-essential \
    pkg-config \
    libcairo2-dev \
    libpango1.0-dev \
    libjpeg-dev \
    libgif-dev \
    librsvg2-dev \
    libpixman-1-dev \
    python3

WORKDIR /usr/src/app

ARG ENV_MIRADOR_VERSION
RUN curl -L https://github.com/ProjectMirador/mirador/archive/refs/tags/v${ENV_MIRADOR_VERSION}.zip --output /tmp/mirador.zip && \
    unzip /tmp/mirador.zip -d /tmp && \
    cp -ra /tmp/mirador-${ENV_MIRADOR_VERSION}/* /usr/src/app/
RUN npm install

COPY docker-entrypoint.sh /

EXPOSE 4444

ENTRYPOINT ["/docker-entrypoint.sh"]

