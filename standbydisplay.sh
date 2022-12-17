#!/bin/bash
SCREENOFFLOCKFILE=/tmp/screen-off-lock

if [ -f $SCREENOFFLOCKFILE ]; then
  rm $SCREENOFFLOCKFILE
  # notify-send "Screen on." -i /usr/share/icons/gnome/48x48/devices/display.png
else
  touch $SCREENOFFLOCKFILE
  sleep .5
  while [ -f  $SCREENOFFLOCKFILE ]
  do
    xset dpms force off
    sleep 2
  done
  xset dpms force on
fi


# if [ -t 0 ]; then
#   SAVED_STTY="`stty --save`"
#   stty -echo -icanon -icrnl time 0 min 0
# fi

# count=0
# keypress=''
# while [ "x$keypress" = "x" ]; do
#   sleep 1
#   let count+=1
#   echo -ne $count'\r'
#   keypress="`cat -v`"
# done

# if [ -t 0 ]; then stty "$SAVED_STTY"; fi

# echo "You pressed '$keypress' after $count loop iterations"
# echo "Thanks for using this script."
# exit 0
