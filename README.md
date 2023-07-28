# Kalifigurator2.0  

These playbooks install most of the tools that I require with some tweaks for hardening, personalization, and making Kali quieter.

How to use
------

- Install Kali using the default install. See https://github.com/iesplin/kali-preseed for an example

- Clone this repo
    ```bash
    git clone https://github.com/jurjurijur/ansible-playbook-kali2.0.git
    ```

- Run the deploy script
    ```bash
    cd ansible-playbook-kali2.0
    ./deploy.sh
    ```

How to configure
------

Terminal Config: 

Add custom terminal config file under files -> terminal -> (terminal name)

-----------
Tools to install: 

go to group_vars -> vars.yml

Types of tools it can try to auto configure:
- Kali apt repo tools (duh)
- python_tools: give a git repo, it will try to install the python repo and install the tool in a pyenv virtual enviroment. 
- pipx: give pipx package name.
- tar packages with binary exacutables: give tar download url
- Go build packages 
- Go intsall repo packages 


Plans for the future 
------
- Make the terminal installation its own ansible role 
- Make the python tool in pyenv installer more robust
- By default install https://github.com/89luca89/distrobox with a blackarch container to 'natively' install tools from the blackarch repo

Wanne Help out? 
------
Send me a message at jurrie-99@hotmail.com. With enough requests we can setup a community or something. 

Author
-------
jurjurijur 

heavily based on 

iesplin premade work

License
-------

MIT
