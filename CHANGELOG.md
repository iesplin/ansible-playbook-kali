# Changelog

## 2021.04.21

- Use HTTPS for Kali repository
- Merged Kali package lists
- Added UFW application profile for Responder
- Added roadrecon (https://github.com/dirkjanm/ROADtools)
- Added jq tool
- Added seclists package and removed cloning SecLists git repo
- Removed joplin
- Removed symlink workaround for John
- Removed qterminal configuration
- Removed Covenant temporarily until the DonutCore dependency is resolved (https://github.com/cobbr/Covenant/issues/313)

## 2021.01.12

- Added ffuf
- Removed chromium. The package has been removed from the Kali repo
- Removed crackmapexec python package. The Kali repo now has a more up-to-date version

## 2020.10.21

- No more hard-coding the kali_user variable. Instead, automatically set it to the user that ran the playbook
- Cleaned up configuration to be less awful

## 2020.10.13

- John: create symlink for john so that is is found in the user's path
- xfwm: Revert vblank_mode change as there is still some occassional flickering

## 2020.10.12

- xfwm: use default vblank_mode

## 2020.09.24

- WireGuard: use systemd-resolvectl as an alternative for resolvconf. - (https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=939904)

## 2020.09.24

- Rebased on the kali-linux-default metapackage. Default install has been trimmed down enough to not care about the extra packages I don't use
- Removed Gnome configuration. No longer used after switching to XFCE
- Removed git repositories that were rarely used
- Updated default profile creation for Firefox ESR
- Add missing dependencies for Evil-WinRM
- Install CrackMapExec from PyPI as it is more recent than the Kali version
- Install Pwntools from PyPI
- Updated VS Code plugins
