#!/usr/bin/env bash

sudo apt-get update

# add CRAN mirror
echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" | sudo tee -a /etc/apt/sources.list
gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E084DAB9
gpg -a --export E084DAB9 | sudo apt-key add -

# install R
sudo apt-get install r-base

# install RStudio
cd ~
sudo apt-get install gdebi-core

# Go get the latest from http://www.rstudio.com/products/rstudio/download-server/ if you don't like my hard-coding
wget http://download2.rstudio.org/rstudio-server-0.99.441-amd64.deb -O rstudio.deb
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
