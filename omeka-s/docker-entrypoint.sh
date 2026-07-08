#!/bin/bash

OSC="omeka-s-cli"

# -----------------------------------------------------
# Xdebug configuration
# -----------------------------------------------------

# Add an /etc/hosts entry for the IP of the Docker host machine (required for Xdebug connections to PhpStorm on the host)
echo "$(ip route|awk '/default/ { print $3 }') dockerhost.local" >> /etc/hosts


# -----------------------------------------------------
# Omeka operations that need to happen during runtime
# -----------------------------------------------------

# Generate database configuration file
echo "Creating database.ini in ${OMEKAS_BASE_PATH}/config/ ..."
rm -f /var/www/html/config/database.ini
echo "user     = \"$MYSQL_USER\"" > ${OMEKAS_BASE_PATH}/config/database.ini
echo "password = \"$MYSQL_PASSWORD\"" >> ${OMEKAS_BASE_PATH}/config/database.ini
echo "dbname   = \"$MYSQL_DATABASE\"" >> ${OMEKAS_BASE_PATH}/config/database.ini
echo "host     = \"$MYSQL_HOST\"" >> ${OMEKAS_BASE_PATH}/config/database.ini
echo "Done creating database.ini !"

wait_for_db() {
    echo "Waiting for database to be ready..."
    local max_attempts=30
    local attempt=1

    while [ $attempt -le $max_attempts ]; do
        if mysql -h"${MYSQL_HOST:-db}" -P"${MYSQL_PORT:-3306}" -u"${MYSQL_USER:-omekas}" -p"${MYSQL_PASSWORD:-difficult_omek4s_password}" -e "SELECT 1;" >/dev/null 2>&1; then
            echo "Database is ready!"
            return 0
        fi
        echo "Database not ready, attempt $attempt/$max_attempts. Waiting 5 seconds..."
        sleep 5
        attempt=$((attempt + 1))
    done

    echo "ERROR: Database failed to become ready after $max_attempts attempts"
    exit 1
}
wait_for_db

# Install Omeka S core if not already installed
    if $OSC core:status --base-path ${OMEKAS_BASE_PATH} | grep -q "^installed"; then
        echo "Omeka S core is already installed. Skipping installation."
    else
        # install core
        echo "Installing Omeka S core ..."
        $OSC core:install \
            --admin-name "${OMEKAS_ADMIN_NAME:-admin}" \
            --admin-email "${OMEKAS_ADMIN_EMAIL:-admin@example.com}" \
            --admin-password "${OMEKAS_ADMIN_PASSWORD:-admin}" \
            --title "${OMEKAS_TITLE:-Omeka S}" \
            --time-zone "${OMEKAS_TIME_ZONE:-UTC}" \
            --locale "${OMEKAS_LOCALE:-en_US}" \
            --base-path ${OMEKAS_BASE_PATH:-/var/www/html}

        # Install everything from composer.json to the 'vendor/' folder in the Omeka root, including the 'jcupitt/vips' library.
        echo "Installing composer dependencies for module ImageServer ..."
        composer install --working-dir=${OMEKAS_BASE_PATH} --no-dev --prefer-dist --no-interaction
    fi

# Note: Docker volume-binds are not available during build stage.
# Ensure that some of the necessary directories exist and are owned by www-data
dirs=(
    "${OMEKAS_BASE_PATH}/files/temp"
    "${OMEKAS_BASE_PATH}/files/datacatalogs" # module Linked Data Sets
    "${OMEKAS_BASE_PATH}/files/datadumps"    # module Linked Data Sets
    "${OMEKAS_BASE_PATH}/files/tile"         # module ImageServer
    "${OMEKAS_BASE_PATH}/files/tile/cache"   # module ImageServer
)

for dir in "${dirs[@]}"; do
    if [[ ! -d "$dir" ]]; then
        echo "Creating directory $dir..."
        mkdir -p "$dir"
        chown www-data:www-data "$dir"
    fi
done

# Unpack the initial ARK database
tar -xvf /tmp/init-arkandnoid-db.tar.gz -C ${OMEKAS_BASE_PATH}/files/

# Install all modules defined in modules.json
jq -r '.[].name' /opt/modules.json | \
    while read -r name; do
        $OSC module:install "${name}" --base-path ${OMEKAS_BASE_PATH}
    done

# Create site
# TODO: create site via SQL import?

# Configure search page
# TODO: configure Advanced Search page and settings via SQL import?

# Download and import vocabularies defined in vocabularies.json
jq -r '.[] | [.label, .version, .url, .namespaceUri, .prefix] | @tsv' /opt/vocabularies.json | \
  while IFS=$'\t' read -r label version url namespaceUri prefix; do
      resolved_url=$(echo "$url" | sed "s/{version}/${version}/g")
      $OSC vocabulary:import \
          --url "$resolved_url" \
          --namespace-uri "$namespaceUri" \
          --prefix "$prefix" \
          --label "$label - $version" \
          --format=rdfxml \
          --base-path "$OMEKAS_BASE_PATH"
  done

# TODO: Import custom vocabularies
# e.g. omeka-s-cli custom-vocabulary:import custom_vocab_terms.json 3 (or 4, 5, 6)

# Download and import resource templates defined in resource-templates.json
mkdir -p /tmp/resource-templates/
jq -r '.[] | [.name, .version, .url] | @tsv' /opt/resource-templates.json | \
    while IFS=$'\t' read -r name version url; do
        resolved_url=$(echo "$url" | sed "s/{version}/${version}/g" | sed "s/{name}/${name}/g")
        curl -L ${resolved_url} --output /tmp/resource-templates/${name}.json
        $OSC resource-template:import \
            "/tmp/resource-templates/${name}.json" \
            --base-path ${OMEKAS_BASE_PATH}
    done

# -----------------------------------------------------
# Apache and PHP-FPM startup
# -----------------------------------------------------
service apache2 start
php-fpm -D

# End with a persistent foreground process
tail -F ${OMEKAS_BASE_PATH}/logs/application.log \
        ${OMEKAS_BASE_PATH}/logs/sql.log \
        /var/log/apache2/access.log \
        /var/log/apache2/error.log \
        /var/log/php-fpm.log

