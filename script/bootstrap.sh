#!/usr/bin/env bash

touch "$HOME/.bash_profile"
touch "$HOME/.bashrc"

# Load Functions
for functions in `find $HOME/.dotfiles -maxdepth 2 -name functions.sh`
do
  echo "Loading $functions"
  source $functions
done

echo -e "\nLoading .bashrc\n"
source $HOME/.dotfiles/bash/.bashrc.sh

# Run installers
for installer in `find $HOME/.dotfiles -maxdepth 2 -name install.sh`
do
  echo "Running $installer"
  source $installer
done