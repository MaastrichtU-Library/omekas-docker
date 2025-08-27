#!/bin/bash

# Copied this from the original Docker image's `docker-entrypoint.sh` for version 9.7.0
# This script creates sets some vars and creates some dirs if they don't exist, such as the SOLR home dir `/var/solr/data`
# Essential for running Solr (copied) 
init-var-solr

# Enable job control (required for fg-command)
set -m

# Pre-create the Solr core
precreate-core ${ENV_SOLR_CORE}

# Start Solr in foreground and continue with the rest of this script 
solr-foreground &

# Wait until Solr has started and port 8983 becomes available
until nc -z localhost 8983; do
    >&2 echo "Solr is unavailable - sleeping"
    sleep 1
done

# Change the Solr Schema on intial start only
if ! [ -f /var/solr/solr_schema_modified ]; then
    echo "Modifying Solr schema via API..."
    # Copy all to '_text_' field for cases where there is no default field described.
    # See: https://gitlab.com/Daniel-KM/Omeka-S-module-SearchSolr/-/blob/master/README.md#fixing-the-issue-when-there-is-no-result
    curl --retry 5 --connect-timeout 5 -X POST http://localhost:8983/solr/${ENV_SOLR_CORE}/schema --data-binary '{"add-copy-field":{"source":"*","dest":"_text_" }}'

    # Add the 'solr.ASCIIFoldingFilterFactory' class to the index- and query-analyzers
    curl --retry 5 --connect-timeout 5 -X POST -H 'Content-type:application/json' http://localhost:8983/solr/${ENV_SOLR_CORE}/schema --data-binary @- << EOF
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

    # 1. Solr schema: Add a new field definition
    curl --retry 5 --connect-timeout 5 -X POST -H 'Content-type:application/json' http://localhost:8983/solr/${ENV_SOLR_CORE}/schema \
    --data-binary '{
      "add-field": {
        "name": "date_year_agg_i",
        "type": "pint",
        "stored": true,
        "indexed": true
      }
    }'

    # 2. Solr schema: Add CopyField rules so that the year is copied from multiple date (year) fields to the new field
    curl --retry 5 --connect-timeout 5 -X POST http://localhost:8983/solr/${ENV_SOLR_CORE}/schema --data-binary '{
      "add-copy-field": [
        {"source": "schema_dateIssued_i", "dest": "date_year_agg_i"},
        {"source": "schema_datePublished_i", "dest": "date_year_agg_i"},
        {"source": "schema_dateCreated_i", "dest": "date_year_agg_i"}
      ]
    }'

    touch /var/solr/solr_schema_modified
    echo "\n Done: Solr schema updated!"
fi


# Return to the foreground process (writes to stdout)
fg %1
