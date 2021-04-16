#INFLUXDB
FROM basic_alpine_img

RUN	apk add --no-cache influxdb

EXPOSE 8086

COPY ./srcs/livenessprobe.sh livenessprobe.sh

	# not if i do celia's thing for telegraf...
COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf

#RUN apk add openrc
#RUN openrc & touch /run/openrc/softlevel

#CMD tail -F /dev/null

CMD	screen -d -m telegraf && influxd

#if i do celia's thing for Telegraf
#CMD	["influxd", "run"]