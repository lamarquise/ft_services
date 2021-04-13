#INFLUXDB
FROM basic_alpine_img

RUN	apk add influxdb

EXPOSE 8086

COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf

COPY ./srcs/start.sh .
RUN	chmod +x start.sh

# tmp for testing
# actually maybe need this permanently
#CMD ./start.sh

CMD	screen -d -m telegraf && influxd
