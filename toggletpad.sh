#!/bin/bash

TPAD=$(xinput | grep TouchPad | awk '{ if (match($0,/[0-9][0-9]/,m)) print m[0] }')

if [ $(xinput --list-props $TPAD | grep "Device Enabled" | cut -f3) -eq 1 ]; then
    echo "disabling tpad"
    xinput --set-prop $TPAD "Device Enabled" 0;
    notify-send 'TouchPad disabled' 'Press "$mod+Shift+t" to enable' -i touchpad
else
    echo "enabling tpad"
    xinput --set-prop $TPAD "Device Enabled" 1;
    notify-send 'TouchPad enabled' -i touchpad
fi
