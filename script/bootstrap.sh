#!/usr/bin/env bash

# Temporarily disable direnv
sed -e '/direnv/ s/^#*/#/' -i "$HOME/.dotfiles/bash/.bashrc.sh" >/dev/null 2>&1

touch "$HOME/.bash_profile"
touch "$HOME/.bashrc"

# Load Functions
for functions in `find $HOME/.dotfiles -maxdepth 2 -name functions.sh`
do
  echo "Loading $functions"
  source $functions
done

# Run installers
for installer in `find $HOME/.dotfiles -maxdepth 2 -name install.sh`
do
  echo "Running $installer"
  source $installer
done

sed -e '/direnv/ s/^#*//' -i "$HOME/.dotfiles/bash/.bashrc.sh" >/dev/null 2>&1

echo -e "\nLoading .bashrc\n"
source $HOME/.dotfiles/bash/.bashrc.sh

echo "Done. Fuck you."