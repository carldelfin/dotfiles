#!/bin/sh
API_key=$(grep apikey ~/.config/syncthing/config.xml | cut -d ">" -f2 | cut -d "<" -f1)
#curl -X POST -H "X-API-Key: $API_key" http://localhost:8384/rest/
curl -k -X POST -H "X-API-Key: $API_key" https://localhost:8384/rest/system/ping 
