#!/bin/sh

vpn_status=$(mullvad status | cut -d' ' -f3)
ip_address=$(mullvad status | awk 'match($0,/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/){print substr($0,RSTART,RLENGTH)}')
protocol=$(mullvad status | awk '{for(i=1;i<=NF;i++)if($i=="to")print $(i+1)}')

vpn_report() {
    if [ "$vpn_status" = "Connected" ]; then
        echo "%{F#eceff4}%{F-}"
	else
		echo "%{F#ebcb8b}%{F-}"
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
