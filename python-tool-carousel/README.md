Role Name
=========

Python Tool Carousel is an ansible role for cloning python tools from github and automagicly configuring them to be commandline executable in their own virtual envoirment. 

The project installs uses an configures Pyenv in attempt to avoid python dependency hell. 

Requirements
------------


Role Variables
--------------



Dependencies
------------


This ansible role uses ansible-role-pyenv from "static.dev" to convinently install and configure pyenv on the system. https://github.com/staticdev/ansible-role-pyenv


Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

``` main.yml```
  name: install python tools 
  hosts: kali
  become: true
  roles:
    - role: python-tool-carousel
      vars:
        python_tools_user: kali
        python_tools_user_homefolder: /home/kali
                                                  

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
