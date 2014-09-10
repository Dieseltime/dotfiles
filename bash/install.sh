#!/usr/bin/env bash

dotfiles_profile="${HOME}/.dotfiles/bash/.profile.sh"

rm -rf .profile
rm -rf .bashrc

if ! grep -q "[[ -s \"$dotfiles_profile\" ]] && source \"$dotfiles_profile\"" "$HOME/.bash_profile"; then
  echo "[[ -s \"$dotfiles_profile\" ]] && source \"$dotfiles_profile\"" >> "$HOME/.bash_profile"
fi

touch "$HOME/.hushlogin"

if [ "$(uname -s)" == "Darwin" ]
then
  DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
  source "$DIR/.brew"
fi
