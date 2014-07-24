pul-store-deploy
----------------

Scripted vagrant deployment of Hydra or Blacklight

### USAGE  

PREREQUISITES: Vagrant >= 1.4.1 and Virtualbox >= 4.3.6 

 1. Copy this repo to your local box
 1. Change the directory
 1. Start Vagrant & go grab a coffee - Vagrant will download a Ubuntu 12.04 box file, start a VM, and run scripts to install dependencies
 1. Once setup is complete you can ssh into your new VM!  

```shell
git clone git@github.com:pulibrary/pul-store-deploy.git
cd pul-store-deploy
# The next step will take some time the first time it's run (15-45 minutes depending on network connections)
# Use BLACKLIGHT_ONLY=1 if you are installing blacklight, as opposed to Hydra.
# APP_NAME will be used in file system paths, so no characters that need escaping, please!
APP_NAME="my_app" BLACKLIGHT_ONLY=1  vagrant up 
# Now you've got a fully configured Centos system with Hydra dependencies - check things out
vagrant ssh
```  
