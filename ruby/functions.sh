install_rbenv () {
  install_git

  if [ ! -s $HOME/.rbenv ]; then
    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
  fi

  touch $HOME/.bash_profile

  if ! grep -q "export PATH=\"$HOME/.rbenv/bin:$PATH\"" "$HOME/.bash_profile"; then
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
  fi

  if ! grep -q 'eval "$(rbenv init -)"' "$HOME/.bash_profile"; then
    echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
  fi

  # Ruby build
  git clone https://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build

  # Auto rehash
  git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash

  sourceit
}

migrate () {
  if [ -z $PROJECTS_DIR ]; then ohno "PROJECT_DIR not set"; exit; fi
  working_dir=$(pwd)

  # Check if any project names were supplied
  if [ -z $1 ]; then
    local folders=$(basename $PROJECTS_DIR/*)
  else
    local folders=$@
  fi

  for folder in $folders; do
    if [ -d $PROJECTS_DIR/$folder ]; then
      ohai "cd $PROJECTS_DIR/$folder"
      cd $PROJECTS_DIR/$folder

      ohai "bundleall $folder"
      bundleall $folder

      # copy sample config to config/config.yml if necessary
      if [ ! -f $PROJECTS_DIR/$folder/config/config.yml ]; then
        ohai "cp config/config.sample.yml config/config.yml"
        cp config/config.sample.yml config/config.yml
      fi

      # check if migrations exist
      if [ -d $PROJECTS_DIR/$folder/db ]; then
        # copy sample config to config/database.yml if necessary
        if [ ! -f $PROJECTS_DIR/$folder/config/database.yml ]; then
          ohai "cp config/database.sample.yml config/database.yml"
          cp config/database.sample.yml config/database.yml
        fi

        # run migrations
        ohai "bundle exec rake db:migrate"
        bundle exec rake db:migrate;

        # check if seeds exist
        if [ -d $PROJECTS_DIR/$folder/db/seeds ]; then
          ohai "bundle exec rake db:seed:migrate"
          bundle exec rake db:seed:migrate;
        fi
      fi
    else
      ohno "Directory $PROJECTS_DIR/$folder doesn't exist"
    fi
  done

  cd $working_dir
}

kill_passenger () {
  ps aux | grep -i passenger | grep 'master\|worker' | awk '{ system("sudo kill -9 " $2) }'
}
