#!/usr/bin/env bash

dotfiles_profile="${HOME}/.dotfiles/bash/.profile.sh"

touch "$HOME/.bash_profile"

# Load Functions
for functions in `find $HOME/.dotfiles -maxdepth 2 -name functions.sh`
do
  echo "Loading $functions"
  source $functions
done

echo "Loading .bash_profile"
source $HOME/.dotfiles/bash/.profile.sh

# Run installers
for installer in `find $HOME/.dotfiles -maxdepth 2 -name install.sh`
do
  echo "Installing $installer"
  source $installer
done

ruby $HOME/.dotfiles/atom.symlink/install.rb
