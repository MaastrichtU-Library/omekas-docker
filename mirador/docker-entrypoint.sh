#!/bin/bash

# Also allow connections outside of localhost (i.e. web browser on client machine / docker host)
# a\ appends after the matching line
sed -i "/server:[[:space:]]*{/a\    allowedHosts: ['viewer.local'],"  /usr/src/app/vite.config.js

# Start the app
npx vite --host 0.0.0.0