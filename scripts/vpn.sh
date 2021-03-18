#!/bin/bash

# ==============================================================================
#
# This script checks the status of my VPN connection, and makes it possible
# to toggle on and off using polybar.
#
# It is more or less just a slimmed down and slightly modified version of 
# vpn_module.sh by Shervin S. (shervin@tuta.io):
#
# https://github.com/shervinsahba/polybar-vpn-controller
#
# ==============================================================================

vpn_status=$(mullvad status | cut -d' ' -f3)
ip_address=$(mullvad status | awk 'match($0,/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/){print substr($0,RSTART,RLENGTH)}')
protocol=$(mullvad status | awk '{for(i=1;i<=NF;i++)if($i=="to")print $(i+1)}')

vpn_report() {
	if [ "$vpn_status" = "Connected" ]; then
		echo "%{F#D2D2D2}$ip_address ($protocol)%{F-}"
	elif [ "$vpn_status" = "Connecting" ]; then
		echo "%{F#D2D2D2}connecting...%{F-}"
	else
		echo "%{F#A0520B}vpn off%{F-}"
	fi
}

vpn_toggle_connection() {
  if [ "$vpn_status" = "Connected" ]; then
      mullvad disconnect
  else
      mullvad connect
  fi
}

case "$1" in
	--toggle-connection) vpn_toggle_connection ;;
	*) vpn_report ;;
esac
