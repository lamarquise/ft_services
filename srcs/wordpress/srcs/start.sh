#!/bin/sh

# Prevent php from clearing the environment
sed -i 's/;clear_env = no/clear_env = no/g' /etc/php7/php-fpm.d/www.conf

openrc
touch /run/openrc/softlevel

screen -d -m telegraf

php-fpm7
service nginx start

wp core install --allow-root --path=/var/www/localhost/wordpress/ --url=https://$NODE_IP:5050 --title='What is up my Dude!' --admin_user=$ADMIN_WP_USER --admin_password=$ADMIN_WP_PASS --admin_email=$ADMIN_WP_USER@me.com
wp plugin install log-emails disable-emails --activate --path=/var/www/localhost/wordpress/
wp user create --path=/var/www/localhost/wordpress/ $DB_USER $DB_USER@me.com --role=author --user_pass=$DB_PASSWORD
wp user create --path=/var/www/localhost/wordpress/ $DB_USER2 $DB_USER2@me.com --role=author --user_pass=$DB_USER2

tail -f /var/log/nginx/*.log