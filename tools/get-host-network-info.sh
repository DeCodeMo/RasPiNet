#!/bin/bash

##############################################################################################
#Author:       GDCosmo
#Date Created: October 20, 2021
#Description:  Gets basic host network info and outputs to a config file
###############################################################################################


RED="\033[1;31m"
GREEN="\033[1;32m"
BLUE="\033[1;36m"
YELLOW="\033[1;33m"
RESET="\033[0m"
BAN="${BLUE}[raspinet]${RESET}"

# header message
header-msg(){
    echo -e "${BAN} ----- $1 -----"
}
# status message
status-msg(){
    echo -e "${BAN} ${YELLOW} $1 ${RESET}"
}
# banner message
banner-msg(){
    echo -e "${BAN} ${GREEN} $1 ${RESET}"
}
# error message
error-msg(){
    echo -e "${BAN} ${RED} $1 ${RESET}"
}

# make sure the script is run from the RasPiNet directory
if [ "$(basename "$(pwd)")" == "RasPiNet" ]; then
    PROJDIR="$(pwd)"
else
    error-msg "Please run this script from the RasPiNet directory"
    exit 1
fi

# set the initial state of the interfaces
ETH_IS_UP=0
WIFI_IS_UP=0

# initial default network info for the host
DEF_IFACE="none"
DEF_IP="none"
DEF_GATEWAY="none"
DEF_NETMASK="none"
DEF_MAC="none"
DEF_NETWORK_RANGE="none"

# get the active interface names
get-iface(){
    if [ "$1" == "Wifi" ]; then
        ifconfig -a | grep -o -w 'wl[[:alnum:]]*'
    elif [ "$1" == "Ethernet" ]; then
        ifconfig -a | grep -o -w 'en[[:alnum:]]*'
    else
        error-msg "No interface selected"
    fi
}

# get the IP address of the active interface
get-ip-adddress(){
    if [ "$1" == "Wifi" ]; then
        ifconfig "$WIFI_IFACE" | grep -o -w 'inet [0-9.]*' | grep -o -w '[0-9.]*'
    elif [ "$1" == "Ethernet" ]; then
        ifconfig "$ETH_IFACE" | grep -o -w 'inet [0-9.]*' | grep -o -w '[0-9.]*'
    else
        error-msg "No interface selected"
    fi
}

# get the gateway of the active interface
get-gateway(){
    if [ "$1" == "Wifi" ]; then
        ip route | grep -o -w 'default via [0-9.]*' | grep -o -w '[0-9.]*' | head -n 1
    elif [ "$1" == "Ethernet" ]; then
        ip route | grep -o -w 'default via [0-9.]*' | grep -o -w '[0-9.]*' | tail -n 1
    else
        error-msg "No interface selected"
    fi
}

# get the netmask of the active interface
get-netmask(){
    if [ "$1" == "Wifi" ]; then
        ifconfig "$WIFI_IFACE" | grep -w inet | awk '{print $4}'
    elif [ "$1" == "Ethernet" ]; then
        ifconfig "$ETH_IFACE" | grep -w inet | awk '{print $4}'
    else
        error-msg "No interface selected"
    fi
}

# get the MAC address of the active interface
get-mac-address(){
    if [ "$1" == "Wifi" ]; then
        ifconfig "$WIFI_IFACE" | grep -w ether | awk '{print $2}'
    elif [ "$1" == "Ethernet" ]; then
        ifconfig "$ETH_IFACE" | grep -w ether | awk '{print $2}'
    else
        error-msg "No interface selected"
    fi
}

# get the network range of the active interface
get-network-range() {
    if [ "$1" == "Wifi" ]; then
        ipcalc "$WIFI_IP" | grep -w Network | awk '{print $2}'
    elif [ "$1" == "Ethernet" ]; then
        ipcalc "$ETH_IP" | grep -w Network | awk '{print $2}'
    else
        error-msg "No interface selected"
    fi
}

# get the interface names
WIFI_IFACE=$(get-iface "Wifi")
ETH_IFACE=$(get-iface "Ethernet")

# get the state of the interfaces
ETH_STATE=$(cat /sys/class/net/"$ETH_IFACE"/operstate)
WIFI_STATE=$(cat /sys/class/net/"$WIFI_IFACE"/operstate)

# get the IP addresses
WIFI_IP=$(get-ip-adddress "Wifi")
ETH_IP=$(get-ip-adddress "Ethernet")

# get the gateway
WIFI_GATEWAY=$(get-gateway "Wifi")
ETH_GATEWAY=$(get-gateway "Ethernet")

# get the netmask
WIFI_NETMASK=$(get-netmask "Wifi")
ETH_NETMASK=$(get-netmask "Ethernet")

# get the mac address
WIFI_MAC=$(get-mac-address "Wifi")
ETH_MAC=$(get-mac-address "Ethernet")

# get the network range in CIDR notation (e.g. 192.68.0.1/24)
WIFI_NETWORK_RANGE=$(get-network-range "Wifi")
ETH_NETWORK_RANGE=$(get-network-range "Ethernet")

# set ethernet state
if [ "$ETH_STATE" == "up" ]; then
    banner-msg "Ethernet is up"
    ETH_IS_UP=1
fi

# set wifi state
if [ "$WIFI_STATE" == "up" ]; then
    banner-msg "Wifi is up"
    WIFI_IS_UP=1
fi

# if ethernet is up, set it as the default interface
if [ "$ETH_IS_UP" == 1 ]; then
    DEF_IFACE="$ETH_IFACE"
    DEF_IP="$ETH_IP"
    DEF_GATEWAY="$ETH_GATEWAY"
    DEF_NETMASK="$ETH_NETMASK"
    DEF_MAC="$ETH_MAC"
    DEF_NETWORK_RANGE="$ETH_NETWORK_RANGE"
fi

# if ethernet is down and wifi is up, set it as the default interface
if [ "$ETH_IS_UP" == 0 ] && [ "$WIFI_IS_UP" == 1 ]; then
    DEF_IFACE="$WIFI_IFACE"
    DEF_IP="$WIFI_IP"
    DEF_GATEWAY="$WIFI_GATEWAY"
    DEF_NETMASK="$WIFI_NETMASK"
    DEF_MAC="$WIFI_MAC"
    DEF_NETWORK_RANGE="$WIFI_NETWORK_RANGE"
fi

# if both interfaces are down, throw a warning
if [ "$ETH_IS_UP" == 0 ] && [ "$WIFI_IS_UP" == 0 ]; then
    error-msg "Warning, no active network interfaces found."
fi

# check default interface and throw a warning if none is set
if [ "$DEF_IFACE" == "none" ]; then
    error-msg "Warning, no default interface set."
else
    banner-msg "Default interface set to $DEF_IFACE"
fi

# Generate the config file for the network manager 
get-config-file(){
cat << EOF
# This file is auto-generated
# Author: GDCosmo
# Date: $(date)

# default
[Host]
host-iface $DEF_IFACE
host-ip $DEF_IP
host-gateway $DEF_GATEWAY
host-netmask $DEF_NETMASK
host-mac $DEF_MAC
host-cidr $DEF_NETWORK_RANGE

[Wifi]
wifi-state $WIFI_IS_UP
wifi-iface $WIFI_IFACE
wifi-ip $WIFI_IP
wifi-gateway $WIFI_GATEWAY
wifi-netmask $WIFI_NETMASK
wifi-cidr $WIFI_NETWORK_RANGE

[Ethernet]
eth-state $ETH_IS_UP
eth-iface $ETH_IFACE
eth-ip $ETH_IP
eth-gateway $ETH_GATEWAY
eth-netmask $ETH_NETMASK
eth-cidr $ETH_NETWORK_RANGE
EOF
}

status-msg "Generating config file..."

mkdir -p "$PROJDIR"/config

get-config-file > "$PROJDIR"/config/host-network.conf

banner-msg "Network manager config file generated"















