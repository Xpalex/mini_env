#!/bin/sh
if [[ $dist == 'fedora' ]] || [[ $(uname -s) == Linux ]]; then
   yes Y | sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
   yes Y | sudo yum update -y
   yes Y | sudo yum install ansible -y
   cd /tmp/srv_ansible_data
   ansible-playbook playbook.yml
else [[ $dist == 'debian' ]] &&  [[ $dist == 'ubuntu' ]]; 
   yes Y | sudo apt-get install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
   yes Y | sudo apt-get update && sudo apt-get -y upgrade
   yes Y | sudo apt-get install ansible -y
   cd /tmp/srv_ansible_data
   ansible-playbook playbook.yml
fi
