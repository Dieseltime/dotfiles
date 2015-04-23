[user]
  name = Scott Van Hess
  email = vanhess@gmail.com
[apply]
  whitespace = nowarn
[color]
  diff = auto
  status = auto
  branch = auto
  ui = true
[core]
  excludesfile = ~/.gitignore
  editor = vim
[credential]
  helper =  GIT_CREDENTIAL_HELPER
[help]
  autocorrect = 1
[mergetool]
  keepBackup = false
[alias]
  # List all remote branches
  b = "!for k in `git branch -r | perl -pe 's/^..(.*?)( ->.*)?$/\\1/'`; do echo `git show --pretty=format:\"%Cgreen%ci %Cblue%cr%Creset\" $k -- | head -n 1`\\\\t$k; done | sort -r"
  # List all remote branches by last modified date
  m = "!git for-each-ref --sort='-authordate' --format='%(authordate)%09%(objectname:short)%09%(refname)' refs/heads | sed -e 's-refs/heads/--'"
[push]
  default = matching
