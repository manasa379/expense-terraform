#!/bin/bash

yum install ansible python3.11-pip -y &>>/opt/userdata.log
pip3.11 install botocore boto3 &>>/opt/userdata.log
ansible-pull -i localhost, -U https://github.com/manasa379/infra-ansible.git main.yml -e role_name=${role_name}