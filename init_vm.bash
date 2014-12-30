#!/bin/bash

apt-get update

# some default configuration to prevent mysql to ask for it
echo "mysql-server-5.5 mysql-server/root_password password root" | debconf-set-selections
echo "mysql-server-5.5 mysql-server/root_password_again password root" | debconf-set-selections

apt-get install -y build-essential apache2 php5-gd php5-sqlite php5 php5-cli php5-mysql mysql-server php-db php-pear

pecl install uploadprogress
echo "extension=uploadprogress.so" > /etc/php5/apache2/conf.d/uploadprogress.ini
sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/sites-available/default
a2enmod rewrite

rm -rf /var/www
ln -fs /vagrant/www /var/www

# some default database for mysql
mysql -uroot -proot -e "create database if not exists defaultdb"

service apache2 restart