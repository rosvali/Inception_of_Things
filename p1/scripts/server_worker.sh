#!/bin/bash

echo "Installing net-tools..."
yum -y install net-tools

echo "Installing k3s"
systemctl disable firewalld --now
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="agent
  --server https://192.168.42.110:6443
  --token-file /vagrant/token/node-token
  --node-ip=192.168.42.111" sh -

echo "alias k='kubectl'" >> /home/vagrant/.bashrc

echo "[Serverworker complete]"