#!/bin/sh
#---------------------------------------------------------------
# Variables
# Geting latest version of terraform
#---------------------------------------------------------------
TER_VER=`curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest |  grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1'`
#---------------------------------------------------------------
# Download and install terraform's package
#---------------------------------------------------------------
wget https://releases.hashicorp.com/terraform/${TER_VER}/terraform_${TER_VER}_linux_amd64.zip
unzip terraform_${TER_VER}_linux_amd64.zip
sudo mv terraform /usr/local/bin
#---------------------------------------------------------------
# Run infrastrucrure on AWS with terraform
#---------------------------------------------------------------
cd aws
# Generate keys "gcp_key" and "ans_ins_key" for connect to ansible server
ssh-keygen -f amz_key -P ""
ssh-keygen -f ans_ins_key -P ""
# Run terraform
terraform init
terraform apply -auto-approve
#---------------------------------------------------------------
# Run infrastrucrure on GCP with terraform
#---------------------------------------------------------------
cd ../gcp
# Generate keys "amz_key" and "ans_ins_key" for connect to ansible server
ssh-keygen -f gcp_key -P ""
ssh-keygen -f ans_ins_key -P ""
# Run terraform
terraform init
terraform apply -auto-approve
#---------------------------------------------------------------
# Run infrastrucrure on Azure with terraform
#---------------------------------------------------------------
cd ../azure
# Generate keys "amz_key" and "ans_ins_key" for connect to ansible server
ssh-keygen -f azure_key -P ""
ssh-keygen -f ans_ins_key -P ""
# Run terraform
terraform init
terraform apply -auto-approve
