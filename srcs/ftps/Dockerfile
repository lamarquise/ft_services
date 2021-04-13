#FTPS

FROM	basic_alpine_img

RUN	apk add vsftpd openssl

RUN	mkdir -p /etc/ssl/private

	# no idea why both -out and -keyout are .pem, i thought one was supposed
	# be .key ?

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out \
	/etc/ssl/private/vsftpd.pem -keyout /etc/ssl/private/vsftpd.pem \
	-subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=erlazo/CN=localhost"

COPY ./srcs/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf

	# will become obsolete?
COPY ./srcs/start.sh .
RUN	chmod +x start.sh

	# start with just this but could add other ports
EXPOSE	20 21 7777

#CMD	./start.sh

	# if this command doesn't work as such, i can run it through a .sh file
CMD	vsftpd /etc/vsftpd/vsftpd.conf
