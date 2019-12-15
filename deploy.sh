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

required_packages=( python3-pip )
missing_packages=""

for deb in "${required_packages[@]}"; do
    dpkg --get-selections| grep -E "^$deb\s+install$" 2>&1 >/dev/null
    if [ $? -eq 1 ]; then
        missing_packages+="$deb "
    fi
done

if [ ! -z "$missing_packages" ]; then
    echo "[+] Installing required packages"
    sudo apt-get update -y && sudo apt-get install -y $missing_packages
fi

if ! command -v ansible >/dev/null; then
    echo "[+] Installing Ansible"
    sudo -H pip3 install --upgrade ansible
    if [ $? -gt 0 ]; then
        echo "[!] Error occurred when attempting to install Ansible."
        exit 1
    fi
fi

echo -e "\n[+] Downloading latest versions of Ansible roles\n"
ansible-galaxy install --force -r galaxy-requirements.yml
if [ $? -gt 0 ]; then
    echo "[!] Error occurred when attempting to download Ansible roles."
    exit 1    
fi

echo -e "\n[+] Running Ansible 4 Kali playbooks\n"
ansible-playbook -i inventory --ask-become-pass main.yml
if [ $? -gt 0 ]; then
    echo "[!] Error occurred during playbook run."
    exit 1    
fi

echo "[!] Finished"
