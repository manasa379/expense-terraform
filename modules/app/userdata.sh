#!/bin/bash

dnf install ansible python3.11-pip.noarch -y | tee -a /opt/userdata.log
pip3.11 install boto3 botocore | tee -a /opt/userdata.log
ansible-pull -i localhost, -U https://github.com/manasa379/infra-ansible.git main.yml -e role_name=${role_name} -e env=${env} | tee -a /opt/userdata.log