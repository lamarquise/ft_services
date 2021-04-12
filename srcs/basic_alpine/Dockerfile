#BASIC ALPINE
FROM alpine:latest


# apk add telegraf and possibly screen too
# we are starting from scratch...
RUN	apk update

RUN	apk add telegraf screen


# for now, because we can't use the default image, we have to do something
# so lets do something simple for now, even tho in the long run it makes sense
# that more interesting things would be done.

# Basically anything that has to be done every time we might as well do here
#RUN apk add bash
# he hassan does apk add --no-cash --upgrade bash but IDK what that does

# i think openrc is how i get to use service, as in service nginx start
# might as well do both of these here
#RUN apk add openrc openssl



# we are ignoring Telegraph for now...
