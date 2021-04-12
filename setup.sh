#!/bin/bash

# first iteration will be simple:
# - build images
# - start minikube and kubectl and all that 
# - apply yaml files to populate Cluster
# - Helm to get K8 Dashboard?

# do i want a fancy setup where i check to see if minikube and all that has
# been installed ?

# Run minikube delete first?

# better safe than sorry
eval $(minikube -p minikube docker-env)


docker build -t basic_alpine_img ./srcs/basic_alpine

docker build -t wordpress_img ./srcs/wordpress
docker build -t mysql_img ./srcs/mysql
docker build -t phpmyadmin_img ./srcs/phpmyadmin
docker build -t nginx_img ./srcs/nginx
docker build -t grafana_img ./srcs/grafana
docker build -t influxdb_img ./srcs/influxdb
docker build -t ftps_img ./srcs/ftps

# now what ? minikube?

# metalLB
# seems like this is a shortcut around downloading the hard way all the metalLB stuff
# with kubectl, if im doing the easy way, i might as well fully do the easy way
minikube addons enable metallb
# i think that allows this to work
kubectl apply -f ./srcs/metallb.yaml

# OR if the kubectl method of doing metalDB
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

# do the sed to replace IP here
kubectl apply -f ./srcs/metallb.yaml


# order matters?

#kubectl apply -f ./srcs/influxdb/srcs/influxdb.yaml
kubectl apply -f ./srcs/mysql/srcs/mysql.yaml
kubectl apply -f ./srcs/wordpress/srcs/wordpress.yaml
#kubectl apply -f ./srcs/phpmyadmin/srcs/phpmyadmin.yaml
#kubectl apply -f ./srcs/nginx/srcs/nginx.yaml
#kubectl apply -f ./srcs/grafana/srcs/grafana.yaml

node_ip=$(kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p)

# to add the node_ip dynamically to the metalld.yaml file
sed -e 's/node_ip/'$node_ip'/g' ./srcs/metallb.yaml


echo https://$node_ip
# at the end
minikube dashboard


