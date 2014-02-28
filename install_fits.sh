mkdir -p /opt/install && cd /opt/install
wget http://fits.googlecode.com/files/fits-0.6.2.zip
unzip fits-0.6.2.zip  
sudo chmod +x fits-0.6.2/fits.sh  
sudo cp -r fits-0.6.2/* /usr/local/bin/
sudo ln -s /usr/local/bin/fits.sh /usr/local/bin/fits

