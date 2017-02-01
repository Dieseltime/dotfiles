#!/usr/bin/env bash

setup_ruby_gc_exports () {
  export RUBY_GC_MALLOC_LIMIT=1000000000
  export RUBY_FREE_MIN=500000
  export RUBY_HEAP_MIN_SLOTS=40000
  export RUBY_GC_HEAP_INIT_SLOTS=1000000
  export RUBY_GC_HEAP_FREE_SLOTS=500000
  export RUBY_GC_HEAP_GROWTH_FACTOR=1.1
  export RUBY_GC_HEAP_GROWTH_MAX_SLOTS=10000000
  export RUBY_GC_MALLOC_LIMIT_MAX=1000000000
  export RUBY_GC_MALLOC_LIMIT_GROWTH_FACTOR=1.1
}

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
