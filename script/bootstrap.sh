#!/usr/bin/env bash

dotfiles_profile="${HOME}/.dotfiles/bash/.profile.sh"

# Load Functions
for functions in `find $HOME/.dotfiles -maxdepth 2 -name functions.sh`
do
  source $functions
done

source $HOME/.dotfiles/bash/.profile.sh

# Run installers
for installer in `find $HOME/.dotfiles -maxdepth 2 -name install.sh`
do
  source $installer
done

ruby $HOME/.dotfiles/atom.symlink/install.rb
