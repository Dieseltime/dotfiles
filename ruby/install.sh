#!/usr/bin/env bash

# Install ruby
if [ "$(uname -s)" == "Linux" ]; then
  sudo apt-get update
  sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties
fi

if ! [ -d "$HOME/.rbenv" ]; then
  git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
fi

if ! grep -q 'export PATH="$HOME/.rbenv/bin:$PATH"' "$HOME/.bashrc"; then
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> "$HOME/.bashrc"
fi

if ! grep -q 'eval "$(rbenv init -)"' "$HOME/.bashrc"; then
  echo 'eval "$(rbenv init -)"' >> "$HOME/.bashrc"
fi

if ! [ -d "$HOME/.rbenv/plugins/ruby-build" ]; then
  git clone git://github.com/sstephenson/ruby-build.git "$HOME/.rbenv/plugins/ruby-build"
fi

#latest_ruby=$(rbenv install -l | grep -E '^\s+[0-9].[0-9].[0-9](-p[0-9]{1,3})?$' | sort -n | tail -1 | sed -e 's/^[[:space:]]*//')
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
latest_ruby=$(ruby $dir/find_latest.rb)
current_ruby=$(ruby -e 'print RUBY_VERSION')

if [ "$latest_ruby" != "$current_ruby" ]; then
  rbenv install $latest_ruby
  rbenv global $latest_ruby
fi

if ! grep -q "gem: --no-ri --no-rdoc" "$HOME/.gemrc"; then
  echo "gem: --no-ri --no-rdoc" > "$HOME/.gemrc"
fi
