## IIP Image Server instructions

The setup is as follows:
- Host machine: use `vips` to convert images to tiled tiff (pyramidical) and store them in the folder `./tiled-images/`
- IIPsrv docker container: has the `./iipsrv-images/` folder mounted as `/mnt/images/` and can serve the images over HTTP
- Omeka S docker container: contains viewers to display images coming from external (IIPsrv) IIIF information files (e.g. `/mnt/images/example_image.tif/info.json`)

## Before you start
Make sure that vips is installed on the host system
```
sudo apt-get install libvips-tools
```

Create an entry for in your `/etc/hosts` file so that the browser on your host machine knows where to access the IIP Image server.
```
127.0.0.1	localhost iipsrv.local
```

## Run instructions
1. **On the host machine:** convert the source image(s) to a format suited for IIPsrv
```
# Example
vips tiffsave /path/to/source/imagefile.tif ./tiled-images/outputfile.tif --tile --pyramid --compression deflate --tile-width 128 --tile-height 128
```

2. Make sure that the `iipsrv` Docker container is running.
3. Verify that the manifest and image is served correctly by testing the URLs below
```
http://iipsrv.local/fcgi-bin/iipsrv.fcgi?IIIF=/mnt/images/outputfile.tif/info.json

http://iipsrv.local/fcgi-bin/iipsrv.fcgi?IIIF=/mnt/images/outputfile.tif/full/400,400/0/default.jpg
```
4. Create a new item in Omeka S admin panel. At Media, choose for one or multiple **IIF image** media. Set the **IIIF image URL** for each of the media to their respective info.json URLS. Example `http://iipsrv.local/fcgi-bin/iipsrv.fcgi?IIIF=/mnt/images/outputfile.tif/info.json`

5. Save the item
6. Visit the item in the Omeka S frontend and see if the externally served images are displayed correctly in the viewer (UniversalViewer or Mirador)





## More documentation
- IIPsrv docker image: https://github.com/camicroscope/iipImage
- Conversion of images: https://iipimage.sourceforge.io/documentation/images
- Serving of images over IIIF: https://iipimage.sourceforge.io/documentation/iiif
