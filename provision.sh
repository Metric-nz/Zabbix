#!/usr/bin/env bash

sudo wget http://repo.zabbix.com/zabbix/2.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_2.4-1+trusty_all.deb
sudo dpkg -i zabbix-release_2.4-1+trusty_all.deb
apt-get update

sudo debconf-set-selections <<< 'mysql-server \
 mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server \
 mysql-server/root_password_again password root'

apt-get install -y zabbix-server-mysql zabbix-frontend-php
apt-get install -y mc

echo "Edit zabbix conf file in /etc/apache2/conf.d/zabbix to be"
echo "php_value max_execution_time 300"
echo "php_value memory_limit 128M"
echo "php_value post_max_size 16M"
echo "php_value upload_max_filesize 2M"
echo "php_value max_input_time 300"
echo "Uncomment and edit timezone"
echo "# php_value date.timezone Europe/Riga"
echo ""
echo "Then restart Apache"
echo "service apache2 restart"