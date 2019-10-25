#!/bin/bash

echo ""
echo "  █████╗ ███╗   ██╗███████╗██╗██████╗ ██╗     ███████╗    ██╗  ██╗    ██╗  ██╗ █████╗ ██╗     ██╗"
echo " ██╔══██╗████╗  ██║██╔════╝██║██╔══██╗██║     ██╔════╝    ██║  ██║    ██║ ██╔╝██╔══██╗██║     ██║"
echo " ███████║██╔██╗ ██║███████╗██║██████╔╝██║     █████╗      ███████║    █████╔╝ ███████║██║     ██║"
echo " ██╔══██║██║╚██╗██║╚════██║██║██╔══██╗██║     ██╔══╝      ╚════██║    ██╔═██╗ ██╔══██║██║     ██║"
echo " ██║  ██║██║ ╚████║███████║██║██████╔╝███████╗███████╗         ██║    ██║  ██╗██║  ██║███████╗██║"
echo " ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚═╝╚═════╝ ╚══════╝╚══════╝         ╚═╝    ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝"
echo " Manually configuring Kali? Ain't nobody got time for that."
echo ""

if ! command -v pip3; then
    echo "[+] Installing Pip for Python 3"
    sudo apt-get install -y python3-pip python3-setuptools
    if [ "$?" -gt 0 ]; then
        echo "[!] Error occurred when attempting to install Pip."
        exit 1
    fi
fi

if ! command -v pipenv; then
    pip3 install --user pipenv
    if [ "$?" -gt 0 ]; then
        echo "[!] Error occurred when attempting to install Pipenv."
        exit 1
    fi
else
    pipenv --three install
    if [ "$?" -gt 0 ]; then
        echo "[!] Error occurred when attempting to setup Pipenv environment."
        exit 1
    fi

    pipenv update
    if [ "$?" -gt 0 ]; then
        echo "[!] Error occurred when attempting to update Pipenv environment."
        exit 1
    fi
fi

echo -e "\n[+] Downloading latest versions of Ansible roles\n"
#ansible-galaxy install --force -r galaxy-requirements.yml
if [ "$?" -gt 0 ]; then
    echo "[!] Error occurred when attempting to download Ansible roles."
    exit 1    
fi

pipenv run ansible-playbook -i inventory --ask-become-pass main.yml
if [ "$?" -gt 0 ]; then
    echo "[!] Error occurred during playbook run."
    exit 1    
fi

echo "[!] Finished"