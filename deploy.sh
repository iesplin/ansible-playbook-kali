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

if ! command -v pip3 > /dev/null; then
    echo "[+] Installing Pip for Python 3"
    sudo apt-get install -y python3-pip python3-setuptools
    if [ $? -gt 0 ]; then
        echo "[!] Error occurred when attempting to install Pip."
        exit 1
    fi
fi

if ! command -v pipenv > /dev/null; then
    echo "[+] Installing Pipenv module"
    pip3 install --user --upgrade pipenv
    if [ $? -gt 0 ]; then
        echo "[!] Error occurred when attempting to install Pipenv."
        exit 1
    fi
fi

# Check for existing venv
pipenv --venv 2>/dev/null

# Create new venv
if [ $? -eq 1 ]; then
    pipenv --three
fi

echo "[+] Updating venv"
# Update dependencies in venv
pipenv update
if [ $? -gt 0 ]; then
    echo "[!] Error occurred when attempting to update Pipenv environment."
    exit 1
fi

echo -e "\n[+] Downloading latest versions of Ansible roles\n"
pipenv run ansible-galaxy install --force -r galaxy-requirements.yml
if [ $? -gt 0 ]; then
    echo "[!] Error occurred when attempting to download Ansible roles."
    exit 1    
fi

pipenv run ansible-playbook -i inventory --ask-become-pass main.yml
if [ $? -gt 0 ]; then
    echo "[!] Error occurred during playbook run."
    exit 1    
fi

echo "[!] Finished"