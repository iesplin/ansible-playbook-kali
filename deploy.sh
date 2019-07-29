#!/bin/bash
echo ""
echo " █████╗ ███╗   ██╗███████╗██╗██████╗ ██╗     ███████╗    ██╗  ██╗    ██╗  ██╗ █████╗ ██╗     ██╗"
echo "██╔══██╗████╗  ██║██╔════╝██║██╔══██╗██║     ██╔════╝    ██║  ██║    ██║ ██╔╝██╔══██╗██║     ██║"
echo "███████║██╔██╗ ██║███████╗██║██████╔╝██║     █████╗      ███████║    █████╔╝ ███████║██║     ██║"
echo "██╔══██║██║╚██╗██║╚════██║██║██╔══██╗██║     ██╔══╝      ╚════██║    ██╔═██╗ ██╔══██║██║     ██║"
echo "██║  ██║██║ ╚████║███████║██║██████╔╝███████╗███████╗         ██║    ██║  ██╗██║  ██║███████╗██║"
echo "╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚═╝╚═════╝ ╚══════╝╚══════╝         ╚═╝    ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝"
echo "Manually configuring Kali? Ain't nobody got time for that."
echo ""

CONF="./deploy.conf"

if [ -f "${CONF}" ]; then
    source ${CONF}
else
    echo "Which Kali build do want to deploy?"
    echo "[1] Basic - Burp Suite Community"
    echo "[2] Pro   - Burp Suite Pro"
    echo ""
    while true; do
        read -p "Enter the number for the build: " build_selection
        case $build_selection in
            1* ) kali_build="basic"; break;;
            2* ) kali_build="pro"; break;;
            * ) echo "Please enter a valid option";;
        esac
    done
    echo "kali_build=\"${kali_build}\"" > ${CONF}
fi

if [ "$kali_build" = basic ] || [ "$kali_build" = pro ]; then
    echo "Deploying Kali build: ${kali_build}"
else
    echo "[!] ERROR: Unknown Kali build type. Exiting."
    exit 1
fi

if [ ! -f "/usr/bin/ansible" ]; then
    echo "[+] Installing Ansible"
    sudo apt-get install -y ansible
fi

echo -e "\n[+] Downloading latest versions of Ansible roles\n"
ansible-galaxy install --force -r galaxy-requirements.yml

echo -e "\n[+] Deploying updates, tools, and config\n"
ansible-playbook -i inventory-${kali_build} --ask-become-pass kali-playbook.yml

echo -e "\n[+] Deploying user personalizations\n"
ansible-playbook -i inventory-${kali_build} --ask-become-pass kali-personalize-playbook.yml

echo "[!] Finished"