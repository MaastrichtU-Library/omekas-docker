## Using the Omeka S Command Line interface
The Omeka S CLI is developed by the Ghent Center for Digital Humanities [see GitHub](https://github.com/GhentCDH/Omeka-S-Cli/)
and allows you list, install/uninstall, enable/disable and upgrade Omeka S modules.

### Usage
1. Exec into the docker container
```bash
docker exec -it omekas bash
```

2. Run the CLI with the following example commands
```bash
omeka-s-cli list

omeka-s-cli disable BulkEdit

omeka-s-cli uninstall BulkEdit
```

### Full list of commands
```
module
    module:available    List available modules
    module:delete       Delete module
    module:disable      Disable module
    module:download     Download modules
    module:enable       Enable module
    module:install      Install module
    module:list         List downloaded modules
    module:status       Get module status
    module:uninstall    Uninstall module
    module:upgrade      Upgrade module
theme
    theme:available     List available themes
    theme:delete        Delete theme
    theme:download      Download theme
    theme:list          List downloaded themes
    theme:status        Get theme status
```


### Troubleshooting
The script tries to find the Omeka S base dir. If you get the following error:
```
Could not find a valid Omeka S context.
```
it could mean that you need to provide the base path. In those cases, try running the CLI with:
```bash
omeka-s-cli -b /var/www/html list
```