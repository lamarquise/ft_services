#INFLUXDB
FROM basic_alpine_img

RUN	apk add --no-cache influxdb

EXPOSE 8086

RUN mkdir -p /etc/influxdb && mv /etc/influxdb.conf /etc/influxdb/influxdb.conf

COPY ./srcs/livenessprobe.sh livenessprobe.sh

COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf

CMD	screen -d -m telegraf && influxd