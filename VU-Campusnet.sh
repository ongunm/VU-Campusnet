#!/bin/bash

# Prompt for user part of VUnetID (before "@vu.nl")
read -p "Enter your VUnetID (the part before @vu.nl): " vunetid

# Prompt for password (silent input)
read -s -p "Enter your VUnetID password: " password
echo

nmcli connection add \
  type wifi \
  ifname wlp1s0 \
  con-name VU-Campusnet \
  ssid VU-Campusnet

nmcli connection modify VU-Campusnet \
  wifi-sec.key-mgmt wpa-eap \
  802-1x.eap ttls \
  802-1x.phase2-auth pap \
  802-1x.identity "${vunetid}@vu.nl" \
  802-1x.password "${password}" \
  802-1x.system-ca-certs no

nmcli connection up VU-Campusnet
