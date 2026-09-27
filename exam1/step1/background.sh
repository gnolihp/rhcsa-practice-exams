#!/bin/bash
apt-get update
apt-get install -y network-manager hostname
systemctl start NetworkManager
