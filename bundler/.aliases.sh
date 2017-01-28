deletegems () {
  for i in `gem list --no-versions`; do gem uninstall -aIx $i; done
}

alias delete-gems='deletegems'
alias uninstall-gems='deletegems'
alias uninstallgems='deletegems'
alias be='bundle exec'
alias lg='local_gem'
alias rg='remote_gem'

local_gem () {
  sed -e "/navigatingcare-components\.git/ s/^#*/#/" -i "$PWD/Gemfile"
  sed -e "/\.\.\/navigatingcare-components/ s/^#*//" -i "$PWD/Gemfile"
  bundle check || bundle
}

remote_gem () {
  sed -e "/navigatingcare-components\.git/ s/^#*//" -i "$PWD/Gemfile"
  sed -e "/\.\.\/navigatingcare-components/ s/^#*/#/" -i "$PWD/Gemfile"
  bundle check || bundle
}