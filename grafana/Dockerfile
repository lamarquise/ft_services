#GRAFANA
FROM basic_alpine_img

	# evenutally this will go in basic alpine
	# screen should also go in basic_alpine
RUN	apk add telegraf

				# do i need grafana-openrc? screen?
RUN	apk add grafana screen

COPY ./srcs/start.sh .
RUN	chmod +x start.sh

# basically this puts us in the /usr/share/grafana dir from the get go
# do this after you copy things
WORKDIR /usr/share/grafana

EXPOSE	3000

# for testing
CMD	./start.sh

#CMD	screen -d -m telegraf
