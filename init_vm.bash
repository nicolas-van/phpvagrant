#!/bin/bash

apt-get update

# some default configuration to prevent mysql to ask for it
echo "mysql-server-5.5 mysql-server/root_password password root" | debconf-set-selections
echo "mysql-server-5.5 mysql-server/root_password_again password root" | debconf-set-selections

apt-get install -y build-essential apache2 php5-gd php5-sqlite php5 php5-cli php5-mysql mysql-server php-db php-pear

pecl install uploadprogress
echo "extension=uploadprogress.so" > /etc/php5/apache2/conf.d/uploadprogress.ini
cp /vagrant/000-default.conf /etc/apache2/sites-available/000-default.conf
chown root:root /etc/apache2/sites-available/000-default.conf
cp /vagrant/apache2.conf /etc/apache2/apache2.conf
chown root:root /etc/apache2/apache2.conf
a2enmod rewrite

# some default database for mysql
mysql -uroot -proot -e "create database if not exists defaultdb"

service apache2 restart