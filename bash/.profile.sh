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
for aliases in `find $HOME/.dotfiles -maxdepth 2 -name .aliases`
do
  source $aliases
done

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

# AWS
export JAVA_HOME=`/usr/libexec/java_home 2>&1`
export EC2_HOME=$HOME/bin/ec2
source $HOME/.ssh/ec2-credentials >/dev/null 2>&1
export EC2_URL=https://ec2.us-west-1.amazonaws.com

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

## DIRENV
if which direnv > /dev/null; then eval "$(direnv hook $0)"; fi

## FUNCTIONS
for functions in `find $HOME/.dotfiles -maxdepth 2 -name functions.sh`
do
  source $functions
done

export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="$PATH:$EC2_HOME/bin"
export PATH="~/bin:/usr/local/bin:/opt/chefdk/bin:$HOME/.chefdk/gem/ruby/2.1.0/bin:$PATH"
