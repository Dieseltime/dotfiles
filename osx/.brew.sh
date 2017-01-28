#!/usr/bin/env bash

if ! command -v brew >/dev/null 2>&1; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" </dev/null
fi

# Install command-line tools using Homebrew.

brew_install () {
  if [[ -n $(brew ls --versions $1) ]]; then
    echo "Already installed: $1"
  else
    brew install $@
  fi
}

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Updating homebrew and formulae..."
brew update

echo "Upgrade outdated, unpinned brews..."
brew upgrade

brew_install bash
brew_install bash-completion
brew_install coreutils          # GNU core utilities (those that come with OS X are outdated)
brew_install findutils          # GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew_install wget --enable-iri  # wget with internationalized URI (IRI) support

brew tap homebrew/dupes
brew install homebrew/dupes/grep

brew_install ack
brew_install binutils
brew_install colordiff
brew_install diffutils
brew_install direnv
brew_install ed --default-names
brew_install findutils --default-names
brew_install gawk
brew_install gnu-indent --default-names
brew_install gnu-sed --default-names
brew_install gnu-tar --default-names
brew_install gnu-which --default-names
brew_install gnutls --default-names
brew_install grep --default-names
brew_install gzip
brew_install lastpass-cli --with-pinentry --with-doc
brew_install man2html
brew_install rename
brew_install screen
brew_install tree
brew_install watch
brew_install wdiff --with-gettext
brew_install wget
brew_install mackup
brew_install hub
brew_install hookup
brew_install fpp

echo 'Running `brew cleanup`...'
brew cleanup

dotfiles_profile="${HOME}/.dotfiles/bash/.profile.sh"

if ! grep -q "PATH=\"/usr/local/opt/coreutils/libexec/gnubin:\$PATH\"" "${dotfiles_profile}" ; then
  echo "PATH=\"/usr/local/opt/coreutils/libexec/gnubin:\$PATH\"" >> "${dotfiles_profile}"
fi
