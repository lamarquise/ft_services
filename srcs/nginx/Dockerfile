#NGINX
FROM basic_alpine_img

# was with openrc
RUN	apk add nginx openssl

# we need this 
RUN	mkdir -p /run/nginx
# i just like having all my stuff in the same place even if it's on different
# severs, it's just easier
RUN	mkdir -p /var/www/localhost
#this was for wordpress
#RUN mkdir var/www/localhost

RUN	mkdir /etc/nginx/ssl

# adding the ssl certificates
RUN	openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out \
	/etc/nginx/ssl/localhost.pem -keyout /etc/nginx/ssl/localhost.key \
	-subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=erlazo/CN=localhost"

# adding an html index cuz why not
RUN	echo "hello world!!" > /var/www/localhost/index.html

COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf

COPY ./srcs/start.sh .
RUN	chmod +x start.sh

#RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.og
# grabing the config file
# change this later
COPY	./srcs/nginx.config /etc/nginx/conf.d/default.conf
# temporarily using a simpler config file
#COPY nginx.config.tmp /etc/nginx/conf.d/default.conf

EXPOSE	80 443

# add telegraf start
#CMD	./start.sh
CMD	nginx -g 'daemon off;'


