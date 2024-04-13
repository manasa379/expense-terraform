#!/bin/bash

dnf install python3.11-pip -y
pip3.11 install boto3 botocore
ansible-pull -i localhost, -U https://github.com/manasa379/infra-ansible.git main.yml -e role_name=${role_name}