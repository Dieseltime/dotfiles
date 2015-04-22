#!/usr/bin/env bash

dotfiles_profile="${HOME}/.dotfiles/bash/.bashrc.sh"

rm -rf $HOME/.profile
rm -rf $HOME/.bash_profile && touch $HOME/.bash_profile
rm -rf $HOME/.bashrc && touch $HOME/.bashrc

echo "[[ -s \"$dotfiles_profile\" ]] && source \"$dotfiles_profile\"" >> "$HOME/.bash_profile"

touch "$HOME/.hushlogin"

if ! which brew >/dev/null 2>&1; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" </dev/null
fi

if [ "$(uname -s)" == "Linux" ]; then
  sudo apt-get -y --force-yes install python-pip
  sudo pip install mackup
fi

ln -nfs "$HOME/.dotfiles/bash/.inputrc" "$HOME/.inputrc"