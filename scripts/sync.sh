#!/bin/bash


# ==============================================================================
#
# Simple script that checks if Syncthing is running by looking for the GUI IP.
#
# Make sure to add your own API key!
#
# ==============================================================================

gui_ip=$(curl -s -X GET -H "X-API-Key: <API key here>" http://localhost:8384/rest/system/status | jq --raw-output '.guiAddressUsed')

if !($gui_ip > /dev/null 2>&1); then
    echo $gui_ip
else
    echo "%{F#FBB86C}syncthing not running%{F-}"
fi
