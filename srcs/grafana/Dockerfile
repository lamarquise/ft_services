#GRAFANA
FROM basic_alpine_img

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN	apk add --no-cache grafana

COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf


# Grafana Config files copied a l'identique from Celia's for now
COPY ./srcs/influxdb.yaml /usr/share/grafana/conf/provisioning/datasources/influxdb.yaml
COPY ./srcs/dashboards.yaml /usr/share/grafana/conf/provisioning/dashboards/dashboards.yaml
COPY ./srcs/ /usr/share/grafana/dashboards

	# don't like this option...
#COPY ./srcs/grafana.db /usr/share/grafana/data/grafana.db

WORKDIR /usr/share/grafana/conf


EXPOSE	3000


CMD	screen -d -m telegraf && grafana-server

	# if you do telegraf her way...
#CMD	["grafana-server"]
