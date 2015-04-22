#!/usr/bin/env bash

install_rbenv () {
  install_git

  if [ ! -s $HOME/.rbenv ]; then
    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
  fi

  touch $HOME/.bashrc

  if ! grep -q "export PATH=\"$HOME/.rbenv/bin:$PATH\"" "$HOME/.bashrc"; then
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
  fi

  if ! grep -q 'eval "$(rbenv init -)"' "$HOME/.bashrc"; then
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc
  fi

  # Ruby build
  git clone https://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build

  # Auto rehash
  git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash

  sourceit
}

kill_passenger () {
  ps aux | grep -i passenger | grep 'master\|worker' | awk '{ system("sudo kill -9 " $2) }'
}
