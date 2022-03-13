echo "Installing net-tools..."
yum -y install net-tools 

echo "Installing k3s"
systemctl disable firewalld --now
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--node-ip=192.168.42.110
  --bind-address=192.168.42.110
  --advertise-address=192.168.42.110
  --tls-san servertest
  --write-kubeconfig-mode 644"  sh -

sudo cp /var/lib/rancher/k3s/server/node-token /vagrant/node-token

echo "alias k='kubectl'" >> /home/vagrant/.bashrc
