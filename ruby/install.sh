# Install ruby
if [ "$(uname -s)" == "Linux" ]; then
  sudo apt-get update
  sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties
fi

if [ -d ~/.rbenv ]; then
  git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
fi

if ! grep -q "export PATH=\"$HOME/.rbenv/bin:$PATH\"" "~/.bash_profile"; then
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
fi

if ! grep -q "eval \"$(rbenv init -)\"" "~/.bash_profile"; then
  echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
fi

exec $SHELL

if [ -d ~/.rbenv/plugins/ruby-build ]; then
  git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

rbenv install 2.1.3
rbenv global 2.1.3

if ! grep -q "gem: --no-ri --no-rdoc"; then
  echo "gem: --no-ri --no-rdoc" > ~/.gemrc
fi
