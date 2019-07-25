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
if [ ! -f "/usr/bin/ansible" ]; then
    echo "[+] Installing Ansible"
    sudo apt-get install -y ansible
fi
echo -e "\n[+] Downloading latest versions of Ansible roles\n"
ansible-galaxy install --force -r galaxy-requirements.yml

echo -e "\n[+] Deploying updates, tools, and config\n"
ansible-playbook -i inventory --ask-become-pass kali-playbook.yml

echo -e "\n[+] Deploying user personalizations\n"
ansible-playbook -i inventory --ask-become-pass kali-personalize-playbook.yml

echo "[!] Finished"