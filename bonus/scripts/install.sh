sudo localedef -v -c -i en_US -f UTF-8 en_US.UTF-8
systemctl disable firewalld --now

curl -s https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash

yum -y install gitlab-ce

sudo sed -i 's|external_url \x27http://gitlab.example.com\x27|external_url \x27http://192.168.42.100:8181\x27|g' /etc/gitlab/gitlab.rb 

sudo gitlab-ctl reconfigure

sudo cat /etc/gitlab/initial_root_password