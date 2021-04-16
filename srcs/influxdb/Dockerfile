#INFLUXDB
FROM basic_alpine_img

RUN	apk add --no-cache influxdb

EXPOSE 8086

COPY ./srcs/livenessprobe.sh livenessprobe.sh

	# not if i do celia's thing for telegraf...
COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf


#CMD	screen -d -m telegraf && influxdb

#if i do celia's thing for Telegraf
CMD	["influxdb", "run"]