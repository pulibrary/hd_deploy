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
1. Pre-configured Centos system  
    PREREQUISITES: Centos minimal install + misc stuff (to be identified later)
    1. Clone this repo to the system
    1. Change the directory
    1. Run the install scripts as root
    1. Once bootstrap is complete, you have a working set of Hydra dependencies installed  

    ```shell
git clone git@github.com:mark-dce/hd_deploy.git
cd hd_deploy
su root -c 'bash /vagrant/bootstrap.sh'  # sudo may not work due to secure_path issues
    ```

### NOTES  
The scripts have been specifically tested for use against Centos systems built using https://github.com/mark-dce/vagrant-centos.  YMMV using other Centos installs.  Future work is planned to address Ubuntu installs.
