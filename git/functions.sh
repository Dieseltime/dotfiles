##
# Git functions

##
# Checkout a branch for specified projects.
#
# Example: checkout master project1 project2
checkout () {
  if [ $# -eq 0 ] ; then
    ohai "Usage: checkout <branch name> [optional: project names]";
    return 1;
  fi

  if [ -z $PROJECTS_DIR ]; then ohno "PROJECT_DIR not set"; exit; fi
  working_dir=$(pwd)
  branch_name=$1
  shift

  # Check if any project names were supplied
  if [ -z $1 ]; then
    local folders=$(basename $PROJECTS_DIR/*)
  else
    local folders=$@
  fi

  for folder in $folders; do
    if [ -d $PROJECTS_DIR/$folder ]; then
      ohai "${txtgrn}cd $PROJECTS_DIR/$folder${txtwht}"
      cd $PROJECTS_DIR/$folder

      ohai "git fetch"
      git fetch

      ohai "git checkout $branch_name"
      git checkout $branch_name

      if ! git diff-index --quiet HEAD --; then
        while true; do
            pardonme "There are unsaved changes in $folder. What do you want to do? [s]tash, [o]verwrite, [d]isplay diff, [a]bort?"
            read action
            case $action in
                s )
                  ohai "git stash"
                  git stash; break;;
                o )
                  ohai "git fetch origin && git reset --hard origin && git checkout $branch_name"
                  git fetch origin && git reset --hard origin && git checkout $branch_name;
                  break;;
                d )
                  git diff; false;;
                a )
                  return;;
                * )
                  ;;
            esac
        done
      fi

      ohai "git pull origin $branch_name"
      git pull origin $branch_name
    else
      ohno "Directory $PROJECTS_DIR/$folder doesn't exist"
    fi
  done

  cd $working_dir
}

git_log_pretty () {
  git log --graph --abbrev-commit --decorate --date=relative \
  --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' \
  $*
}

install_git () {
  SYSTEM=$(uname -s | tr "[:upper:]" "[:lower:]")
  if [ "$SYSTEM" = "darwin" ]
  then
    brew install git
  else
    if ! git --version 2>&1 >/dev/null;
    then
      install_git_from_source
    else
      update_git
    fi
  fi
}

install_git_from_source () {
  sudo apt-get -y --force-yes install curl
  latest_git_version=$(curl -s http://git-scm.com/ | grep "class='version'" | perl -pe 's/.*?([0-9\.]+)<.*/$1/')
  cd /tmp
  sudo apt-get update
  sudo apt-get -y --force-yes install libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev build-essential
  wget https://git-core.googlecode.com/files/git-${latest_git_version}.tar.gz
  tar -zxf git-${latest_git_version}.tar.gz
  cd git-${latest_git_version}
  ./configure && make prefix=/usr/local && sudo make install
  cd $HOME
  ohai "Git ${latest_git_version} installed"
}

update_git () {
  sudo apt-get update
  sudo apt-get -y --force-yes install libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev build-essential
  cd /tmp
  rm -rf git
  git clone git://git.kernel.org/pub/scm/git/git.git
  cd git
  ./configure && make prefix=/usr/local && sudo make install
  cd $HOME
  git_version=`git --version`
  ohai "Git $git_version installed"
}
