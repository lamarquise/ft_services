#PHPMYADMIN
FROM basic_alpine_img

RUN	apk add --no-cache nginx openssl

RUN	apk add --no-cache php7 php7-fpm php7-mysqli php7-opcache php7-gd php7-zlib \
	php7-curl php7-mbstring php7-json php7-session

COPY ./srcs .

RUN	mkdir -p /run/nginx
RUN	mkdir /etc/nginx/ssl
RUN	mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.OG
RUN	mv php-nginx.config /etc/nginx/conf.d/default.conf

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out \
	/etc/nginx/ssl/localhost.pem -keyout /etc/nginx/ssl/localhost.key \
	-subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=erlazo/CN=localhost"

COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf

RUN	mkdir -p /var/www/localhost

RUN	wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-english.tar.gz \
	&& tar -xzf phpMyAdmin-5.0.2-english.tar.gz \
	&& mv phpMyAdmin-5.0.2-english /var/www/localhost/phpmyadmin \
	&& mv ./config.inc.php var/www/localhost/phpmyadmin \
	&& rm -rf phpMyAdmin-5.0.2-english.tar.gz

EXPOSE 5000

RUN	echo "<?php phpinfo();" > info.php && mv info.php /var/www/localhost/phpmyadmin/

RUN	chmod +x start.sh

CMD	["sh", "start.sh"]