#GRAFANA
FROM basic_alpine_img

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN	apk add --no-cache grafana

COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf
COPY ./srcs/datasource.yaml /usr/share/grafana/conf/provisioning/datasources/datasource.yaml
COPY ./srcs/dashboard.yaml /usr/share/grafana/conf/provisioning/dashboards/dashboard.yaml
COPY ./srcs/dashboards /usr/share/grafana/dashboards/data
COPY ./srcs/defaults.ini /usr/share/grafana/conf/defaults.ini

WORKDIR /usr/share/grafana/conf

EXPOSE	3000

CMD	screen -d -m telegraf && grafana-server