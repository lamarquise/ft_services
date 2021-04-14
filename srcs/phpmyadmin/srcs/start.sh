#!/bin/sh

sed -i 's/;clear_env = no/clear_env = no/g' /etc/php7/php-fpm.d/www.conf

screen -d -m telegraf

php-fpm7

nginx -g "daemon off;"