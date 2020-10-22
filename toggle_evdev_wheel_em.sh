#!/bin/bash

# Format:
# [Name of device]="(first digit) wheel emulation button (remainder of digits) button mapping"
declare -A POINTERS=(
  [Barcode Reader  Mouse]="2 3 2 1"
  [Clearly Superior Technologies. CST Laser Trackball]="3 1 2 3 4 5 6 7"
  [Contour Design, inc. Contour Receiver Mouse]="2 1 2 3 4 5 6 7"
)

for P in "${!POINTERS[@]}" ; do
  # Makes an array of the value
  declare -a ARR=(${POINTERS[$P]})
  # echo "$P: ""$(xinput --list-props "$P" | awk -F'[:]' '/Evdev Wheel Emulation Button \(/{print strtonum($2)}')" 
  # echo Full array: "${ARR[@]}"
  CUR_WE_BTN=$(xinput --list-props "$P" | awk -F'[:]' '/Evdev Wheel Emulation Button \(/{print strtonum($2)}')
  NEW_WE_BTN=$((CUR_WE_BTN - ARR[0])) # was NEW_WE_BTN=$((CUR_WE_BTN - ${POINTERS[$P]}))
  # echo New button: ${NEW_WE_BTN#-}
  xinput --set-prop "$P" 'Evdev Wheel Emulation Button' ${NEW_WE_BTN#-}
  if [ ${NEW_WE_BTN#-} -eq 0 ] ; then
    xinput set-button-map "$(xinput | awk -F'[=]' /"$P"/'{print $2}' | awk '{print $1}')" 0 0 0
    # echo ZEROED!
  else
    xinput set-button-map "$(xinput | awk -F'[=]' /"$P"/'{print $2}' | awk '{print $1}')" "${ARR[@]:1}"
    # echo Sub array: "${ARR[@]:1}"
  fi
done

### OLD VERSION ###
# ! reverts the value of field.
# WE_STATUS_MT=$(xinput --list-props 'Barcode Reader  Mouse' | awk -F'[:]' '/Evdev Wheel Emulation \(/{print !$2}')

# strtonum(field) translate a string to a number. 
#WE_BTN_MT=$(xinput --list-props 'Barcode Reader  Mouse' | awk -F'[:]' '/Evdev Wheel Emulation Button \(/ {print strtonum($2)}')
#WE_BTN_CST=$(xinput --list-props 'Clearly Superior Technologies. CST Laser Trackball' | awk -F'[:]' '/Evdev Wheel Emulation Button \(/ {print strtonum($2)}')
#WE_BTN_RED=$(xinput --list-props 'Contour Design, inc. Contour Receiver Mouse' | awk -F'[:]' '/Evdev Wheel Emulation Button \(/ {print strtonum($2)}')

#echo "MT button: $WE_BTN_MT"
#echo "CST button: $WE_BTN_CST"
#echo "RED button: $WE_BTN_RED"

##This device has 'wheel emulation button' 0 (auto) on X startup -> /usr/share/X11/xorg.conf.d/50-mouse-trak-evdev.conf
#if [ "$WE_BTN_MT" -eq 0 ] ; then
#  xinput set-button-map "$(xinput | awk -F'[=]' '/Barcode Reader  Mouse/ {print $2}' | awk '{print $1}')" 3 2 1 4 5 6 7
#  xinput --set-prop 'Barcode Reader  Mouse' 'Evdev Wheel Emulation Button' 2
#else
#  xinput --set-prop 'Barcode Reader  Mouse' 'Evdev Wheel Emulation Button' 0
#  xinput set-button-map "$(xinput | awk -F'[=]' '/Barcode Reader  Mouse/ {print $2}' | awk '{print $1}')" 0 0 0
#fi

##This device has 'wheel emulation button' 3 on X startup -> /usr/share/X11/xorg.conf.d/50-cst-scroll.conf
#if [ "$WE_BTN_CST" -eq 0 ] ; then
#  xinput set-button-map "$(xinput | awk -F'[=]' '/Clearly Superior Technologies. CST Laser Trackball/ {print $2}' | awk '{print $1}')" 1 2 3 4 5 6 7
#  xinput --set-prop 'Clearly Superior Technologies. CST Laser Trackball' 'Evdev Wheel Emulation Button' 3
#else
#  xinput --set-prop 'Clearly Superior Technologies. CST Laser Trackball' 'Evdev Wheel Emulation Button' 0
#  xinput set-button-map "$(xinput | awk -F'[=]' '/Clearly Superior Technologies. CST Laser Trackball/ {print $2}' | awk '{print $1}')" 0 0 0
#fi

##This device has 'wheel emulation button' 3 on X startup -> /usr/share/X11/xorg.conf.d/50-contour-red-scroll.conf
#if [ "$WE_BTN_RED" -eq 0 ] ; then
#  xinput set-button-map "$(xinput | awk -F'[=]' '/Contour Design, inc. Contour Receiver Mouse/ {print $2}' | awk '{print $1}')" 1 2 3 4 5 6 7
#  xinput --set-prop 'Contour Design, inc. Contour Receiver Mouse' 'Evdev Wheel Emulation Button' 2
#else
#  xinput --set-prop 'Contour Design, inc. Contour Receiver Mouse' 'Evdev Wheel Emulation Button' 0
#  xinput set-button-map "$(xinput | awk -F'[=]' '/Contour Design, inc. Contour Receiver Mouse/ {print $2}' | awk '{print $1}')" 0 0 0
#fi
