#!/usr/bin/env bash

file "$1" | grep -q "text"

if [ $? -ne 0 ]; then
  /usr/bin/open $1
else
  if [[ -z "$2" ]]; then
    FILE_PATH="$1"
  else
    FILE_PATH="$1:$2"
  fi
  $HOME/bin/code -g -r $FILE_PATH
fi
