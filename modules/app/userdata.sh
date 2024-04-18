#!/bin/bash

dnf install ansible python3.11-pip -y
pip3.11 install botocore boto3
ansible-pull -i localhost, -U https://github.com/manasa379/infra-ansible.git main.yml -e role_name=${role_name}