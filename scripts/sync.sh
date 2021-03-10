#!/bin/bash

# ==============================================================================
#
# This script checks if syncthing is running
#
# ==============================================================================

if !(curl -s http://127.0.0.1:8384/rest/system/ping | grep '{"ping":"pong"}' > /dev/null 2>&1); then
    echo "%{F#FBB86C}syncthing not running%{F-}"
else
    echo "%{F#D2D2D2}OK%{F-}"
fi
