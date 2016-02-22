#!/usr/bin/env bash

sudo apt-get update

# add CRAN mirror
echo "deb http://cran.r-project.org/bin/linux/ubuntu trusty/" | sudo tee -a /etc/apt/sources.list
gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E084DAB9
gpg -a --export E084DAB9 | sudo apt-key add -

# set up swap
sudo dd if=/dev/zero of=/swapfile bs=256M count=20
sudo chmod 600 /swapfile
ls -lh /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# stuff
sudo apt-get install libcurl4-openssl-dev -y
sudo apt-get install libxml2-dev -y

# install R
sudo apt-get install r-base -y

# install RStudio
cd ~
sudo apt-get install gdebi-core -y

# get latest rstudio version and install
VER=$(wget --no-check-certificate -qO- https://s3.amazonaws.com/rstudio-server/current.ver)
sudo wget -q http://download2.rstudio.org/rstudio-server-${VER}-amd64.deb
sudo dpkg -i rstudio-server-${VER}-amd64.deb
rm rstudio-server-*-amd64.deb

#wget http://download2.rstudio.org/rstudio-server-0.99.441-amd64.deb -O rstudio.deb
#sudo gdebi --non-interactive rstudio.deb
#rm rstudio.deb

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
sudo -u rstudiouser rm ./-
sudo -u rstudiouser wget -O ./dropbox.py "http://www.dropbox.com/download?dl=packages/dropbox.py"
sudo -u rstudiouser chmod 755 ./dropbox.py

# get your AWS instance public hostname
pubdns=$(curl http://canhazip.com)

echo "######################################################"
echo ""
echo "To link with our dropbox change to rstudiouser and run:"
echo "~/.dropbox-dist/dropboxd"
echo ""
echo "Your RStudio Server login is accessible from:"
echo "http://$pubdns:8787"
echo ""
echo "######################################################"
