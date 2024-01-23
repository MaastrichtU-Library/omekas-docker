#!/bin/bash

# Enable job control (required for fg-command)
set -m

# Pre-create the Solr core
precreate-core omekas

# Start Solr in foreground and continue with the rest of this script 
solr-foreground &

# Change the Solr Schema on intial start only
sleep 10
if ! [ -f /var/solr/solr_schema_modified ]; then
    echo "Modifying Solr schema via API..."
    # Copy all to '_text_' field for cases where there is no default field described.
    # See: https://gitlab.com/Daniel-KM/Omeka-S-module-SearchSolr/-/blob/master/README.md#fixing-the-issue-when-there-is-no-result
    curl --retry 5 --connect-timeout 5 -X POST --data-binary '{"add-copy-field":{"source":"*","dest":"_text_" }}' 'http://localhost:8983/solr/omekas/schema'

    # Add the 'solr.ASCIIFoldingFilterFactory' class to the index- and query-analyzers
    curl --retry 5 --connect-timeout 5 -X POST -H 'Content-type:application/json' http://localhost:8983/solr/omekas/schema --data-binary @- << EOF
{
	"replace-field-type": {
		"name": "text_general",
		"class": "solr.TextField",
		"positionIncrementGap": "100",
		"multiValued": true,
		"indexAnalyzer": {
			"tokenizer": {
				"class": "solr.StandardTokenizerFactory"
			},
			"filters": [
				{
					"class": "solr.StopFilterFactory",
					"words": "stopwords.txt",
					"ignoreCase": "true"
				},
				{
					"class": "solr.LowerCaseFilterFactory"
				},
				{	class: "solr.ASCIIFoldingFilterFactory",
					preserveOriginal: "true"
				}
			]
		},
		"queryAnalyzer": {
			"tokenizer": {
				"class": "solr.StandardTokenizerFactory"
			},
			"filters": [
				{
					"class": "solr.StopFilterFactory",
					"words": "stopwords.txt",
					"ignoreCase": "true"
				},
				{
					"class": "solr.SynonymGraphFilterFactory",
					"expand": "true",
					"ignoreCase": "true",
					"synonyms": "synonyms.txt"
				},
				{
					"class": "solr.LowerCaseFilterFactory"
				},
				{	class: "solr.ASCIIFoldingFilterFactory",
					preserveOriginal: "true"
				}
			]
		}
	}
}
EOF

    touch /var/solr/solr_schema_modified
    echo "Done"
fi


# Return to the foreground process (writes to stdout)
fg %1
