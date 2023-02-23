# Configuration module CleanUrl
Due to a peculiar (buggy?) behavior of the CleanUrl module, there are some additional configurations required after the Omeka S container
has booted for the first time, i.e. first boot after (re)creation of the data volume.
These steps are hard to automate, therefore a brief summary of the manual steps to take.

1. Go to the Omeka S admin panel
1. Click on Modules
1. Find the CleanUrl module and click on `Configure`
1. Press `Submit` without changing anything (keep the preloaded values). 
    - This will create the `/var/www/html/config/cleanurl.config.php` file on disk.
    - It will also create the routes for the site(s), so that CleanUrl is able to serve the site's content at http://omeka.local/s/default instead of an HTTP 500 error.
1. Go back to the Omeka S admin panel
1. Click on Settings
1. Set a default site. Here: the site with name "default site" 
1. Click `Save`
1. Click on Modules
1. Find the CleanUrl module and click on `Configure`
1. **Check** the box for 'Skip "s/site-slug/" for default site'
1. Click `Submit`
1. Find the CleanUrl module and click on `Configure`
1. **Uncheck** the box for 'Skip "s/site-slug/" for default site'
1. Click `Submit`
1. Click on Settings
1. **Unset** the default site. (Press the X at the right side of the dropdown)
1. Click `Save`

Congratulations, by executing these manual steps enabled the CleanUrl module to put all item hyperlinks in ARK format (e.g. http://omeka.local/s/default/ark:/99999/a1apZs2) instead of item format (e.g. http://omeka.local/s/default/item/1)

