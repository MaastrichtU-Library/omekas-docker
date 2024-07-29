## External Image Server instructions

The setup is as follows:
- Host machine: use `vips` to convert images to tiled tiff (pyramidical) and store them in the folder `./tiled-images/`
- External Image Server (IIP, Cantaloupe, ...) Docker container: has the `./tiled-images/` folder volume binded into the container will can serve the images over HTTP
- Omeka S docker container: contains viewers to display images coming from externally served IIIF information files (e.g. `/mnt/images/example_image.tif/info.json`)

## Before you start
Make sure that vips is installed on the host system
```
sudo apt-get install libvips-tools
```

Create an entry for in your `/etc/hosts` file so that the browser on your host machine knows where to access the IIP Image server.
```
127.0.0.1	localhost iipsrv.local cantaloupe.local
```

## Run instructions
1. **On the host machine:** convert the source image(s) to a format suited for IIPsrv
```
# Example
vips tiffsave /path/to/source/imagefile.tif ./tiled-images/outputfile.tif --tile --pyramid --compression deflate --tile-width 128 --tile-height 128
```

2. Make sure that the external image server Docker container is running.
3. Verify that the manifest and image is served correctly by testing the URLs below
```
# For IIP:
http://iipsrv.local/fcgi-bin/iipsrv.fcgi?IIIF=/mnt/images/outputfile.tif/info.json
http://iipsrv.local/fcgi-bin/iipsrv.fcgi?IIIF=/mnt/images/outputfile.tif/full/256,/0/default.jpg

# For Cantaloupe
http://cantaloupe.local:8182/iiif/2/outputfile.tif/info.json
http://cantaloupe.local:8182/iiif/2/outputfile.tif/full/256,/0/default.jpg
```
4. Create a new item in Omeka S admin panel. At Media, choose for one or multiple **IIIF image** media. Set the **IIIF image URL** for each of the media to their respective info.json URLS. Examples:
```
# For IIP:
http://iipsrv.local/fcgi-bin/iipsrv.fcgi?IIIF=/mnt/images/outputfile.tif/info.json

# For Cantaloupe:
http://cantaloupe.local:8182/iiif/2/outputfile.tif/info.json
```

5. Save the item
6. Visit the item in the Omeka S frontend and see if the externally served images are displayed correctly in the viewer (UniversalViewer or Mirador)



## Admin interface

### IIP Image server
IIPsrv does not have a GUI admin interface.

### Cantaloupe
The Cantaloupe admin panel can be accessed at http://cantaloupe.local:8182/admin . Use the credentials that have been set in the docker-compose.yml environment variables.



## More documentation
**IIP Image server**
- Docker image being used: https://github.com/camicroscope/iipImage
- Conversion of images: https://iipimage.sourceforge.io/documentation/images
- Serving of images over IIIF: https://iipimage.sourceforge.io/documentation/iiif

**Cantaloupe**
- Docker image being used: https://github.com/UCLALibrary/docker-cantaloupe

