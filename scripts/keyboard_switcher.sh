#!/bin/sh

if xinput list | grep -q "floating"; then
    xinput reattach "AT Translated Set 2 keyboard" 3
else
    xinput float "AT Translated Set 2 keyboard"
fi
