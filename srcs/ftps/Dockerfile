#FTPS
FROM	basic_alpine_img

RUN	apk add --no-cache vsftpd openssl openrc

RUN	mkdir -p /etc/ssl/private

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out \
	/etc/ssl/private/vsftpd.pem -keyout /etc/ssl/private/vsftpd.pem \
	-subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=erlazo/CN=localhost"

COPY ./srcs/livenessprobe.sh .
RUN chmod +x livenessprobe.sh

COPY ./srcs/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf

COPY ./srcs/start.sh .
RUN	chmod +x start.sh

EXPOSE 20 21 30020 30021 30022
CMD	./start.sh
