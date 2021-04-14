#!/bin/sh

# consider doing this in the Dockerfile
#apk add openrc
#openrc
#touch /run/openrc/softlevel


#Celia does adduser stuff here...

#service vsftpd restart
/usr/sbin/vsftpd /etc/vsftpd.conf

tail -F /dev/null