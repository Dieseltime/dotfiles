#!/usr/bin/env bash

dotfiles_profile="${HOME}/.dotfiles/bash/.bashrc.sh"

rm -rf $HOME/.profile
rm -rf $HOME/.bash_profile && touch $HOME/.bash_profile
rm -rf $HOME/.bashrc && touch $HOME/.bashrc

echo "[[ -s \"$dotfiles_profile\" ]] && source \"$dotfiles_profile\"" >> "$HOME/.bash_profile"

touch "$HOME/.hushlogin"

if is_linux? ; then
  sudo apt-get -qq -y --force-yes install python-pip
  sudo pip install --quiet --upgrade mackup
fi

ln -nfs "$HOME/.dotfiles/bash/.inputrc" "$HOME/.inputrc"