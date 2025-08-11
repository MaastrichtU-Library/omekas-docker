# Load Sample Data
This script loads sample data after the installation of Omeka S.
It creates new items, metadata, and media files in the Omeka S installation.

It uses [this fork](https://github.com/mcoonen/omeka_s_tools) of the original Omeka S API client developed by Tim Sherratt.

>NOTE: this readme file is written for the Ubuntu operating system, but the script should work on any operating system with Python 3.12 or higher installed.

# Preparation
1. Install Python 3.12 or higher.
```bash
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get update
sudo apt-get install python3.12 python3.12-venv python3.12-dev
```

2. Create Python virtual environment
```bash
cd /path/to/omekas-docker/scripts/load_sample_data
python3.12 -m venv .venv
```

3. Install required packages into virtual environment
```bash
source .venv/bin/activate
pip install -r requirements.txt
```

# Usage
1. Activate the virtual environment:
```bash
cd /path/to/omekas-docker/scripts/load_sample_data
source .venv/bin/activate
```

2. Run the script
```bash
python main.py
```
This creates 2 sample items in your Omeka S instance.

# Frequently Asked Questions

## How to add more sample data?
Place your own JSON files with metadata and the media files to be uploaded in the `scripts/load_sample_data/data` directory.
Base these JSON files on the existing sample files in the `data` directory.

On the next run, the script will automatically pick up these JSON-metadata and media files and upload them to Omeka S.

## How about the API key?
This script uses the default API key that is loaded by the database import at a `docker compose up` command.
If you're using a different database, you can change the API key with the following steps:
1. Log in to your Omeka S instance as an administrator.
2. Open the "Admin - Users" page.
3. Click on your user account.
4. Click on the "API Keys" tab.
5. Enter a key label, e.g. "admin-key".
6. Click on the "Save" button.
7. Open the `scripts/load_sample_data/config.py` file and copy paste the values that are displayed:
```
OMEKA_API_KEY_ID = "value of key_identity"
OMEKA_API_KEY = "value of key_credential" 
```