#MYSQL
FROM basic_alpine_img

RUN	apk add --no-cache mariadb mariadb-client openrc

COPY ./srcs/livenessprobe.sh livenessprobe.sh
COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf

COPY ./srcs/start.sh .
RUN chmod +x start.sh

EXPOSE 3306

CMD ["sh", "start.sh"]
