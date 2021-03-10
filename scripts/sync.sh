#!/bin/bash
if !(curl -s http://127.0.0.1:8384/rest/system/ping | grep '{"ping":"pong"}' > /dev/null 2>&1); then
    echo "syncthing not running"
else
    echo "syncthing running"
fi
