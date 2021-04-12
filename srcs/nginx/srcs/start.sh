#!/bin/sh

apk add openrc
openrc
touch /run/openrc/softlevel

service nginx start

sh
