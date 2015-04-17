# Add ssh key on while on a remote machine.
copy_keys () {
  KEY=`cat $HOME/.ssh/id_rsa.pub`

  if [ -z "$(grep "$KEY" $HOME/.ssh/authorized_keys 2>/dev/null)" ]; then
    echo $KEY >> $HOME/.ssh/authorized_keys
  fi
}

setup_ssh_config () {
  if [ ! -s $HOME/.ssh/config ]; then
    while true; do
      pardonme "It looks like we need to setup your ssh config. Want to do that now? [y/n]"
      read action
      case $action in
        [yY] | [yY][Ee][Ss] )
          ohai "Sounds good"
          break;;
        [nN] | [nN][oO] )
          ohai "Well fuck you then"
          return;;
        * )
          ;;
      esac
    done
  fi
}

screen_ssh() {
  numargs=$#
  screen -t ${!numargs} ssh $@
}
if [ $TERM == "screen" -o $TERM == "screen.linux" ]; then
  alias ssh=screen_ssh
fi
