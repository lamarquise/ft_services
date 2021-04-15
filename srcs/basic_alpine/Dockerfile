#BASIC ALPINE
FROM alpine:latest

RUN	apk update
RUN	apk add --no-cache telegraf screen

# might as well do both of these here
#RUN apk add openrc openssl

# I could do this
#COPY ./srcs/telegraf.conf
# and in influx i do a sed to replace influx with localhost...
