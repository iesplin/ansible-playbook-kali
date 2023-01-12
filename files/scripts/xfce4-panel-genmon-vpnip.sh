#!/usr/bin/env bash
# Replacement script for the Kali xfce4-panel-genmon-vpnip.sh script
# Shows tun/tap interfaces and the current public IP address
#
# MIT License
#
# Copyright (c) 2023 iesplin
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE. 

TMPDIR="/tmp/ip-check-${USER}"
PUBLIC_IP_FILE="$TMPDIR/public-ip"
ROUTE_TABLE_FILE="$TMPDIR/route-table"

VPN_ACTIVE=false
ROUTES_CHANGED=false
VPN_IPS=""
PUBLIC_IP=""

# Create temp directory for storing data
create_temp_storage() {
  if [ ! -d $TMPDIR ]; then
    umask 077
    mkdir -p $TMPDIR
    touch $PUBLIC_IP_FILE
    touch $ROUTE_TABLE_FILE
  fi
}

# Enumerate all tun/tap interfaces for an IP address and add to the output string
check_tuntap_interfaces() {
  for IFACE in $(ip tuntap | cut -f1 -d':'); do
    STATE=$(cat /sys/class/net/${IFACE}/operstate 2>/dev/null)
    if [ "$STATE" = "up" -o "$STATE" = "unknown" ]; then
      IP=$(ip -4 addr show ${IFACE} | grep -o -P '(?<=inet )[0-9]{1,3}(\.[0-9]{1,3}){3}')
      if [ ! -z "$IP" ]; then
        VPN_ACTIVE=true
        VPN_IPS="${IFACE}: ${IP} | ${VPN_IPS}"
      fi
    fi
  done
}

# Check for changes to the route table
check_route_table() {
  umask 077
  ip route show table 0 > ${ROUTE_TABLE_FILE}.now
  if cmp -s -- "${ROUTE_TABLE_FILE}" "${ROUTE_TABLE_FILE}.now"; then
    rm "${ROUTE_TABLE_FILE}.now"
    ROUTES_CHANGED=false
  else
    mv "${ROUTE_TABLE_FILE}.now" "${ROUTE_TABLE_FILE}"
    ROUTES_CHANGED=true
  fi
}

# Get Public IP address. Fetch again if not known or route table has changed.
check_public_ip() {
  PUBLIC_IP=$(cat $PUBLIC_IP_FILE)

  if [ -z "$PUBLIC_IP" -o "$ROUTES_CHANGED" = true ]; then
    DIG_LOOKUPS=( "@1.1.1.1 whoami.cloudflare TXT CH +https" "@1.1.1.1 whoami.cloudflare TXT CH" "@ns1.google.com -o-o.myaddr.l.google.com TXT" "@resolver1.opendns.com myip.opendns.com ANY" )
    PUBLIC_IP_FETCHED=false
    DIG_OUTPUT=""

    for DIG_PARAM in "${DIG_LOOKUPS[@]}"; do
      DIG_OUTPUT=$(dig ${DIG_PARAM} -4 +short)
      if [ $? -eq 0 ]; then
	    PUBLIC_IP_FETCHED=true
        break
      fi
    done

    if [ "$PUBLIC_IP_FETCHED" = true ]; then
      PUBLIC_IP=$(echo $DIG_OUTPUT | tr -d '"')
    else
      PUBLIC_IP=""
    fi
    echo "$PUBLIC_IP" > $PUBLIC_IP_FILE
  fi
}

# Print output for genmon panel
print_output() {
  if [ -z "$PUBLIC_IP" ]; then
    PUBLIC_IP="unknown"
  fi
  
  if [ "$VPN_ACTIVE" = true ]; then
    printf "<icon>network-vpn-symbolic</icon>"
  fi
  printf "<txt>${VPN_IPS}Public: ${PUBLIC_IP}</txt>"
  printf "<tool>VPN IP</tool>"
}

main() {
  create_temp_storage
  check_tuntap_interfaces
  check_route_table
  check_public_ip
  print_output
}

main