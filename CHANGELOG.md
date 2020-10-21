# Changelog

## 2020.10.21

### Changed

- No more hard-coding the kali_user variable. Instead, automatically set it to the user that ran the playbook.
- Cleaned up configuration to be less awful.

## 2020.10.13

### Changed

- John: create symlink for john so that is is found in the user's path.
- xfwm: Revert vblank_mode change as there is still some occassional flickering.

## 2020.10.12

### Changed

- xfwm: use default vblank_mode

## 2020.09.24

### Changed:

- WireGuard: use systemd-resolvectl as an alternative for resolvconf. - (https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=939904)

## 2020.09.24

### Changed:

- Rebased on the kali-linux-default metapackage. Default install has been trimmed down enough to not care about the extra packages I don't use.
- Removed Gnome configuration. No longer used after switching to XFCE.
- Removed git repositories that were rarely used.
- Updated default profile creation for Firefox ESR.
- Add missing dependencies for Evil-WinRM.
- Install CrackMapExec from PyPI as it is more recent than the Kali version.
- Install Pwntools from PyPI.
- Updated VS Code plugins.
