# Omeka S docker
Dockerized instance of Omeka S.

Based on the Docker image by 'giocomai'. [Docker Hub](https://hub.docker.com/r/giocomai/omeka-s-docker) | [GitHub](https://github.com/giocomai/omeka-s-docker)


## Preparation

**Load external dependencies**

After initial clone of this git repository you will have an empty `externals/` directory.
For proper Omeka S experience, `docker-compose.yml` will volume bind additional stuff from other git repositories into the Omeka S container. 

List of externals:

- Various helper scripts, e.g. ARK resolving: [omekas-helpers](https://gitlab.maastrichtuniversity.nl/ub-omekas/omekas-helpers)
- UB Theme for Omeka S: [omekas-theme-um-theses](https://gitlab.maastrichtuniversity.nl/ub-omekas/omekas-theme-um-theses)

Execute the commands below to populate the externals folder.
```
cd externals/
git clone git@gitlab.maastrichtuniversity.nl:ub-omekas/omekas-helpers.git
git clone git@gitlab.maastrichtuniversity.nl:ub-omekas/omekas-theme-um-theses.git
```
**IMPORTANT:** The externals repositories are not automatically updated locally, so make sure to `git pull` changes 
from those repositories periodically.


**Set database connection settings**

1. Edit the `docker-compose.yml` file and enter values for:
    ```
    MYSQL_ROOT_PASSWORD:
    MYSQL_DATABASE: 
    MYSQL_USER:
    MYSQL_PASSWORD:
    ```

1. Copy the example database config for Omeka S
    ```
    cp omeka-s/config/example_database.ini omeka-s/config/database.ini
    ```

1. Edit the `database.ini` file with a text editor and enter the same values for:
    ```
    user     = 
    password = 
    dbname   = 
    host     = 
    ```

## Build instructions
Build the entire project with docker compose
```
docker compose build
```

## Run instructions
Run the project with docker-compose
```
docker compose up -d
```

To see logs:
```
docker compose logs -f
```

Open your web browser and access Omeka at http://omeka.local/ 

Tip: You might need to edit `/etc/hosts` and create an entry for omeka.local that points to either `127.0.0.1` or the public IP of your machine.


## Manual configurations post-start
There are some manual configuration steps to perform after the Docker containers have started.
- [Configure CleanUrl module](README-01-CleanUrl.md)
- [Configure Solr backend](README-02-Solr.md)


## Usage
Open a browser and go to http://omeka.local.

Use the following credentials to login to the admin panel:
- User: admin@example.org
- Pass: foobar


## Create a fresh, empty environment
Omeka config settings, themes and files are saved in a persistent docker volume. Execute these commands to **delete all data** and go back to an empty, fresh experience.
```
docker compose down

docker volume ls

# This list all docker volumes on your machine. There should be entries like 
#   DRIVER    VOLUME NAME
#   local     omekas-docker_db
#   local     omekas-docker_omeka
#   local     omekas-docker_solrdata


docker volume rm omekas-docker_db omekas-docker_omeka omekas-docker_solrdata
```



## TODO Docker
- [ ] 

## TODO Solr
- [ ] Play with the (Solr) Suggester
- [ ] Find out how to precreate the * -> Copy field during bootstrap of Solr.

