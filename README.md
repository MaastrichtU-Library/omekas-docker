# Omeka S docker
Dockerized instance of Omeka S.

Based on the Docker image by 'giocomai'. (Docker Hub)[https://hub.docker.com/r/giocomai/omeka-s-docker] | (GitHub)[https://github.com/giocomai/omeka-s-docker]


## Preparation

**Database connection settings**

1. Edit the `docker-compose.yml` file and enter values for:
    ```
    MYSQL_ROOT_PASSWORD:
    MYSQL_DATABASE: 
    MYSQL_USER:
    MYSQL_PASSWORD:
    ```

1. Copy the example database config for Omeka S
    ```
    cp omeka-s/example_database.ini omeka-s/secret_database.ini
    ```

1. Edit the file with a text editor and enter the same values for `user`, `password`, `dbname` and `host`.

## Run instructions
Run the project with docker-compose
```
docker-compose up -d
```

To see logs:
```
docker-compose logs -f
```

Open your web browser and access Omeka at http://omeka.local/ 

Tip: You might need to edit `/etc/hosts` and create an entry for omeka.local that points to either `127.0.0.1` or the public IP of your machine.


