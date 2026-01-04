# FreeBSD DNS Blocklists Blocker

## Purpose
Downloads multiple external DNS blocklists (ads, tracking, malware, fake news, gambling, etc.), merges them, and loads them into `/etc/hosts` for automatic blocking of unwanted domains.
It ensures localhost and system entries remain intact and restarts local DNS/proxy services after updates.

---

## Usage
```sh
sudo fbsd-dnsbl-blocker {daemon|update|list|restore}
```

## Options
- daemon → Run continuously, updating blocklists every 24 hours.
- update → Perform a one-time update of blocklists and reload `/etc/hosts`.
- list → Show the current blocklist and count of domains.
- restore → Restore the most recent `/etc/hosts` backup.

---

## Configuration Variables
You can override these defaults by editing the script:

| Variable        | Default                  | Description                                      |
|-----------------|--------------------------|--------------------------------------------------|
| SYSCONF_DIR     | /etc                     | Directory containing system configuration files  |
| DNS_FILE        | hosts                    | Target hosts file                                |
| BACKUP_DIR      | /etc                     | Directory for hosts backups                      |
| TMP_FILE        | /tmp/hosts.tmp           | Temporary file used during updates               |
| DNSBL_FILE      | /tmp/hosts.bls           | Temporary merged blocklist file                  |
| URLS            | (list of DNSBL feeds)    | External DNSBL sources                           |

---

## Features
- Downloads multiple DNSBL sources (StevenBlack, anudeepND, DeveloperDan).
- Extracts domains mapped to `0.0.0.0` and merges them.
- Ensures localhost and IPv6 loopback entries remain intact.
- Adds system hostname and broadcast address to `/etc/hosts`.
- Creates timestamped backups before replacement.
- Provides restore option to recover the last backup.
- Provides daemon mode for daily refresh.
- Restarts local DNS, proxy and MTA services after update (`unbound`, `dnsmasq`, `squid`, `postfix`).

---

## Requirements
- FreeBSD system with root privileges.  
- Utilities: bash, fetch, grep, sort, uniq, sed, hostname, ifconfig.  
- Services like `local_unbound`, `dnsmasq`, `squid`, `postfix` installed if restart is desired.  

---

## Example
Run in daemon mode:
```sh
sudo fbsd-dnsbl-blocker daemon
```

Perform a one-time update:
```sh
sudo fbsd-dnsbl-blocker update
```

List blocked domains:
```sh
sudo fbsd-dnsbl-blocker list
```

Restore last hosts backup:
```sh
sudo fbsd-dnsbl-blocker restore
```

---

## Installation
Clone the repository and run the installer:
```sh
git clone https://github.com/geobarrod/FBSD-DNSBL-Blocker.git
cd fbsd-dnsbl-blocker
sudo make install
```

---

## Uninstallation
To remove the fbsd-dnsbl-blocker and service:
```sh
cd fbsd-dnsbl-blocker
sudo make uninstall
```

---

## Changelog

### v1.0 — 2026-01-04
- Initial release of fbsd-dnsbl-blocker.
- Features:
  - Merging multiple DNSBL feeds into `/etc/hosts`.
  - Backup and restore of hosts file.
  - Daemon mode for daily refresh.
  - rc.d service integration (dnsbl_blocker).
  - Automatic restart of local DNS, proxy and MTA services after update.
