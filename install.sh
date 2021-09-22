#!/bin/bash

## Installing Prometheus
echo ----- Installing Prometheus ------
cd ~
wget https://github.com/prometheus/prometheus/releases/download/v2.30.0/prometheus-2.30.0.linux-amd64.tar.gz
tar -xvf prometheus-2.30.0.linux-amd64.tar.gz
cd prometheus-2.30.0.linux-amd64.tar.gz
sudo cp -r . /usr/local/bin/prometheus
cd ~
sudo cp prometheus-grafana/prometheus.service /etc/systemd/system/prometheus.service
sudo systemctl start prometheus


## Installing Node Exporter
echo ----- Installing Prometheus Node Exporter ------
wget https://github.com/prometheus/node_exporter/releases/download/v1.2.2/node_exporter-1.2.2.linux-amd64.tar.gz
tar xvf node_exporter-1.2.2.linux-amd64.tar.gz
sudo cp node_exporter-1.2.2.linux-amd64/node_exporter /usr/local/bin
sudo cp prometheus-grafana/node-exporter.service /etc/systemd/system/node-exporter.service
sudo systemctl start node-exporter


## include Node-exporter job on prometheus.yml file and creating prometheus_rule.yml file
echo ----- include Node-exporter job on prometheus.yml file and creating prometheus_rule.yml file -----
cd ~
sudo rm /usr/local/bin/prometheus/prometheus.yml
sudo cp prometheus-grafana/prometheus.yml /usr/local/bin/prometheus/prometheus.yml
sudo cp prometheus-grafana/prometheus_rules.yml  /usr/local/bin/prometheus/prometheus_rules.yml
sudo systemctl restart prometheus
# ./promtool check rules prometheus_rules.yml


## Installing Alert Manager  ---- port 9093
echo ----- Installing Prometheus Alert Manager ------
wget https://github.com/prometheus/alertmanager/releases/download/v0.23.0/alertmanager-0.23.0.linux-amd64.tar.gz
tar vxf alertmanager-0.23.0.linux-amd64.tar.gz
cd alertmanager-0.23.0.linux-amd64/
sudo cp -r . /usr/local/bin/alertmanager
cd ~
sudo cp prometheus-grafana/alertmanager.service  /etc/systemd/system/alertmanager.service
sudo rm /usr/local/bin/alertmanager/alertmanager.yml
sudo cp prometheus-grafana/alertmanager.yml /usr/local/bin/alertmanager/alertmanager.yml
# /usr/local/bin/alertmanager/amtool check-config /usr/local/bin/alertmanager/alertmanager.yml
sudo systemctl start alertmanager

## Installing Grafana ---- port 3000
echo ----- Installing grafana -------
wget https://dl.grafana.com/enterprise/release/grafana-enterprise-8.1.5-1.x86_64.rpm
sudo yum install grafana-enterprise-8.1.5-1.x86_64.rpm -y
sudo systemctl start grafana-server
sudo systemctl enable grafana-server

# http://localhost:9090
# import 1860