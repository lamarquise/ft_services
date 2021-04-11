#!/bin/sh

# no idea what to put in here, it's mainly a placeholder script to get me
# access to the shell for testing

apk add openrc
openrc
touch /run/openrc/softlevel

echo "<?php phpinfo();" > info.php
mv info.php /var/www/localhost/phpmyadmin/

php-fpm7

service nginx start

# does phpmyadmin need to be started?

# does it need a DB or User or credentials in mysql ?



sh
