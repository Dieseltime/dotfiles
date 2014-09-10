##
# Bash functions

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
  printf "[ ${txtylw}${FUNCNAME[1]}${txtwht} ] ${txtgrn}$1${txtwht}\n"
}

ohno () {
  printf "\r\033[2K[ ${txtylw}${FUNCNAME[1]}${txtwht}: \033[0;31mFAIL\033[0m ] $1\n"
}

pardonme () {
  printf "\r[ ${txtylw}${FUNCNAME[1]}${txtwht}: \033[0;33m?\033[0m ] $1 "
}

reload_profile () {
  ohai "Reloading ~/.bash_profile ..."
  source ~/.bash_profile
}

remote_bootstrap () {
  _ssh=$1
  _args=$2
  remote_cmd="rm -rf .dotfiles .bashrc .bash_profile; touch .bash_profile; tar mx -C ~/; source .dotfiles/bash/.profile.sh; bootstrap"
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
