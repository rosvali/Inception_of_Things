echo "Installing net-tools..."
yum -y install net-tools 

echo "Installing k3s"
sudo systemctl disable firewalld --now
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--node-ip=192.168.42.110
  --write-kubeconfig-mode=644"  sh -

echo "alias k='kubectl'" >> /home/vagrant/.bashrc

# kubectl apply -f "/vagrant/app1_deployment.yaml"
# kubectl apply -f "/vagrant/app1_service.yaml"
# kubectl apply -f "/vagrant/app1_ingress.yaml"
