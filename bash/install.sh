#!/usr/bin/env bash

dotfiles_profile="${HOME}/.dotfiles/bash/.profile.sh"

rm -rf .profile
rm -rf .bashrc

if ! grep -q "[[ -s \"$dotfiles_profile\" ]] && source \"$dotfiles_profile\"" "$HOME/.bash_profile"; then
  echo "[[ -s \"$dotfiles_profile\" ]] && source \"$dotfiles_profile\"" >> "$HOME/.bash_profile"
fi

touch "$HOME/.hushlogin"

if ! which brew >/dev/null 2>&1; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" </dev/null
fi

if [ "$(uname -s)" == "Darwin" ]
then
  DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
  source "$DIR/.brew"
else
  sudo apt-get -y --force-yes install python-pip
  sudo pip install mackup
fi

ln -nfs "$HOME/.dotfiles/bash/.inputrc" "$HOME/.inputrc"