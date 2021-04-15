#!/bin/sh
#MYSQL

openrc &> /dev/null
touch /run/openrc/softlevel
/etc/init.d/mariadb setup &> /dev/null
sed -i 's/skip-networking/# skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf

# hassan's thing
#/usr/bin/mysql_install_db --user=root --datadir="/var/lib/mysql"
#/usr/bin/mysqld_safe --datadir="/var/lib/mysql" --no-watch

service mariadb restart

until echo "show databases;" | mysql -u root -p'password'
do
	clear
	echo "mysql is not up"
done


mysql -u root -e "FLUSH PRIVILEGES;"
# create the root user who has access to pma
mysql -u root -e "CREATE USER 'root'@'%' IDENTIFIED BY 'password';"
mysql -u root -e "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY 'password';"
mysql -u root -e "FLUSH PRIVILEGES;"
mysql -u root -e "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
# ok so definitly not @localhost rather @% meaning anything
mysql -u root -e "CREATE USER 'wp_user'@'%' IDENTIFIED BY 'password';"
mysql -u root -e "GRANT ALL ON wordpress.* TO 'wp_user'@'%' IDENTIFIED BY 'password';"
mysql -u root -e "FLUSH PRIVILEGES;"


# Creating wordpress database, 
#mysql --user=root << EOF
#  FLUSH PRIVILEGES;
#  CREATE USER 'root'@'%' IDENTIFIED BY 'password';
#  GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY 'password';
#  FLUSH PRIVILEGES;
##  CREATE DATABASE wordpress;
#  CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
#  DROP DATABASE test;
#  CREATE USER 'wp_user'@'%' IDENTIFIED BY 'password';
#  GRANT ALL ON wordpress.* TO 'wp_user'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;
#  FLUSH PRIVILEGES;
#EOF


# Import wordpress database
	# Ask Celia how to do this!!!
	# i think this thing is where the exter WP #users come in!
	# prolly don't need the my.cnf file is this
	# works!
#mysql --user=root wordpress < wp-db.sql

# instead of that, we do the thing HASSAN did... NOT HERE IN WP start.sh


printf "Database started !\n"

#screen -d -m telegraf

tail -F /dev/null
#sh
