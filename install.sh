#!/bin/sh
# install.sh - Installer for FreeBSD DNS Blocklists Blocker
# Author: Geovanni B.R. (geobarrod)
# Date: 2026-01-04

set -e

# Verify root privileges
if [ "$(id -u)" -ne 0 ]; then
  echo "ERROR: This installer must be run as root."
  exit 1
fi

# Paths
BIN_DIR="/root/bin"
RC_DIR="/usr/local/etc/rc.d"
SCRIPT_NAME="fbsd-dnsbl-blocker"
SERVICE_NAME="dnsbl_blocker"

echo "Installing FreeBSD DNS Blocklists Blocker..."

# Create /root/bin if it doesn't exist
if [ ! -d "$BIN_DIR" ]; then
  echo "Creating $BIN_DIR..."
  mkdir -p "$BIN_DIR"
fi

# Copy main script
echo "Copying $SCRIPT_NAME to $BIN_DIR..."
cp "$SCRIPT_NAME" "$BIN_DIR/"
chmod 755 "$BIN_DIR/$SCRIPT_NAME"

# Copy service script
echo "Copying $SERVICE_NAME to $RC_DIR..."
cp "$SERVICE_NAME" "$RC_DIR/"
chmod 755 "$RC_DIR/$SERVICE_NAME"

echo "Installation complete."
echo "You can now run: $BIN_DIR/$SCRIPT_NAME"
echo "And manage the service via: service $SERVICE_NAME start|stop|restart"
