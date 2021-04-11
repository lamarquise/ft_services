#WORDPRESS
FROM basic_alpine_img

# All the Nginx stuff

RUN apk add nginx openssl
# i don't want openrc ideally

# do i really need all of these or do i only need some?
# yes, i tested it...
RUN apk add php7 php7-fpm php7-mysqli php7-opcache php7-gd php7-zlib \
	php7-curl php7-mbstring php7-json php7-session

#yea so turns out we need all of it anyway...
COPY ./srcs/ .

RUN	mkdir -p /run/nginx
RUN mkdir /etc/nginx/ssl
RUN	mv wp-nginx.config /etc/nginx/conf.d/default.conf

RUN	openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out \
	/etc/nginx/ssl/localhost.pem -keyout /etc/nginx/ssl/localhost.key \
	-subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=erlazo/CN=localhost"

# Now for Wordpress

RUN	mkdir -p /var/www/localhost/

RUN wget https://wordpress.org/latest.tar.gz \
	&& tar -xzf latest.tar.gz \
	&& mv wordpress /var/www/localhost/wordpress \
	&& mv ./wp-config.php /var/www/localhost/wordpress \
	&& rm -rf latest.tar.gz

# temporary to test if phpmyadmin works if i put it in this container
#RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-english.tar.gz \
#	&& tar -xzf phpMyAdmin-5.0.2-english.tar.gz \
#	&& mv phpMyAdmin-5.0.2-english /var/www/localhost/phpmyadmin \
#	&& mv ./config.inc.php var/www/localhost/phpmyadmin \
#	&& rm -rf phpMyAdmin-5.0.2-english.tar.gz

#RUN chmod +x /var/www/localhost/phpmyadmin/config.inc.php

EXPOSE 5050 5000

# mysql should already have been started

#only need this if want access to shell
#RUN chmod +x start.sh
# This is the one you would use for testing if you want to get into the shell
#CMD ["/bin/sh", "start.sh"]

CMD php-fpm7 && nginx -g 'daemon off;'
