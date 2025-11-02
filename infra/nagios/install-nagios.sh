#!/bin/bash

# Update package lists
sudo apt-get update

# Install required packages
sudo apt-get install -y apache2 php libapache2-mod-php php-gd unzip wget build-essential openssl libssl-dev apache2-utils

# Create Nagios user and group
sudo useradd nagios
sudo usermod -a -G nagios www-data

# Download and install Nagios Core
cd /tmp
wget https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.4.6.tar.gz
tar xzf nagios-4.4.6.tar.gz
cd nagioscore-nagios-4.4.6
sudo ./configure --with-httpd-conf=/etc/apache2/sites-enabled
sudo make all
sudo make install
sudo make install-daemoninit
sudo make install-commandmode
sudo make install-config
sudo make install-webconf

# Download and install Nagios Plugins
cd /tmp
wget https://github.com/nagios-plugins/nagios-plugins/releases/download/release-2.3.3/nagios-plugins-2.3.3.tar.gz
tar xzf nagios-plugins-2.3.3.tar.gz
cd nagios-plugins-2.3.3
sudo ./tools/setup
sudo ./configure
sudo make
sudo make install

# Configure Apache
sudo a2enmod rewrite
sudo a2enmod cgi

# Create nagiosadmin user
sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin

# Start services
sudo systemctl restart apache2
sudo systemctl start nagios
sudo systemctl enable nagios

echo "Nagios installation completed. Access the web interface at http://your-ip/nagios"
