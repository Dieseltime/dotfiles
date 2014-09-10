## SHELL OPTIONS
shopt_options=(
  autocd
  cdspell
  cmdhist
  dirspell
  dotglob
  expand_aliases
  nocaseglob
  no_empty_cmd_completion
  histappend
)
for option in $shopt_options; do
  tmp="$(shopt -q "$option" 2>&1 > /dev/null | grep "invalid shell option name")"
  if [ '' == "$tmp" ]; then
    shopt -s "$option"
  fi
done

unalias -a

## ALIASES
alias ..="cd .."
alias ...="cd ../.."
alias  ~="cd ~"
alias  l="ll"
alias cleargems="deletegems"
alias installrbenv="install_rbenv"
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias list="declare -f"
alias removegems="deletegems"
alias syslog="sudo tail -f /var/log/syslog"
alias sourceit="reload_profile"
alias updategit="update_git"
alias dotfiles="e $HOME/.dotfiles"
alias vip="ifconfig | grep -A1 utun0 | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*'"

source $HOME/.dotfiles/git/.aliases

if [ "$(uname -s)" == "Darwin" ]
then
  alias ll="ls -AGlvh"
  alias localip="ipconfig getifaddr en0 | ipconfig getifaddr en1"
else
  alias hostname="hostname --long"
  alias ll="ls -Alvh --color"
  alias localip="ip addr show eth0"
fi

if command -v gem >/dev/null 2>&1; then
  alias deletegems="for i in `gem list --no-versions`; do gem uninstall -aIx $i; done"
fi

## COLORS
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White

## EXPORTS

export PROJECTS_DIR="$HOME/www"

# History
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
export MANPAGER="less -X"

# Save and reload the history after each command finishes
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}: ${PWD/#$HOME/~}\007"'
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Docker
export DOCKER_HOST=tcp://$(boot2docker ip 2>/dev/null):2375

# Editor
export EDITOR=$(which atom || which vim)

# Timestamps for bash history
HISTTIMEFORMAT='%F %T '
export HISTTIMEFORMAT

# Make some commands not show up in history
export HISTIGNORE="ls:ls *:cd:cd -:pwd;exit:date:* --help"

## BASH COMPLETION
[[ -s /etc/bash_completion ]] && source /etc/bash_completion
[[ -s /usr/local/etc/bash_completion ]] && source /usr/local/etc/bash_completion

## TAB COMPLETION
set completion-ignore-case on
set show-all-if-ambiguous on
set show-all-if-unmodified on
set completion-map-case on
set skip-completed-text on

source $HOME/.git-prompt.sh >/dev/null 2>&1

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_DESCRIBE_STYLE="branch"
GIT_PS1_SHOWUPSTREAM="auto git"

if command -v __git_ps1 >/dev/null 2>&1; then
  PS1="\W\$(__git_ps1 \" (%s)\")\$ "
fi

## RBENV
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

## FUNCTIONS
[[ -s "$HOME/.dotfiles/bash/functions.sh" ]] && source "$HOME/.dotfiles/bash/functions.sh"
[[ -s "$HOME/.dotfiles/bundler/functions.sh" ]] && source "$HOME/.dotfiles/bundler/functions.sh"
[[ -s "$HOME/.dotfiles/git/functions.sh" ]] && source "$HOME/.dotfiles/git/functions.sh"
[[ -s "$HOME/.dotfiles/ruby/functions.sh" ]] && source "$HOME/.dotfiles/ruby/functions.sh"
[[ -s "$HOME/.dotfiles/ssh/functions.sh" ]] && source "$HOME/.dotfiles/ssh/functions.sh"


[[ -s "$HOME//Users/svanhess/.dotfiles/bash/functions.sh" ]] && source "$HOME//Users/svanhess/.dotfiles/bash/functions.sh"
[[ -s "$HOME//Users/svanhess/.dotfiles/bundler/functions.sh" ]] && source "$HOME//Users/svanhess/.dotfiles/bundler/functions.sh"
[[ -s "$HOME//Users/svanhess/.dotfiles/git/functions.sh" ]] && source "$HOME//Users/svanhess/.dotfiles/git/functions.sh"
[[ -s "$HOME//Users/svanhess/.dotfiles/ruby/functions.sh" ]] && source "$HOME//Users/svanhess/.dotfiles/ruby/functions.sh"
[[ -s "$HOME//Users/svanhess/.dotfiles/ssh/functions.sh" ]] && source "$HOME//Users/svanhess/.dotfiles/ssh/functions.sh"

export PATH="./bin:~/bin:/usr/local/bin:/opt/chefdk/bin:$HOME/.chefdk/gem/ruby/2.1.0/bin:$PATH"
