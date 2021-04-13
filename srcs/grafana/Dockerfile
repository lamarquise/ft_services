#GRAFANA
FROM basic_alpine_img

RUN	apk add grafana

COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf

WORKDIR /usr/share/grafana

# add all the config files... when you have them

	# for testing
COPY ./srcs/start.sh .
RUN	chmod +x start.sh


EXPOSE	3000

# for testing
#CMD	./start.sh

CMD	screen -d -m telegraf && grafana-server
