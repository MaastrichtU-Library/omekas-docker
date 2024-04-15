#!/bin/bash

# Also allow connections outside of localhost (i.e. web browser on client machine / docker host)
# a\ appends after the matching line
sed -i "/hot: true/ a\      allowedHosts: ['all']," /usr/src/app/webpack.config.js

# Start the app
npm start
