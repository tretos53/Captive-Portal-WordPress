#!/bin/bash

# dbsetup="create database wordpress_db;GRANT ALL PRIVILEGES ON wordpress_db.* TO wordpress_user@$localhost IDENTIFIED BY 'Pa66w0rd123';FLUSH PRIVILEGES;"
# mysql -e "$dbsetup"

curl -O /var/www/html https://wordpress.org/latest.tar.gz
