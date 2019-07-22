#!/bin/bash
if [ ! -f "/usr/bin/ansible" ]; then
    sudo apt-get install -y ansible
fi

ansible-galaxy install --force -r galaxy-requirements.yml
ansible-playbook -i inventory --become kali-playbook.yml
ansible-playbook -i inventory --become kali-personalize-playbook.yml
