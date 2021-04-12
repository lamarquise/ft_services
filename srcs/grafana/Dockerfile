#GRAFANA
FROM basic_alpine_img

	# evenutally this will go in basic alpine
	# screen should also go in basic_alpine
RUN	apk add telegraf

				# do i need grafana-openrc? screen?
RUN	apk add grafana screen

COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf

WORKDIR /usr/share/grafana
COPY ./srcs/start.sh .
RUN	chmod +x start.sh


EXPOSE	3000

# for testing
CMD	./start.sh

#CMD	screen -d -m telegraf
