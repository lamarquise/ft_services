#!/bin/sh

# yea i have no idea what goes in here yet...

	# yea we can test this later
#mysql_install_db --defaults-file=/etc/mysql/my.cnf --user=root --datadir=/var/lib/mysql

service mariadb restart
# create the root user who has access to pma
mysql -u root -e "CREATE USER 'root'@'%' IDENTIFIED BY 'password';"
mysql -u root -e "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY 'password';"

mysql -u root -e "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
# ok so definitly not @localhost rather @% meaning anything
mysql -u root -e "CREATE USER 'wp_user'@'%' IDENTIFIED BY 'password';"
mysql -u root -e "GRANT ALL ON wordpress.* TO 'wp_user'@'%' IDENTIFIED BY 'password';"
mysql -u root -e "FLUSH PRIVILEGES;"

screen -d -m telegraf && /usr/bin/mysqld --defaults-file=/etc/mysql/my.cnf --user=root --console

#sh
