#MYSQL
FROM basic_alpine_img

RUN	apk add --no-cache mariadb mariadb-client openrc

# i hope this is temporary
RUN openrc && touch /run/openrc/softlevel && mkdir -p /run/mysqld

RUN	/etc/init.d/mariadb setup

COPY ./srcs/my.cnf /etc/mysql/my.cnf
RUN	chmod 0444 /etc/my.cnf

	#new
#COPY ./srcs/wp-db.sql wp-db.sql

COPY ./srcs/livenessprobe.sh livenessprobe.sh
COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf

COPY ./srcs/start.sh .
RUN chmod +x start.sh

EXPOSE 3306

CMD ["sh", "start.sh"]
