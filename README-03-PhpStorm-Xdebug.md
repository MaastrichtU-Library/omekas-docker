# Remote debugging using PhpStorm and Xdebug

# Enable Xdebug traffic to Docker host machine
This is automatically handled by the `/etc/hosts` entry that is being created by the `omeka-s/docker-entrypoint.sh` file. Example:
```
echo "$(ip route|awk '/default/ { print $3 }') dockerhost.local" >> /etc/hosts
```

# Setup Xdebug server-side
This is all automatically handled by the code in `omeka-s/Dockerfile` and results in the following outcome:
- Xdebug extension for PHP installed. Note: to reproduce this in a **non-Dockerized** environment, you could use `sudo apt-get install php8.2-xdebug`
- Xdebug configured for remote debugging. Please note that some settings have been renamed since Xdebug version 3. The settings below are the ones for Xdebug 3. Contents of the config file `/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini`:
```
zend_extension=xdebug.so
xdebug.mode=debug
xdebug.start_with_request = yes
xdebug.client_host = dockerhost.local
xdebug.log = /tmp/xdebug.log
```

# Configure PhpStorm for remote debugging (client-side)
The instructions below are written for a specific module development use case where the module's the source code has been volume-binded from a folder on host (`./externals/Omeka-S-module-Ark`) to the docker container (`/var/www/html/modules/Ark`). Remote debugging also works in other use cases, although you might need to setup some things differently.

1. Git-clone the module's source code to your host file system. Here: `./externals/Omeka-S-module-Ark`
1. Open PhpStorm
1. Open the directory with the module's source code. Here: `./externals/Omeka-S-module-Ark`. **Do not!** create a 'New project from Existing Files...`
1. Open Settings (Ctrl + Alt + S)
1. Click on **PHP** in the menu
1. Choose a CLI interpreter. 
    1. Click the `...` button
    1. Click `+` and choose **From Docker, Vagrant, ... (etc)**
    1. Select the **Docker** radio button
    1. Choose server (usually the default 'Docker' socket) 
    1. Choose image name: 'omekas-docker-omekas:latest'
    1. Choose PHP interpreter path: 'php'
    1. The CLI interpreter is now added. It should detect and display the PHP (here: 8.2.11) and Xdebug (here: 3.3.1) versions.
    1. Click **OK** to save and exit this screen.
1. Click on the **Open folder** icon next to **Docker container:**
1. Edit the volume binding using the pencil icon. 
    1. Host path: (keep the default)
    1. Container path: /var/www/html/modules/Ark
    1. Click **OK** to save and exit this screen.
1. Confirm that the value at **Path mappings** is now correct. This has been set by the previous step.
1. Expand the **PHP** menu option
1. Click on **PHP -> Debug**
    1. Usually, the default settings are sufficient. If not, then one can change it here.
    1. Click **OK** to save.
1. Click on **PHP -> Server** to set the location of the web server
    1. Click `+` to create a new server configuration and enter the values
    1. Name: Omeka S Docker (or something else, does not really matter)
    1. Host: omeka.local
    1. Port: 80
    1. Debugger: Xdebug
    1. Check the box for 'Use path mappings... (etc)'
    1. At the first "subfolder" of "Project files" -> Absolute path on the server: /var/www/html/modules/Ark
1. Expand the **Build, Execution, Deployment** menu option and click on **Deployment**
    1. Confirm that these settings are correct:
    1. Type: Local or mounted older
    1. Folder: (path/to/...)/externals/Omeka-S-module-Ark
    1. Web server URL: http://omeka.local
1. Click **OK** to close Settings
1. Create a debug configuration
    1. Click the Run dropdown and choose **Edit configurations**
    1. Click `+` and choose **PHP remote debug**
    1. give it a name and keep all default settings
    1. Click **OK** to save and exit these settings.
1. Press the debug icon or the phone icon to start listening for incoming Xdebug connections.


## Verify that Docker-to-host Xdebug connectivity works
1. Open PhpStorm and start listening for incoming debug connections.
1. Exec into the Docker container
```
docker exec -it omekas bash
```
1. Install telnet
```
apt-get update && apt-get install telnet -y
```
1. Use telnet to verify connectivity
```
telnet host.docker.internal 9003
```

## Install Xdebug plugin in browser
Install the `Xdebug helper` extension.
- for Firefox: https://addons.mozilla.org/nl/firefox/addon/xdebug-helper-for-firefox/
- for Chrome: https://chrome.google.com/webstore/detail/xdebug-helper/eadndfjplgieldjbigjakmdgkmoaaaoc


## Start debugging
1. Open your browser
1. Go to http://omeka.local
1. Activate the Xdebug plugin
1. Set a breakpoint in the code using PhpStorm
1. Use the browser to go to the page where the breakpoint is set
1. Switch from browser to PhpStorm. Press F9 to resume the program (actually this jumps to the first breakpoint). Then press F8 to step through the debugger.

