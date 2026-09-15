## Using the Omeka S Command Line interface
The Omeka S CLI is developed by the Ghent Center for Digital Humanities [see GitHub](https://github.com/GhentCDH/Omeka-S-Cli/)
and allows you to list, install/uninstall, enable/disable and upgrade Omeka S modules, resource templates, themes and vocabularies.

### Usage
1. Exec into the docker container
```bash
docker exec -it omekas bash
```

2. Run the CLI with the following example commands
```bash
omeka-s-cli module:list

omeka-s-cli module:disable BulkEdit

omeka-s-cli module:uninstall BulkEdit
```

### Full list of commands
The latest list of commands can be found in the CLI's [readme on GitHub](https://github.com/GhentCDH/Omeka-S-Cli/blob/main/README.md)
or by calling the help via:
```bash
omeka-s-cli -h
```


### Troubleshooting
The script tries to find the Omeka S base dir. If you get the following error:
```
Could not find a valid Omeka S context.
```
it could mean that you need to switch to the correct working directory, or provide the base path. Example:
```bash
# By switching directory
cd /var/www/html
omeka-s-cli module:list

# Or using the base path
omeka-s-cli module:list --base-path /var/www/html
```

### Export and import of Omeka S settings across instances
Version 0.16.0 of the Omeka S CLI added the ability to export and import settings across instances. This is useful for migrating settings from one instance to another (e.g. from TEST/ACCEPT to DEV), or for backing up your configuration.

The commands below demonstrate the gist of it
```bash
# Export settings from the server instance to files
omeka-s-cli config:export ./config

# Tar the exported config files for transfer to another instance
tar -czvf omeka-config.tar.gz ./config

# Transfer the tar file to the other instance (e.g. via scp)
scp omeka-config.tar.gz user@other-instance:/path/to/destination/

# On the other instance, extract the tar file
tar -xzvf omeka-config.tar.gz

# Import the settings into the other instance.
# First do a dry-run
omeka-s-cli config:import ./config --dry-run

# If the dry-run looks good, run the import for real
omeka-s-cli config:import ./config
```

Check the outcome in your Omeka S admin interface. You should see the settings applied from the other instance.

Read more in the [Omeka S CLI 0.16.0 release notes](https://github.com/GhentCDH/Omeka-S-Cli/releases/tag/v0.16.0)