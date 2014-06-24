mkdir -p /opt/install && cd /opt/install
wget http://projects.iq.harvard.edu/files/fits/files/fits-0.8.0.zip
unzip fits-0.8.0.zip  
sudo chmod a+x fits-0.8.0/fits.sh  
sudo cp -r fits-0.8.0/* /usr/local/bin/
sudo ln -s /usr/local/bin/fits.sh /usr/local/bin/fits

