#!/bin/bash

while true; do
    find "$1" -type f | while read -r B; do
      if [ "${B: -4}" != ".xml" ] ; then
        gsettings set org.mate.background picture-filename "$B";
      fi
      sleep 15;
    done;
done;

