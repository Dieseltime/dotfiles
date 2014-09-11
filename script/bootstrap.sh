#!/usr/bin/env bash

dotfiles_profile="${HOME}/.dotfiles/bash/.profile.sh"

bootstrap () {
  for installer in `find $HOME/.dotfiles -maxdepth 2 -name install.sh`
  do
    source $installer
  done

  ruby $HOME/.dotfiles/atom.symlink/install.rb
}

# Load Functions
for functions in `find $HOME/.dotfiles -maxdepth 2 -name functions.sh`
do
  echo "loading ${functions}"
  source $functions
done

# Append source files location to .profile.sh
for functions in `find ${HOME}/.dotfiles -maxdepth 2 -name functions.sh`
do
  if ! grep -q "[[ -s \"\$HOME/${functions}\" ]] && source \"\$HOME/${functions}\"" "${dotfiles_profile}" ; then
    echo "[[ -s \"\$HOME/${functions}\" ]] && source \"\$HOME/${functions}\"" >> "${dotfiles_profile}"
  fi
done

source $HOME/.dotfiles/bash/.profile.sh

bootstrap
