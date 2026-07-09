# LinkedDataSets module and Triple store usage

The [Linked Data Sets (LDS) module](https://github.com/netwerk-digitaal-erfgoed/Omeka-S-Module-LinkedDataSets) has been
developed by the Dutch _Netwerk Digitaal Erfgoed (NDE)_ to **describe** and **publish** your Omeka S dataset(s) as
Linked Data Sets to external platforms.

Potential use cases include:

- Automated registrations to the NDE Dataset Register at https://datasetregister.netwerkdigitaalerfgoed.nl/
- Publishing your dataset(s) as RDF on external triple stores, such
  as [GraphDB](https://graphdb.ontotext.com/), [Virtuoso](https://virtuoso.openlinksw.com/),
  or [Qlever](https://github.com/ad-freiburg/qlever), or others.

## LDF module usage instructions

The Linked Data sets module has already been installed in this Dockerized Omeka S instance.
Configuration and usage instructions are described below.

1. Familiarize yourself with
   the [conceptual model](https://github.com/netwerk-digitaal-erfgoed/Omeka-S-Module-LinkedDataSets/blob/main/doc/ConceptualModel.md)
   that the module uses.
2. Create a the required LDS-entities (i.e. items in Omeka S for **LDS Person, Organization, DataCatalog, Dataset, and
   Distribution). Follow the instructions in
   the [module's documentation](https://github.com/netwerk-digitaal-erfgoed/Omeka-S-Module-LinkedDataSets/blob/main/doc/Usage.md#1---creating-a-data-catalog-with-dataset-descriptions-with-distributions).
3. Register your datacatalog URL (i.e.
   `https://{omeka fqdn}/files/datacatalogs/datacatalog-{datacatalog item ID}.{ttl|nt|jsonld|xml}`) in
   the [NDE Dataset Register](https://datasetregister.netwerkdigitaalerfgoed.nl/). This will automatically harvest the
   data sets in your catalog and make them findable for others.
4. A job makes sure that RDF data dumps (distributions) are being (re)created every time a LDS Dataset 
   is being saved. The file / URL can be retrieved in the `schema:contentUrl` metadata field of the **LDS Distribution item**.
5. Load the RDF data dump in a triple store (GraphDB, Virtuoso, Qlever, etc.). Since this repository uses GraphDB, we
   will describe those steps below, but any triple store should work.

### Gotcha's

Some tips that might make your life easier:

- **Do not make the LDS-items part of any site.** Items that are part of a site are being shown in the Omeka S frontend.
  Since the LDS-items are often only for backend or administrative purposes, you might want to hide them from the
  frontend.
- **Set a URL-friendly name to the distribution (with file extension):** Avoid the use of spaces and set a file
  extension in the distribution name, as this will be used in the URL of the data dump.
   - Detailed explanation: The distribution metadata allows you to set a `schema:encodingFormat` value (i.e. `text/turtle`,
     `application/rdf+xml`, etc.), but this does not propagate as file extension to the distribution's download URL. So,
     in order to have a URL like `https://{omeka fqdn}/files/datadumps/my-distro-name.ttl` instead of
     `https://{omeka fqdn}/files/datadumps/my-distro-name`, make sure to add the file extension as value in the
     `schema:name` metadata field for the distribution item (e.g. `"schema:name": "my-distro-name.ttl"`).

## GraphDB usage instructions

1. Make sure that the GraphDB docker container is running.
2. Access the GraphDB Workbench at http://triples.local/, obtain a free evaluation license and activate that.
3. Go to “Users and Access” in the menu on the left and click the “Create new user” button. Enter username, password and
   assign a role.
4. Go to "Setup - Repositories" in the menu on the left and Click the "Create a new repository" button.
5. Import the RDF data dump(s) that have been created with the LDS module into the newly created repository. This can be
   done by going to "Import - Upload RDF files" in the menu on the left.
6. Go to Setup - Autocomplete in the menu on the left. Set the Autocomplete slider to **On**. This allows you to easily 
   search on metadata values that you are familiar with in Omeka S (i.e. the labels). Click the “Add label” button to add 
   label IRIs that your want to be autocompleted. Labels that are useful when working with Omeka S data:
```
http://omeka.org/s/vocabs/o#title
http://omeka.org/s/vocabs/o#label
https://schema.org/author
```
7. Explore the features of GraphDB on your own RDF data, e.g. SPARQL queries, Visual graph explorer, Graphs overview, etc.