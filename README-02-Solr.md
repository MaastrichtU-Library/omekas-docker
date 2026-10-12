# Configuration Solr

### 1. Solr configuration in Omeka S. 
Go to **Admin -> Search Manager -> Indexing - Solr**, and click the **pencil** icon to open the configuration.

Then click on the **Solr core** tab or use this [direct link](http://omeka.local/admin/search-manager/engine/2/edit) and fill in the following values in the required fields:
```
- Scheme: http
- IP or hostname: omekas_solr
- Port: 8983
- Solr core: omekas
```
Press Save button. Status should now display:
> Status: OK index incomplete (items: 0/3 indexed)

### 2. Mapping of Omeka fields to Solr fields (i.e. "Aligning the maps...")
**Admin -> Search Manager -> Indexing - Solr**, and click the **gear** icon to open the configuration.

Then click on the **Indexes** tab (or use this [direct link](http://omeka.local/admin/search-manager/solr/core/2)).
1. Click on the **Maintenance** button. A dropdown panel appears.
2. Click on **Align the maps...**. A side panel opens.
3. Keep the first 3 options checked and check these additional 2 options:
   1. **Used properties: a text and an exact index for every property with a value**
   2. **Numeric values: an integer or decimal index for the properties whose values are numbers, for a real sort and range facets**
4. Scroll down and click the **Align the maps** button. 

This shows a success message stating that Omeka metadata fields have been mapped to their corresponding `_txt`, `_s` and `_ss` Solr fields.

**Explanation of the field types**
- "_t" and "_txt" are used to store words individually. **Usage:** for search queries.
- "_s" and "_ss" are used to store whole string. **Usage:** for facets and filters.
- "_i" and "_is" are used to store integers. **Usage:** for facets and filters.
- "_dt" and "_dts" are used to store dates. **Usage:** for facets and filters.


### 3. Add (or edit) a Solr Suggester
The suggester is used to provide suggestions (autocomplete) whenever a user is typing in the search box. 

Go to **Admin -> Search Manager -> Suggesters - Solr** and click the **pencil** icon or use this [direct link](http://omeka.local/admin/search-manager/suggester/2/edit) to open the configuration.

Enter the following values in the configuration fields:
- **Solr suggester name**: omeka_suggester
- **Solr fields for suggestions:** There are multiple solutions here:
  - **All text and string fields:** simply uses `all _txt` fields defined in the field mapping
  - **suggest_txt (unified field, recommended):** uses the `suggest_txt` field auto-created by the SearchSolr module, which contains copied values from the other `_txt` fields in Solr.
  - **Individual fields:** choose any combination of `_txt` fields to power the autosuggest. This option gives you most control and allows you to exclude certain problematic fields like `extracttext_extracted_text_txt`
  - Algorithm for suggestions: AnalyzingInfixLookup (matches anywhere)

### 4. Link the Solr suggester to the search page
Go to **Admin -> Search Manager -> Pages - Default** and click the **pencil** icon to open the configuration.

Then click on the **Simple search** tab or use this [direct link](http://omeka.local/admin/search-manager/page/2/edit#simple-search).

Then expand the **Advanced settings** and add the following values in the **Autosuggestion** section.
- **Suggester:** Solr
- **Direct endpoint for suggester:** empty
- **Optional query param name for direct endpoint:** empty

Click on the **Save** button.

### 5. (Re)index Solr
Then **(re)align the maps** and **(re)index the Solr core** to ensure that the suggester is working properly.

Depending on the number of items in your Omeka S site, this may take a while. The progress of the indexing job can be monitored on the **Admin -> Jobs** page (or use this [direct link](http://omeka.local/admin/job)).

After the indexing job is completed, the status should now display:


### 6. Test it in the frontend site
Open the frontend site's search page, e.g. http://omeka.local/s/index/find and try it out. 