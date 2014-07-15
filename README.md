hd_deploy
=========

HydraDAM scripted vagrant deployment (WIP)

### USAGE  

1. Vagrant Install  
    PREREQUISITES: Vagrant >= 1.4.1 and Virtualbox >= 4.3.6 
    1. Copy this repo to your local box
    1. Change the directory
    1. Start Vagrant & go grab a coffee - Vagrant will download a Centos6.5 box file, start a VM, and run scripts to install Hydra dependencies
    1. Once setup is complete you can ssh into your new VM!  

    ```shell
git clone git@github.com:mark-dce/hd_deploy.git
cd hd_deploy
# the next step will take some time the first time it's run (15-45 minutes depending on network connections)
vagrant up
# now you've got a fully configured Centos system with Hydra dependencies - check things out
vagrant ssh
    ```  

 2. Execute
    ```
    APP_NAME="my_app" BLACKLIGHT_ONLY=1 vagrant up
    ```
Use BLACKLIGHT_ONLY=1 if you are only installing Blacklight and not Hydra.