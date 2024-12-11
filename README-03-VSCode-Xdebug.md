# Remote debugging using Visual Studio Code and Xdebug

# Enable Xdebug traffic to Docker host machine

This is automatically handled by the `/etc/hosts` entry that is being created by the `omeka-s/docker-entrypoint.sh`
file. Example:

```
echo "$(ip route|awk '/default/ { print $3 }') dockerhost.local" >> /etc/hosts
```

# Setup Xdebug server-side

This is all automatically handled by the code in `omeka-s/Dockerfile` and results in the following outcome:

- Xdebug extension for PHP installed. Note: to reproduce this in a **non-Dockerized** environment, you could use
  `sudo apt-get install php8.2-xdebug`
- Xdebug configured for remote debugging. Please note that some settings have been renamed since Xdebug version 3. The
  settings below are the ones for Xdebug 3. Contents of the config file
  `/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini`:

```
zend_extension=xdebug.so
xdebug.mode=debug
xdebug.start_with_request = yes
xdebug.client_host = dockerhost.local
xdebug.log = /tmp/xdebug.log
```

# Configure Visual Studio Code for remote debugging (client-side)

The instructions below are written for a specific module development use case where the module's the source code has
been volume-binded from a folder on host (`./externals/Omeka-S-module-Ark`) to the docker container 
(`/var/www/html/modules/Ark`). Remote debugging also works in other use cases, although you might need to setup some
things differently.

_The instructions are loosely based on the instructions in this [blog post by Jack Miras](https://dev.to/jackmiras/xdebug-in-vscode-with-docker-379l)_

1. Git-clone the module's source code to your host file system. Here: `./externals/Omeka-S-module-Ark`
2. Open Visual Studio Code
3. Open the directory with the module's source code. Here: `./externals/Omeka-S-module-Ark`. 
4. Install the [PHP Debug extension](https://marketplace.visualstudio.com/items?itemName=xdebug.php-debug) in Visual Studio Code.
5. Generate the `.vscode/launch.json` by clicking on `Run and Debug > Create a launch.json file > PHP`
6. Open the `.vscode/launch.json` and replace the `configurations` section with the contents below:

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Listen for XDebug",
            "type": "php",
            "request": "launch",
            "port": 9003,
            "pathMappings": {
                "/var/www/html/modules/Ark": "${workspaceFolder}/externals/Omeka-S-module-Ark"
            }
        }
    ]
}
```

## Verify that Docker-to-host Xdebug connectivity works

1. Open VS Code and click on `Start Debugging` to start listening on port 9003 for incoming debug connections.
2. Exec into the Docker container

```
docker exec -it omekas bash
```

3. Install telnet

```
apt-get update && apt-get install telnet -y
```

4. Use telnet to verify connectivity

```
telnet dockerhost.local 9003
```

## Install Xdebug plugin in browser

Install the `Xdebug helper` extension.

- for Firefox: https://addons.mozilla.org/nl/firefox/addon/xdebug-helper-for-firefox/
- for Chrome: https://chrome.google.com/webstore/detail/xdebug-helper/eadndfjplgieldjbigjakmdgkmoaaaoc

## Start debugging

1. Open your browser
1. Go to http://omeka.local
1. Activate the Xdebug plugin
1. Set a breakpoint in the code using VS Code
1. Use the browser to go to the page where the breakpoint is set
1. VS Code should automatically take over the active screen and let you enter the debugger.

