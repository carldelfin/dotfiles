#!/bin/bash

# ==============================================================================
#
# Simple script that checks if Syncthing is running by looking for the GUI IP.
# Left clicking (in Polybar) opens the GUI in Firefox.
#
# Make sure to add your own API key!
#
# ==============================================================================

gui_ip=$(curl -s -X GET -H "X-API-Key: <API key here>" http://localhost:8384/rest/system/status | jq --raw-output '.guiAddressUsed')

check_status() {
  if [ "$gui_ip" = "127.0.0.1:8384" ]; then
    echo $gui_ip
  else
    echo "%{F#FBB86C}no sync%{F-}"
  fi
}

open_browser() {
  firefox http://localhost:8384
}

case "$1" in
	--open-browser) open_browser ;;
	*) check_status ;;
esac
