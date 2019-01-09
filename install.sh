#!/bin/bash
apt-get install -y python3 python3-pip python3-venv
pip3 install ansible
ansible-galaxy install -r galaxy-requirements.yml
ansible-playbook -i inventory kali-playbook.yml
