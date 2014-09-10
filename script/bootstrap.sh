#!/usr/bin/env bash

export ARCH=$(uname -s)
case "$ARCH" in
  'Darwin') export MAC_ONLY=true ;;
  *)        export MAC_ONLY=false ;;
esac

if $PERSONAL ; then
  which -s brew
  if [[ $? != 0 ]] ; then
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
  else
    brew update
  fi
fi

dotfiles_profile="${HOME}/.dotfiles/bash/.profile.sh"

bootstrap () {
  for installer in `find $HOME/.dotfiles -maxdepth 2 -name install.sh`
  do
    source $installer
  done

  ruby $HOME/.dotfiles/atom.symlink/install.rb
}

for functions in `find $HOME/.dotfiles -maxdepth 2 -name functions.sh`
do
  echo "loading ${functions}"
  source $functions
done

for functions in `find ${HOME}/.dotfiles -maxdepth 2 -name functions.sh`
do
  if ! grep -q "[[ -s \"\$HOME/${functions}\" ]] && source \"\$HOME/${functions}\"" "${dotfiles_profile}" ; then
    echo "[[ -s \"\$HOME/${functions}\" ]] && source \"\$HOME/${functions}\"" >> "${dotfiles_profile}"
  fi
done

source $HOME/.dotfiles/bash/.profile.sh

bootstrap
