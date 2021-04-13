#!/bin/sh
#MYSQL

#openrc &> /dev/null
#touch /run/openrc/softlevel

#/etc/init.d/mariadb setup &> /dev/null
#sed -i 's/skip-networking/# skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf

service mariadb restart
# create the root user who has access to pma
mysql -u root -e "CREATE USER 'root'@'%' IDENTIFIED BY 'password';"
mysql -u root -e "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY 'password';"
mysql -u root -e "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
# ok so definitly not @localhost rather @% meaning anything
mysql -u root -e "CREATE USER 'wp_user'@'%' IDENTIFIED BY 'password';"
mysql -u root -e "GRANT ALL ON wordpress.* TO 'wp_user'@'%' IDENTIFIED BY 'password';"

mysql -u root -e "FLUSH PRIVILEGES;"

#mysql -u root -e "DROP DATABASE test;"
#mysql -u root -e "CREATE USER 'wp_user2'@'%' IDENTIFIED BY 'password';"
#mysql -u root -e "GRANT ALL ON wordpress.* TO 'wp_user2'@'%' IDENTIFIED BY 'password';"

# Import wordpress database
#mysql --user=root wordpress < wp-db.sql

printf "Database started !\n"

screen -d -m telegraf

#tail -F /dev/null
sh