#!/bin/bash

apt-get update

# some default configuration to prevent mysql to ask for it
echo "mysql-server-5.5 mysql-server/root_password password root" | debconf-set-selections
echo "mysql-server-5.5 mysql-server/root_password_again password root" | debconf-set-selections

apt-get install -y apache2 php5-gd php5-sqlite php5 php5-cli php5-mysql mysql-server php-db php-pear

rm -rf /var/www
ln -fs /vagrant/www /var/www

# some default database for mysql
mysql -uroot -proot -e "create database if not exists defaultdb"

service apache2 restart