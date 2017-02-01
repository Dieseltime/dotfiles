#!/usr/bin/env bash

source "${HOME}/.dotfiles/bash/colors.sh"

is_osx? () {
  [ "$(uname -s)" == "Darwin" ]
}

is_linux? () {
  [ "$(uname -s)" == "Linux" ]
}

##
# Bash functions

start_timer () {
  export SECONDS=0
}

stop_timer () {
  local elapsed=$SECONDS
  ohai "done" "Finished in $(print_elapsed $elapsed)"
  export SECONDS=0
}

print_elapsed_short () {
  local T=$1
  local H=$((T/60/60%24))
  local M=$((T/60%60))
  local S=$((T%60))
  (( $H > 0 )) && printf '%02d:' $H
  printf '%02d:' $M
  printf '%02d' $S
}

print_elapsed () {
  local T=$1
  local H=$((T/60/60%24))
  local M=$((T/60%60))
  local S=$((T%60))
  (( $H > 0 )) && printf '%d hours ' $H
  (( $M > 0 )) && printf '%d minutes ' $M
  (( $H > 0 || $M > 0 )) && printf 'and '
  printf '%d seconds' $S
}

comment_file () {
  sed -i -e 's/^/#/' $1
}

uncomment_file () {
  sed -i -e 's/^#//' $1
}

quietly () {
  $@ 2>&1 >/dev/null
}

silently () {
  echo "${@}"
  $@ 2>&1 >/dev/null
}

ohai_silently () {
  ohai
}

verbosely () {
  echo "${@}"
  $@
}

extract () {
  if [ -f $1 ] ; then
    case $1 in
    *.tar.bz2) tar xvjf $1;;
    *.tar.gz) tar xvzf $1;;
    *.bz2) bunzip2 $1;;
    *.rar) unrar x $1;;
    *.gz) gunzip $1;;
    *.tar) tar xvf $1;;
    *.tbz2) tar xvjf $1;;
    *.tgz) tar xvzf $1;;
    *.zip) unzip $1;;
    *.Z) uncompress $1;;
    *.7z) 7z x $1;;
    *) echo "'$1' cannot be extracted via extract";;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

ohai () {
  if (( $# < 2 )); then
    local tag="${FUNCNAME[1]}"
    local msg="${1}"
  else
    local tag="${1}"
    local msg="${2}"
  fi
  printf "[ ${txtylw}${tag}${txtwht} ] ${txtgrn}$msg${txtwht}\n"
}

ohai_time () {
  local elapsed=$SECONDS
  ohai "$(print_elapsed_short $elapsed)" "${1}"
}

ohno () {
  printf "\r\033[2K[ ${txtylw}${FUNCNAME[1]}${txtwht}: \033[0;31mFAIL\033[0m ] $1\n"
}

pardonme () {
  printf "\r[ ${txtylw}${FUNCNAME[1]}${txtwht}: \033[0;33m?\033[0m ] $1 "
}

reload_profile () {
  ohai "Reloading ~/.bashrc ..."
  source ~/.bashrc
  ohai "Reloading ~/.bash_profile ..."
  source ~/.bash_profile
}

remote_bootstrap () {
  _ssh=$1
  _args=$2
  remote_cmd="rm -rf .dotfiles .bashrc .bash_profile; touch .bash_profile; tar mx -C ~/; source .dotfiles/bash/.bashrc.sh; bootstrap"
  tar c -C${HOME} --exclude='.git' .dotfiles .ssh/id_rsa .ssh/id_rsa.pub | $_ssh $_args $remote_cmd
}

clean_home () {
  shopt -s dotglob
  rm -rf ./*
  shopt -u dotglob
}

rsyslog () {
  ssh $1 sudo tail -f /var/log/syslog
}

# Copy string or contents of a file to the clipboard
# Can also accept input from a pipe
#
# Examples:
#
#   echo "Tyler Durden" | cpy
#   cpy /path/to/file.txt
#
cpy () {

  if [ $# -eq 0 ]; then
    read result
  else
    result=$1
  fi

  if [ -f $result ]; then
    content=`cat $result`
  else
    content=$result
  fi

  if [ ! -z $content ]; then
    echo $content
    echo $content | tr -d '\n' | pbcopy
    echo "Copied to clipboard!"
  else
    echo "${FUNCNAME[0]}: no content supplied"; exit 1;
  fi
}

# Create a directory and cd into it
mkdir() {
  command mkdir -pv "$@"
  cd $_
}

##
# Flatten a directory structure
#
# Example:
#
#   flatten /foo
#
# Which will create /foo-flattened
flatten () {
  target=${1%/}-flattened
  mkdir -p $target
  find $1 -exec cp \{\} $target \;
}
