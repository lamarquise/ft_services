#!/bin/bash

minikube delete

if [ $OSTYPE = "linux-gnu" ]; then
	printf "\t--- Testing if docker works --- \n";
	docker ps > /dev/null
	if [[ $? == 1 ]]; then
		printf "Your docker isn't working. Attempting to fix it now .....\n"
		sudo usermod -aG docker $(whoami);
		printf "Should be fixed now. Log off and back on please.\n"
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

# if you don't do this, none of the containers can get made
eval $(minikube -p minikube docker-env)

minikube addons enable metallb

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

kubectl apply -f ./srcs/config_map.yaml
kubectl apply -f ./srcs/secrets.yaml
kubectl apply -f ./srcs/metallb.yaml

docker build -t basic_alpine_img ./srcs/basic_alpine

docker build -t influxdb_img ./srcs/influxdb
kubectl apply -f ./srcs/influxdb/influxdb.yaml
#kubectl delete -f ./srcs/influxdb/influxdb.yaml

docker build -t mysql_img ./srcs/mysql
kubectl apply -f ./srcs/mysql/mysql.yaml
#kubectl delete -f ./srcs/mysql/mysql.yaml

echo "Wait 30 seconds for MySQL to finish provisioning it's volume."
sleep 30;

docker build -t phpmyadmin_img ./srcs/phpmyadmin
kubectl apply -f ./srcs/phpmyadmin/phpmyadmin.yaml
#kubectl delete -f ./srcs/phpmyadmin/phpmyadmin.yaml

docker build -t wordpress_img ./srcs/wordpress
kubectl apply -f ./srcs/wordpress/wordpress.yaml
#kubectl delete -f ./srcs/wordpress/wordpress.yaml

docker build -t nginx_img ./srcs/nginx
kubectl apply -f ./srcs/nginx/nginx.yaml
#kubectl delete -f ./srcs/nginx/nginx.yaml

docker build -t grafana_img ./srcs/grafana
kubectl apply -f ./srcs/grafana/grafana.yaml
#kubectl delete -f ./srcs/grafana/grafana.yaml

docker build -t ftps_img ./srcs/ftps
kubectl apply -f ./srcs/ftps/ftps.yaml
#kubectl delete -f ./srcs/ftps/ftps.yaml

echo "Nginx: http://$node_ip"
echo "Wordpress: https://$node_ip:5050"
echo "Phpmyadmin: https://$node_ip:5000"
echo "FTPS: $node_ip User:'user' Password:'password'"
echo "Grafana: http://$node_ip:3000"
echo "Datasource in Grafana from IndluxDB: http://influxdb-service:8086"

minikube dashboard
