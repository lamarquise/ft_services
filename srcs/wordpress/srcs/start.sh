#!/bin/sh

# prolly won't use this file in the final version, but is useful for testing

apk add openrc
openrc
touch /run/openrc/softlevel

# necessary ? no not really at all, especially since it's in the wrong location
#touch /var/www/localhost/index.php

# temporary for testing phpmyadmin in this container
#echo "<?php phpinfo();" > info.php
#mv info.php /var/www/localhost/phpmyadmin/


# you can just do these in the shell once you start the container
php-fpm7
service nginx start

# works, would need to be a different path but it would work onlu im
# required to use Nginx so not a valid answer
#php -S 0.0.0.0:5050 -t /www/

# maybe we should manually config wordpress and manually add users here with wp commands
sh
