#!/bin/sh

adduser -S $FTP_USER -s /bin/sh
addgroup $FTP_USER
addgroup $FTP_USER $FTP_USER
echo $FTP_USER:$FTP_PASSWORD | chpasswd

openrc
touch /run/openrc/softlevel

rc-update add vsftpd default
service vsftpd restart
touch /var/log/vsftpd.log

screen -d -m telegraf

sed  -i 's/NODE_IP/'$NODE_IP'/g' /etc/vsftpd/vsftpd.conf

tail -f /var/log/vsftpd.log