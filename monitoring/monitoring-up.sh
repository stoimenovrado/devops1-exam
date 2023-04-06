#!/bin/bash

echo "* Start Prometeus container ..."
docker container run -d --name prometheus -p 9090:9090 --mount type=bind,source=/vagrant/monitoring/prometheus.yml,destination=/etc/prometheus/prometheus.yml\
 prom/prometheus

echo "* Start Grafana container ..."
docker container run -d --name grafana -p 3000:3000\
 --mount type=bind,source=/vagrant/monitoring/datasources.yml,destination=/etc/grafana/provisioning/datasources/datasources.yml\
  grafana/grafana
