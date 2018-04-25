#!/bin/bash

apt-get update
apt-get install -y apache2
a2enmod rewrite
apt-get -y install php7.0 libapache2-mod-php7.0
systemctl restart apache2
apt-get -y install php7.0-mbstring
apt-get -y install php7.0-gd
apt-get -y install php7.0-curl
apt-get -y install php7.0-xml
apt-get -y install php7.0-zip
apt-get -y install php7.0-opcache php-apcu
systemctl restart apache2
if ! [ -L /var/www/html ]; then
  rm -rf /var/www/html
  ln -fs /vagrant/grav /var/www/html
fi
