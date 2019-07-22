#!/bin/bash
sudo apt-get install -y git python3 python3-pip
pip3 install -U ansible
ansible-galaxy install --force -r galaxy-requirements.yml
ansible-playbook -i inventory --become kali-playbook.yml
