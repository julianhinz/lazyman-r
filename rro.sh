#!/usr/bin/env bash

### Install Revolution R Open #####
sudo apt-get update
sudo apt-get install gcc gfortran g++ -y

cd ~
mkdir R
cd R
sudo wget http://mran.revolutionanalytics.com/install/RRO-8.0.3-Ubuntu-14.04.x86_64.tar.gz -O rro.tar.gz
sudo tar -xzf rro.tar.gz
cd RRO-8.0.3
sudo ./install.sh

# add CRAN mirror
echo "deb http://cran.revolutionanalytics.com/bin/linux/ubuntu trusty/" | sudo tee -a /etc/apt/sources.list
gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E084DAB9
gpg -a --export E084DAB9 | sudo apt-key add -

# install MKL
cd ~
mkdir RevoMath
cd RevoMath
sudo wget http://mran.revolutionanalytics.com/install/RevoMath-8.0.3.tar.gz -O revomath.tar.gz
sudo tar -xzf revomath.tar.gz
cd RevoMath
sudo ./RevoMath.sh

# install RStudio
cd ~
sudo apt-get install gdebi libapparmor1 -y

# Go get the latest from http://www.rstudio.com/products/rstudio/download-server/ if you don't like my hard-coding
wget http://download2.rstudio.org/rstudio-server-0.98.1103-amd64.deb -O rstudio.deb
sudo gdebi --non-interactive rstudio.deb

echo "######################################################"
echo ""
echo "Creating user for RStudio"
echo "Choose your password for rstudiouser"
echo ""
echo "######################################################"

sudo adduser rstudiouser

# install dropbox for rstudio
cd /home/rstudiouser
sudo wget -O ./- "https://www.dropbox.com/download?plat=lnx.x86_64"
sudo -u rstudiouser tar xzf ./-
sudo -u rstudiouser wget -O ./dropbox.py "http://www.dropbox.com/download?dl=packages/dropbox.py"
sudo -u rstudiouser chmod 755 ./dropbox.py

# get your AWS instance public hostname
pubdns=$(curl -s http://169.254.169.254/latest/meta-data/public-hostname)

echo "######################################################"
echo ""
echo "To link with our dropbox run:"
echo "~/.dropbox-dist/dropboxd"
echo ""
echo "Your RStudio Server login is accessible from:"
echo "http://$pubdns:8787"
echo ""
echo "This URL based on your Public DNS name and can change if you shutdown and bootup again"
echo ""
echo "Loging in with rstudiouser and the password you just created"
echo ""
echo "######################################################"