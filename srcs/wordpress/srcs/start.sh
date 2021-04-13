#!/bin/sh

# Prevent php from clearing the environment
sed -i 's/;clear_env = no/clear_env = no/g' /etc/php7/php-fpm.d/www.conf

#apk add openrc
#openrc
#touch /run/openrc/softlevel


# you can just do these in the shell once you start the container
php-fpm7
#service nginx start
nginx -g "daemon off;"

