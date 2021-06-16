#!/bin/sh
#---------------------------------------------------------------
# Variables
# IP address and remote user for install terraform
#---------------------------------------------------------------
remote_IP="localhost"
remote_User="ec2-user"
#---------------------------------------------------------------
# Copy and run script for install terraform to server
#---------------------------------------------------------------
if [ $remote_IP = "localhost" ] 
then
# Copy data and run script to "localhost"
   cp -r srv_terraform_data /tmp/
   cd /tmp/srv_terraform_data
   bash install_run_terraform.sh 
else    
# Copy data and run script to remote host
   scp -r srv_terraform_data $remote_User@$remote_IP:/tmp/
   ssh $remote_User@$remote_IP < ./srv_terraform_data/install_run_terraform.sh 
fi

  
      
