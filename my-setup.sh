#!/bin/bash

minikube delete

if [ $OSTYPE = "linux-gnu" ]; then
	printf "\t--- Testing if docker works --- \n";
	docker ps > /dev/null
	if [[ $? == 1 ]]; then
		printf "Your docker isn't working. Attempting to fix it now .....\n"
		sudo usermod -aG docker $(whoami);
		printf "Should be fixed now. Log off and on again please.\n"
		exit 1;
	else
		printf "Docker is working !\n";
	fi
fi

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


	# Consider using this...
minikube addons enable metallb

# OR if the kubectl method of doing metalDB
#kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/namespace.yaml
#kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/metallb.yaml
#kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

node_ip=$(kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p)

echo "apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - $node_ip-$node_ip" > ./srcs/metallb.yaml

#echo "    - $node_ip-$node_ip" >> ./srcs/metallb.yaml

kubectl apply -f ./srcs/config_map.yaml
kubectl apply -f ./srcs/secrets.yaml
kubectl apply -f ./srcs/metallb.yaml

# order matters?
docker build -t basic_alpine_img ./srcs/basic_alpine

#docker build -t influxdb_img ./srcs/influxdb
#kubectl apply -f ./srcs/influxdb/influxdb.yaml
#kubectl delete -f ./srcs/influxdb/influxdb.yaml

docker build -t mysql_img ./srcs/mysql
kubectl apply -f ./srcs/mysql/mysql.yaml
#kubectl delete -f ./srcs/mysql/mysql.yaml

#sleep 30;

docker build -t phpmyadmin_img ./srcs/phpmyadmin
kubectl apply -f ./srcs/phpmyadmin/phpmyadmin.yaml
#kubectl delete -f ./srcs/phpmyadmin/phpmyadmin.yaml

docker build -t wordpress_img ./srcs/wordpress
kubectl apply -f ./srcs/wordpress/wordpress.yaml
#kubectl delete -f ./srcs/wordpress/wordpress.yaml

#docker build -t nginx_img ./srcs/nginx
#kubectl apply -f ./srcs/nginx/nginx.yaml
#kubectl delete -f ./srcs/nginx/nginx.yaml

#docker build -t grafana_img ./srcs/grafana
#kubectl apply -f ./srcs/grafana/grafana.yaml
#kubectl delete -f ./srcs/grafana/grafana.yaml

#docker build -t ftps_img ./srcs/ftps
#kubectl apply -f ./srcs/ftps/ftps.yaml
#kubectl delete -f ./srcs/ftps/ftps.yaml


echo "Nginx: http://$node_ip"
echo "Wordpress: https://$node_ip:5050"
echo "Phpmyadmin: https://$node_ip:5000"
#echo "Wordpress: https://$node_ip:5050"

#echo https://$node_ip
# at the end
#minikube dashboard


