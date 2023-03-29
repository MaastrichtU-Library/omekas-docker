# Configuration Solr

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
    - If you want to use a certain field in a facet or filter, then it's best to change it to the type 'string' (`_s`) or 'strings' (`_ss`) or create a new mapping of type 'string' (`_s`)  or 'strings' (`_ss`).
    - See also the note at the bottom of this readme.
4. Optional: remove the field mappings that are not needed. 

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




**Note:** There are Solr field names that resemble eachother. The Solr schema definition is different though. For example:
```
dcterms_creator_s
- type: string
- example value: "Doe, John",

dcterms_creator_ss
- type: strings
- example value: ["Doe, John"],

dcterms_creator_txt
- type: text_general
- example value: ["Doe, John"],
```
Type 'string' (s) & 'strings' (ss) store the **exact** string. Type 'text_general' (txt) performs tokenization, lower-casing etc.
For queries on type 'string' only **exact** matches are possible. 'text_general' is more flexible.
'string' and 'strings' are useful in facets and filters, whereas text_general is more useful in search queries.
More info on https://stackoverflow.com/questions/7175619/apache-solr-string-field-or-text-field


