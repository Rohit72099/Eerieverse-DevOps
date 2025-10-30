#!/bin/bash
sudo yum install httpd php gcc glibc glibc-common gd gd-devel make net-snmp openssl-devel unzip -y
sudo useradd nagios
sudo passwd nagios
sudo usermod -aG apache nagios
echo "Nagios installed. Configure eerieverse.cfg next."
