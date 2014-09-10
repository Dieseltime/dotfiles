#!/usr/bin/env bash

if [ "$(uname -s)" == "Darwin" ]; then
  brew install ssh-copy-id
fi

if [ ! -s $HOME/.dotfiles/ssh/config ]; then
  mkdir -p $HOME/.ssh
  rm -rf $HOME/.ssh/config
  ln -s $HOME/.dotfiles/ssh/config $HOME/.ssh/config
fi
