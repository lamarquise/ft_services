#!/bin/sh

# mostly for test purposes

# consider doing this in the Dockerfile
apk add openrc
openrc
touch /run/openrc/softlevel


#service vsftpd restart




sh
