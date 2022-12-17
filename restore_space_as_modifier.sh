#!/bin/bash
## Script to run Xmodmap mods (space as modifier, for i3 purposes)
## upon plugging of usb keyboard
## Now working with usb to ps2 adapter (with keyboard downstream)

## See /etc/udev/rules.d/90-usb-keyboard.rules
## Modify it to add mre keyboard models

# LOG_FILE=$HOME/usb-kbd.log

apply_xmodmap () {
  /usr/bin/xmodmap -e "keycode 65=Super_L"
  /usr/bin/xmodmap -e "keycode any=space"
  /usr/bin/pkill xcape
  /usr/bin/xcape -e "Super_L=space"
}

if [ -d /dev/input/ext_usb ] ; then
  while true ; do

    EVENT=$(inotifywait -q -e create -e delete --exclude '.*tmp.*' /dev/input/ext_usb/)
  
    if echo "$EVENT" | grep -qe CREATE ; then
      apply_xmodmap
    fi

  done
fi
