#!/usr/bin/env bash

user () {
  printf "\n  [ \033[0;33m?\033[0m ] $1 \n\n"
}

if ! which git >/dev/null 2>&1; then
  if [ "$(uname -s)" == "Darwin" ]; then
    brew install git
  else
    sudo apt-get update
    sudo apt-get -y --force-yes install git
  fi
fi

git_prompt_url="https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh"
git_prompt_path="$HOME/.git-prompt.sh"

if [ ! -s $git_prompt_path ]; then
  ohai "Installing git-prompt.sh"
  if command -v wget >/dev/null 2>&1 ; then
    wget -O $git_prompt_path $git_prompt_url
  else
    cd $HOME && { curl -o $git_prompt_path -L $git_prompt_url; cd -; }
  fi
fi

if ! [ -f $HOME/.dotfiles/git/.gitconfig ]; then
  git_credential='cache'
  if [ "$(uname -s)" == "Darwin" ]; then
    git_credential='osxkeychain'
  fi

  sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" $HOME/.dotfiles/git/.gitconfig.sample > $HOME/.dotfiles/git/.gitconfig
fi

if [ ! -s "$HOME/.gitconfig" ]; then
  ln -nfs "$HOME/.dotfiles/git/.gitconfig" "$HOME/.gitconfig"
fi

if [ ! -s "$HOME/.gitignore" ]; then
  ln -nfs "$HOME/.dotfiles/git/.gitignore" "$HOME/.gitignore"
fi

if ! grep -q '[[ -s "${HOME}/.dotfiles/git/functions.sh" ]] && source "${HOME}/.dotfiles/git/functions.sh"' "$HOME/.dotfiles/bash/.profile.sh" ; then
  echo '[[ -s "${HOME}/.dotfiles/git/functions.sh" ]] && source "${HOME}/.dotfiles/git/functions.sh"' >> "$HOME/.dotfiles/bash/.profile.sh"
fi

if [ ! -s "$HOME/.ssh/id_rsa" ]; then
  ln -nfs "$HOME/.dotfiles/ssh/id_rsa $HOME/.ssh/id_rsa"
  ln -nfs "$HOME/.dotfiles/ssh/id_rsa.pub $HOME/.ssh/id_rsa"
fi

if [ ! -s "$HOME/.ssh/config" ]; then
  ln -nfs "$HOME/.dotfiles/ssh/config $HOME/.ssh/config"
fi
