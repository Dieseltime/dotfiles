#!/usr/bin/env bash

if [ "$(uname -s)" == "Darwin" ]; then
  brew install ssh-copy-id
fi

if ! command -v lpass >/dev/null 2>&1; then
  if [ "$(uname -s)" == "Darwin" ]; then
    brew install lastpass-cli --with-pinentry --with-doc
  else
    sudo apt-get -qq -y install openssl libcurl4-openssl-dev libxml2 libssl-dev libxml2-dev pinentry-curses xclip
    rm -rf ./lastpass-cli
    git clone https://github.com/lastpass/lastpass-cli.git
    cd ./lastpass-cli
    make
    sudo make install
  fi
fi

if [ ! -s $HOME/.dotfiles/ssh/config ]; then
  mkdir -p $HOME/.ssh
  rm -rf $HOME/.ssh/config
  ln -s $HOME/.dotfiles/ssh/config $HOME/.ssh/config
fi

if [ ! -f $HOME/.ssh/id_rsa ]; then
  lpass login vanhess@gmail.com
  lpass show --notes ssh-private-key > $HOME/.ssh/id_rsa
  lpass show --notes ssh-public-key > $HOME/.ssh/id_rsa.pub
fi