echo "Installing net-tools..."
yum -y install net-tools 

echo "Installing k3s"
sudo systemctl disable firewalld --now
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--node-ip=192.168.42.110
  --write-kubeconfig-mode=644"  sh -

echo "alias k='kubectl'" >> /home/vagrant/.bashrc

/usr/local/bin/kubectl apply -f "/vagrant/confs/app1/app1_deployment.yaml"
/usr/local/bin/kubectl apply -f "/vagrant/confs/app1/app1_service.yaml"
/usr/local/bin/kubectl apply -f "/vagrant/confs/app1/app1_ingress.yaml"

/usr/local/bin/kubectl apply -f "/vagrant/confs/app2/app2_deployment.yaml"
/usr/local/bin/kubectl apply -f "/vagrant/confs/app2/app2_service.yaml"
/usr/local/bin/kubectl apply -f "/vagrant/confs/app2/app2_ingress.yaml"

/usr/local/bin/kubectl apply -f "/vagrant/confs/app3/app3_deployment.yaml"
/usr/local/bin/kubectl apply -f "/vagrant/confs/app3/app3_service.yaml"
/usr/local/bin/kubectl apply -f "/vagrant/confs/app3/app3_ingress.yaml"
