#!/bin/bash

# 1. Check Hostname
CURRENT_HOST=$(hostname)
if [ "$CURRENT_HOST" != "rhel-node1.example.com" ]; then
  echo "Hostname is incorrect."
  exit 1
fi

# 2. Check if the connection profile exists
if ! nmcli con show "rhcsa-exam" > /dev/null 2>&1; then
  echo "Connection profile 'rhcsa-exam' not found."
  exit 1
fi

# 3. Check DNS settings
DNS=$(nmcli -g ipv4.dns con show "rhcsa-exam")
if [[ "$DNS" != *"8.8.8.8"* ]]; then
  echo "DNS is not set to 8.8.8.8."
  exit 1
fi

# 4. Check Search Domain
DOMAIN=$(nmcli -g ipv4.dns-search con show "rhcsa-exam")
if [[ "$DOMAIN" != *"example.local"* ]]; then
  echo "Search domain is incorrect."
  exit 1
fi

# 5. Check IP Address host ID
IP_ADDR=$(nmcli -g ipv4.addresses con show "rhcsa-exam")
if [[ "$IP_ADDR" != *".50/24"* ]]; then
  echo "IP address is incorrect or missing /24 subnet."
  exit 1
fi

echo "Task completed successfully!"
exit 0
