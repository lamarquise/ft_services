FROM basic_alpine_img

# keeping it simple for now...

# would be a really good idea to put a bunch of things like users and passwords as 
# ENV vars right here... easy to change...


# mariadb-client for the cli tools
# possibly want mariadb-common (it's character set files...)
RUN	apk add --no-cache mariadb mariadb-client

# i hope this is temporary
RUN	apk add --no-cache openrc
RUN openrc && touch /run/openrc/softlevel && mkdir -p /run/mysqld

RUN	/etc/init.d/mariadb setup
	# this file is super necessary and i have no idea what it really does
	# it's like some sort of config file for Mysql i guess
COPY ./srcs/my.cnf /etc/mysql/my.cnf
RUN	chmod 0444 /etc/my.cnf


	#might have to run this once the container is actually up and running...
#RUN service mariadb restart
#RUN mysql -u root -e "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;" 
#	&& mysql -u root -e "CREATE USER wp_user@localhost IDENTIFIED BY 'password';" \
#	&& mysql -u root -e "GRANT ALL ON wordpress.* TO 'wp_user'@'localhost' IDENTIFIED BY 'password';" \
#	&& mysql -u root -e "FLUSH PRIVILEGES;"

COPY ./srcs/start.sh .
RUN chmod +x start.sh
# might want to add some Volumes...

EXPOSE 3306

CMD ./start.sh
