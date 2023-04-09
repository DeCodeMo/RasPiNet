#!/bin/bash

##############################################################################################
#Author:       GDCosmo
#Date Created: April 7, 2023
#Description:  Clear all config files
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

CONFDIR="${PROJDIR}/config"

# clear all config files
clear-host-network-conf(){
cat << EOF > ${CONFDIR}/host-network.conf
# This file is auto-generated
# Author: GDCosmo
# Date: none

# default 
[Host]
host-iface none
host-ip none
host-gateway none
host-netmask none
host-mac none
host-cidr none

[Wifi]
wifi-state none
iface none
wifi-ip none
wifi-gateway none
wifi-netmask none
wifi-cidr none

[Ethernet]
eth-state none
eth-iface none
eth-ip none
eth-gateway none
eth-netmask none
eth-cidr none
EOF
}

# clear all config files
banner-msg "Clearing config files..."

status-msg "Clearing host-network.conf..."
clear-host-network-conf

banner-msg "All config files cleared"

# check the config file and make sure it is empty
# use an array to store the config files

HOSTCONF_FILE="host-network.conf"
HOSTCONF_STATE=$(cat ${CONFDIR}/${HOSTCONF_FILE} | grep "Date:" | awk '{print $3}')

if [ ${HOSTCONF_STATE} == "non" ]; then
    banner-msg "Config file ${HOSTCONF_FILE} is cleared"
else
    error-msg "Config file ${HOSTCONF_FILE} is not cleared"
    exit 1
fi

exit 0