#!/bin/bash

# first iteration will be simple:
# - build images
# - start minikube and kubectl and all that 
# - apply yaml files to populate Cluster
# - Helm to get K8 Dashboard?

# do i want a fancy setup where i check to see if minikube and all that has
# been installed ?

# Run minikube delete first?


minikube delete

# the part where we decide between hyperkit and docker for the VM
OS=$(uname -s)
if [ $OS = Darwin ]
then
	minikube start --driver=hyperkit
else
	minikube start
fi


# if you don't do this, non of the containers can get made
eval $(minikube -p minikube docker-env)


docker build -t basic_alpine_img ./srcs/basic_alpine

docker build -t wordpress_img ./srcs/wordpress
docker build -t mysql_img ./srcs/mysql
docker build -t phpmyadmin_img ./srcs/phpmyadmin
docker build -t nginx_img ./srcs/nginx
docker build -t grafana_img ./srcs/grafana
docker build -t influxdb_img ./srcs/influxdb
docker build -t ftps_img ./srcs/ftps

#minikube addons enable metallb
#kubectl apply -f ./srcs/metallb.yaml

# OR if the kubectl method of doing metalDB
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

node_ip=$(kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p)

echo "    - $node_ip-$node_ip" >> ./srcs/metallb.yaml

kubectl apply -f ./srcs/metallb.yaml

# order matters?

#kubectl apply -f ./srcs/influxdb/srcs/influxdb.yaml
#kubectl apply -f ./srcs/mysql/srcs/mysql.yaml
#kubectl apply -f ./srcs/wordpress/srcs/wordpress.yaml
#kubectl apply -f ./srcs/phpmyadmin/srcs/phpmyadmin.yaml
#kubectl apply -f ./srcs/nginx/srcs/nginx.yaml
#kubectl apply -f ./srcs/grafana/srcs/grafana.yaml
#kubectl apply -f ./srcs/ftps/srcs/ftps.yaml


echo https://$node_ip
# at the end
#minikube dashboard


