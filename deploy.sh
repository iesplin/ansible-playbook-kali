#!/bin/sh

echo ""
echo "  █████╗ ███╗   ██╗███████╗██╗██████╗ ██╗     ███████╗    ██╗  ██╗    ██╗  ██╗ █████╗ ██╗     ██╗"
echo " ██╔══██╗████╗  ██║██╔════╝██║██╔══██╗██║     ██╔════╝    ██║  ██║    ██║ ██╔╝██╔══██╗██║     ██║"
echo " ███████║██╔██╗ ██║███████╗██║██████╔╝██║     █████╗      ███████║    █████╔╝ ███████║██║     ██║"
echo " ██╔══██║██║╚██╗██║╚════██║██║██╔══██╗██║     ██╔══╝      ╚════██║    ██╔═██╗ ██╔══██║██║     ██║"
echo " ██║  ██║██║ ╚████║███████║██║██████╔╝███████╗███████╗         ██║    ██║  ██╗██║  ██║███████╗██║"
echo " ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚═╝╚═════╝ ╚══════╝╚══════╝         ╚═╝    ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝"
echo " Manually configuring Kali? Ain't nobody got time for that."
echo ""

# Ensure .local/bin is in the PATH for ansible executables
PATH=$PATH:$HOME/.local/bin

if ! command -v pip3 >/dev/null; then
    echo "[+] Installing pip package manager"
    sudo apt-get update -y && sudo apt-get install -y python3-pip
    if [ $? -gt 0 ]; then
        echo "[!] Error occurred when attempting to install python3-pip package."
        exit 1
    fi
fi

if ! command -v ansible >/dev/null; then
    echo "[+] Installing Ansible via pip"
    python3 -m pip install --upgrade --user ansible
    if [ $? -gt 0 ]; then
        echo "[!] Error occurred when attempting to install Ansible."
        exit 1
    fi
fi

echo -e "\n[+] Installing required Ansible collections\n"
ansible-galaxy collection install --upgrade -r requirements.yml
if [ $? -gt 0 ]; then
    echo "[!] Error occurred when attempting to install Ansible collections."
    exit 1
fi


echo -e "\n[+] Downloading required roles\n"
ansible-galaxy role install --force -r requirements.yml
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
