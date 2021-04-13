#NGINX
FROM basic_alpine_img

RUN	apk add --no-cache nginx openssl

RUN	mkdir -p /run/nginx
RUN	mkdir -p /var/www/localhost
RUN	mkdir /etc/nginx/ssl

RUN	openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out \
	/etc/nginx/ssl/localhost.pem -keyout /etc/nginx/ssl/localhost.key \
	-subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=erlazo/CN=localhost"

RUN	echo "hello world!!" > /var/www/localhost/index.html

COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf

COPY ./srcs/nginx.config /etc/nginx/conf.d/default.conf

EXPOSE	80 443

	# i think this is the right one...
CMD	screen -d -m telegraf && nginx -g 'daemon off;'
#CMD ["nginx", "-g", "daemon off;"]
#CMD sh

