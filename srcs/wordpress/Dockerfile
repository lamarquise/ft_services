#WORDPRESS
FROM basic_alpine_img

RUN apk add nginx openssl

RUN apk add php7 php7-fpm php7-mysqli php7-opcache php7-gd php7-zlib \
	php7-curl php7-mbstring php7-json php7-session

COPY ./srcs/ .

RUN	mkdir -p /run/nginx
RUN mkdir /etc/nginx/ssl
RUN	mv wp-nginx.config /etc/nginx/conf.d/default.conf

RUN	openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out \
	/etc/nginx/ssl/localhost.pem -keyout /etc/nginx/ssl/localhost.key \
	-subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=erlazo/CN=localhost"

COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf

RUN	mkdir -p /var/www/localhost/

RUN wget https://wordpress.org/latest.tar.gz \
	&& tar -xzf latest.tar.gz \
	&& mv wordpress /var/www/localhost/wordpress \
	&& mv ./wp-config.php /var/www/localhost/wordpress \
	&& rm -rf latest.tar.gz

EXPOSE 5050

RUN chmod +x start.sh
CMD ["/bin/sh", "start.sh"]

#CMD	php-fpm7 && screen -d -m telegraf && nginx -g 'daemon off;'
