alias  l="ll"
alias  ~="cd ~"
alias ...="cd ../.."
alias ..="cd .."
alias c="clear"
alias cleargems="deletegems"
alias diff="colordiff"
alias dotfiles="e $HOME/.dotfiles"
alias eip="dig +short myip.opendns.com @resolver1.opendns.com"
alias fuck='$(thefuck $(fc -ln -1))'
alias grep="grep --color=auto"
alias installrbenv="install_rbenv"
alias list="declare -f"
alias ll="ls -Alvh --color"
alias path="echo -e ${PATH//:/\\n}"
alias removegems="deletegems"
alias sourceit="reload_profile"
alias syslog="sudo tail -f /var/log/syslog"
alias updategit="update_git"
alias vpn="vip"
alias psgrep="ps aux | grep -v grep | grep"
alias eachdir=". eachdir"
alias ag='ag --path-to-agignore ~/.agignore'

# `cat` with beautiful colors. requires Pygments installed.
#                  sudo easy_install -U Pygments
alias c='pygmentize -O style=monokai -f console256 -g'

if [ "$(uname -s)" == "Darwin" ]
then
  ip () {
    echo $(ipconfig getifaddr en1 || ipconfig getifaddr en0) | cpy
  }
else
  hostname () {
    hostname --long
  }

  ip () {
    echo ip addr show eth0 | mecopy
  }

  alias pbcopy="xsel --clipboard --input"
  alias pbpaste="xsel --clipboard --output"
fi

vip () {
  ifconfig | \
  grep -A1 utun | \
  grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | \
  grep -Eo '([0-9]*\.){3}[0-9]*' | \
  cpy
}
