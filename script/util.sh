#!/usr/bin/env bash

exists () {
  command -v "$1" &>/dev/null ;
}

ohai () {
  green='\033[0;32m'
  NC='\033[0m'
  echo -e "\n"
  echo -e "${green}$1${NC}"
  echo -e "${green}-------------------------------------------${NC}"
}