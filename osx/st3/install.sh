#!/usr/bin/env bash

$(which mkdir) -p "$HOME/Library/Application Support/Sublime Text 3"

rm -rf "$HOME/Library/Application Support/Sublime Text 3/Packages"
rm -rf "$HOME/Library/Application Support/Sublime Text 3/Installed Packages"

ln -nfs "$HOME/.dotfiles/osx/st3/Packages/" "$HOME/Library/Application Support/Sublime Text 3/Packages"
ln -nfs "$HOME/.dotfiles/osx/st3/Installed Packages/" "$HOME/Library/Application Support/Sublime Text 3/Installed Packages"