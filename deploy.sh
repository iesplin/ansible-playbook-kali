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

required_packages=( python3-pip python3-venv )
missing_packages=""

for deb in "${required_packages[@]}"; do
    dpkg --get-selections| grep -E "^$deb\s+install$"
    if [ $? -eq 1 ]; then
        missing_packages+="$deb "
    fi
done

echo "[+] Installing required packages"
if [ ! -z "$missing_packages" ]; then
    sudo apt-get install $missing_packages
fi

if [ ! -d ".venv" ]; then
    echo "[+] Creating virtualenv"    
    python3 -m venv .venv
fi

echo "[+] Installing/updating Ansible"
source .venv/bin/activate && pip3 install --user --upgrade ansible
if [ $? -gt 0 ]; then
    echo "[!] Error occurred when attempting to install Ansible."
    exit 1
fi

echo -e "\n[+] Downloading latest versions of Ansible roles\n"
source .venv/bin/activate && ansible-galaxy install --force -r galaxy-requirements.yml
if [ $? -gt 0 ]; then
    echo "[!] Error occurred when attempting to download Ansible roles."
    exit 1    
fi

echo -e "\n[+] Running Ansible 4 Kali playbooks\n"
source .venv/bin/activate && ansible-playbook -i inventory --ask-become-pass main.yml
if [ $? -gt 0 ]; then
    echo "[!] Error occurred during playbook run."
    exit 1    
fi

echo "[!] Finished"
