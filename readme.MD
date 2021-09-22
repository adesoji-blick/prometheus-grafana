## Installing Prometheus   ---- port 9090
wget https://github.com/prometheus/prometheus/releases/download/v2.30.0/prometheus-2.30.0.linux-amd64.tar.gz
tar -xvf prometheus-2.30.0.linux-amd64.tar.gz
cd prometheus-2.30.0.linux-amd64.tar.gz
sudo cp -r . /usr/local/bin/prometheus

sudo vi /etc/systemd/system/prometheus.service
sudo systemctl start prometheus

## Installing Node-Exporter ---- port  9100
wget https://github.com/prometheus/node_exporter/releases/download/v1.2.2/node_exporter-1.2.2.linux-amd64.tar.gz
tar xvf node_exporter-1.2.2.linux-amd64.tar.gz
cd node_exporter-1.2.2.linux-amd64/
sudo cp node_exporter-1.2.2.linux-amd64/node_exporter /usr/local/bin

sudo vi /etc/systemd/system/node-exporter.service

systemctl daemon-reload
sudo systemctl start node-exporter

## include Node-exporter job on prometheus.yml file
cd /usr/local/bin/prometheus/

sudo systemctl restart prometheus

cd /usr/local/bin/prometheus
sudo vi prometheus_rules.yml
./promtool check rules prometheus_rules.yml

## update prometheus.yml file to include "prometheus_rules.yml"
sudo systemctl restart 

## Installing Alert Manager  ---- port 9093
wget https://github.com/prometheus/alertmanager/releases/download/v0.23.0/alertmanager-0.23.0.linux-amd64.tar.gz
tar vxf alertmanager-0.23.0.linux-amd64.tar.gz

cd alertmanager-0.23.0.linux-amd64/
sudo cp -r . /usr/local/bin/alertmanager

sudo vi /etc/systemd/system/alertmanager.service *****
cd /usr/local/bin/alertmanager
sudo vi alertmanager.yml
/usr/local/bin/alertmanager/amtool check-config /usr/local/bin/alertmanager/alertmanager.yml

sudo systemctl start alertmanager

## Installing Grafana ---- port 3000
sudo vi /etc/yum.repos.d/grafana.repo
sudo yum install grafana-enterprise
sudo systemctl start grafana-server
sudo systemctl status grafana-server
sudo systemctl enable grafana-server

wget https://dl.grafana.com/enterprise/release/grafana-enterprise-8.1.5-1.x86_64.rpm
sudo yum install grafana-enterprise-8.1.5-1.x86_64.rpm