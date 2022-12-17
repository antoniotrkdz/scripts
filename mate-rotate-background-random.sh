#!/bin/bash

if [ $# -eq 0 ] ; then
  echo 'Please enter the path of background folder'
  exit 1
else
  while true ; do
    # Create a list with image files only
    LIST=($(find "$1" -type f -exec file {} \; | grep -o -P '^.+(?=: \w+ image)'))
    LENGTH=${#LIST[@]}
    # echo 'orig list ' "${LIST[@]}"
    # echo 'orig len ' "$LENGTH"
    if [ $LENGTH -eq 0 ] ; then
      echo 'The path provided does not contain any image file'
      exit 1
    else
      while [ "$LENGTH" -gt 0 ] ; do
        R=$(( RANDOM % "$LENGTH" ))
        # echo 'rnd' "$R"
        # B=${LIST["$R"]}
        # echo 'selected' "$B"
        gsettings set org.mate.background picture-filename "${LIST[$R]}" #"$B"
        unset "LIST[$R]"
        LIST=(${LIST[@]})
        LENGTH=${#LIST[@]}
        # echo 'new list' "${LIST[@]}"
        # echo 'new len' "$LENGTH"
        if [ ! -z "$2" ] && [ "$2" -gt 0 ] ; then sleep "$2" ; else sleep 30 ; fi
      done
    fi
  done
fi
