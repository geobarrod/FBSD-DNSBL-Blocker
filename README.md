# FBSD-DNSBL-Blocker
Downloads multiple external DNS blocklists (ads, tracking, malware, fake news, gambling, etc.), merges them, and loads them into `/etc/hosts` for automatic blocking of unwanted domains. It ensures localhost and system entries remain intact and restarts local DNS/proxy services after updates.
