#!/bin/bash

if [[ $XDG_CURRENT_DESKTOP = "MATE" ]] ; then

  if [[ $(gsettings get org.mate.peripherals-touchpad touchpad-enabled) = true ]] ; then
    echo "disabling tpad via gsettings"
    gsettings set org.mate.peripherals-touchpad touchpad-enabled false
    notify-send 'TouchPad disabled' 'Press "$mod+Shift+t" to enable' -i touchpad
  else
    echo "enabling tpad via gsettings"
    gsettings set org.mate.peripherals-touchpad touchpad-enabled true
    notify-send 'TouchPad enabled' -i touchpad
  fi

else

  TPAD=$(xinput | grep Synaptics | awk '{ if (match($0,/(=)([0-9][0-9])/,m)) print m[2] }')

  if [ $(xinput --list-props $TPAD | grep "Device Enabled" | cut -f3) -eq 1 ] ; then
      echo "disabling tpad via xinput"
      xinput --set-prop $TPAD "Device Enabled" 0;
      notify-send 'TouchPad disabled' 'Press "$mod+Shift+t" to enable' -i touchpad
  else
      echo "enabling tpad via xinput"
      xinput --set-prop $TPAD "Device Enabled" 1;
      notify-send 'TouchPad enabled' -i touchpad
  fi
fi

