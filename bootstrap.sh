#!/bin/bash

# Install Apache and modules required to run Grav
apt-get update
apt-get install -y apache2
a2enmod rewrite

# Install PHP and modules required to run Grav
apt-get -y install php7.0 libapache2-mod-php7.0
systemctl restart apache2
apt-get -y install php7.0-mbstring
apt-get -y install php7.0-gd
apt-get -y install php7.0-curl
apt-get -y install php7.0-xml
apt-get -y install php7.0-zip
apt-get -y install php7.0-opcache php-apcu

# Link local grav files to VM apache
if ! [ -L /var/www/html ]; then
  rm -rf /var/www/html
  ln -fs /vagrant/grav /var/www/html
fi

# Install virtual host config
VHOST=$(cat <<EOF
<VirtualHost *:80>
  DocumentRoot /var/www/html

  <Directory /var/www/html>
    AllowOverride All
    Require all granted
  </Directory>

  ErrorLog /var/log/apache2/error.log
  CustomLog /var/log/apache2/access.log combined
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-available/000-default.conf

# Restart Apache one final time to pick up config changes
systemctl restart apache2