#!/bin/bash -eux
if [ ! -f "/usr/bin/pipenv" ]; then
    sudo apt-get install pipenv
fi

pipenv run ansible-galaxy install --force -r galaxy-requirements.yml
pipenv run ansible-playbook -i inventory --become kali-playbook.yml
pipenv run ansible-playbook -i inventory kali-personalize-playbook.yml
