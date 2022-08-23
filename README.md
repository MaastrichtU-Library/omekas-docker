# Omeka S docker
Dockerized instance of Omeka S.

Based on the Docker image by 'giocomai'. [Docker Hub](https://hub.docker.com/r/giocomai/omeka-s-docker) | [GitHub](https://github.com/giocomai/omeka-s-docker)


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

1. Edit the `secret_database.ini` file with a text editor and enter the same values for:
    ```
    user     = 
    password = 
    dbname   = 
    host     = 
    ```


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


## Create a fresh, empty environment
Omeka config settings, themes and files are saved in a persistent docker volume. Execute these commands to **delete all data** and go back to an empty, fresh experience.
```
docker-compose down

docker volume ls

# This list all docker volumes on your machine. There should be entries like 
#   DRIVER    VOLUME NAME
#   local     omekas-docker_db
#   local     omekas-docker_omeka
#   local     omekas-docker_solrdata


docker volume rm omekas-docker_db omekas-docker_omeka omekas-docker_solrdata
```


## Configuration
### Solr configuration in Omeka S. 
Go to Admin -> Modules -> Search Manager, sub-menu Solr:
```
- IP or hostname: omekas_solr
- Port: 8983
- Solr core: omekas
```
Press Save button. Status should now display **OK**.

### Mapping of Omeka fields to Solr fields
Go to Admin -> Modules -> Search Manager, sub-menu Solr:
1. Click the **configuration icon** (3rd from the right, the 3 sliders)
2. Click on the **Gears icon** next to Item
3. Click the **Map all used properties** button. This adds all the fields used in Omeka S to the Solr mapping. 
    - By default it makes them of type `_txt`. 
    - If you want to use a certain field in a facet or filter, then it's best to change it to the type 'string' or 'strings' or create a new mapping of type 'string' or 'strings'.
    - See also the note at the bottom of this readme.
4. Optional: remote the field mappings that are not needed. 

### Search configuration in Omeka S.
Perform the steps described in the Module's [README](https://github.com/Daniel-KM/Omeka-S-module-SearchSolr#quick-start). Briefly:
1. Add a new **Search engine** with name **Solr** (or something of your choice), Solr core **Default**
2. Start the (re)indexing process with the button (two arrows forming a circle).
3. Add a new search **Page** with name **SolrSearch** (or something of your choice), path **solrsearch** (or something of your choice), Search engine **Solr [via Solarium]**, Form **Main**
4. Activate your desired **Filters**, **Facets** and **Sort fields** by copy-pasting them from the *Available <filters/facets/sort fields>* to the field above.
5. In admin or site settings --> enable the search form
6. Add a navigation link to the search page in the navigation settings of the site.

#### IMPORTANT NOTICE
Workaround when SolrSearch does not return results for text queries. Add a `* -> _text_` **Copy field** in the Solr admin backend. Go to core **omekas** --> **Schema** and add a Copy Field with source `*` and destination `_text_`. 

_Maarten, 23-8-2022: I still need to figure out how to automate the precreation of this field._


Note: There are Solr field names that resemble eachother. The Solr schema definition is different though. For example:
```
dcterms_creator_s
- type: string
- example value: "Schmidt, Janina",

dcterms_creator_ss
- type: strings
- example value: ["Schmidt, Janina"],

dcterms_creator_txt
- type: text_general
- example value: ["Schmidt, Janina"],
```
Type 'string' (s) & 'strings' (ss) store the **exact** string. Type 'text_general' (txt) performs tokenization, lower-casing etc.
For queries on type 'string' only **exact** matches are possible. 'text_general' is more flexible.
'string' and 'strings' are useful in facets and filters, whereas text_general is more useful in search queries.
More info on https://stackoverflow.com/questions/7175619/apache-solr-string-field-or-text-field




## TODO Docker
- [ ] Use a config file to control which modules will be downloaded and installed
- [ ] Install modules unattendedly
- [ ] Create (and configure?) site unattendedly
- [ ] Activate theme for site unattendedly
- [ ] Load representative test data / demo content into Omeka S (SQL import + copy items and media to files/ folder?)
- [ ] Determine which .htaccess tricks need to be reimplemented here (or in nginx-proxy)
- [ ] Increase upload size in .htaccess as well

## TODO Solr
- [ ] Modify theme so that search bar on all pages performs the solrsearch
- [ ] Load many PDFs
- [ ] Play with the (Solr) Suggester
- [ ] Find out how to precreate the * -> Copy field during bootstrap of Solr.

