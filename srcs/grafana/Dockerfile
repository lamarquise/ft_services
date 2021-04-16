#GRAFANA
FROM basic_alpine_img

# all my Dockerfile

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN	apk add --no-cache grafana

# added this...
#RUN apk add --no-cache openssl
#RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/ssl/localhost.pem -keyout /etc/ssl/localhost.key -subj "/C=FR/ST=Paris/L=Paris/O=Grafana K8s FT/OU=erlazo/CN=localhost"


COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf


# Grafana Config files copied a l'identique from Celia's for now
#COPY ./srcs/influxdb.yaml /usr/share/grafana/conf/provisioning/datasources/influxdb.yaml

	#hassan's way
COPY ./srcs/datasource.yaml /usr/share/grafana/conf/provisioning/datasources/datasource.yaml

COPY ./srcs/dashboard.yaml /usr/share/grafana/conf/provisioning/dashboards/dashboard.yaml

COPY ./srcs/dashboards /usr/share/grafana/dashboards/data

	# don't like this option...
#COPY ./srcs/grafana.db /usr/share/grafana/data/grafana.db

	# might need this .ini file to make it autopopulate...
COPY ./srcs/defaults.ini /usr/share/grafana/conf/defaults.ini

WORKDIR /usr/share/grafana/conf


EXPOSE	3000

#CMD tail -F /dev/null
CMD	screen -d -m telegraf && grafana-server