# Changelog

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
