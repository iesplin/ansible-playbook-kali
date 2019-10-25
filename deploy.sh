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

echo "[+] Installing/updating Ansible"
pip3 install --user --upgrade ansible
if [ $? -gt 0 ]; then
    echo "[!] Error occurred when attempting to install Ansible."
    exit 1
fi

echo -e "\n[+] Downloading latest versions of Ansible roles\n"
ansible-galaxy install --force -r galaxy-requirements.yml
if [ $? -gt 0 ]; then
    echo "[!] Error occurred when attempting to download Ansible roles."
    exit 1    
fi

ansible-playbook -i inventory --ask-become-pass main.yml
if [ $? -gt 0 ]; then
    echo "[!] Error occurred during playbook run."
    exit 1    
fi

echo "[!] Finished"
