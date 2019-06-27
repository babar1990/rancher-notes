#!/usr/bin/env bash

#Add public key
echo 'ssh-rsa ' >> ~/.ssh/authorized_keys2

#stuff install
apt update
apt install -y apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

apt update
apt-get install -y docker-ce nfs-kernel-server

# docker config
echo '{"dns": ["10.0.0.2", "8.8.8.8"]}' > /etc/docker/daemon.json
service docker restart

# nfs config
mkdir /home/nfs
chown nobody:nogroup /home/nfs

echo  '/home/nfs 127.0.0.1(rw,sync,no_subtree_check,no_root_squash)' >> /etc/exports
systemctl restart nfs-kernel-server