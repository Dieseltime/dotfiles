echo "Installing applications via homebrew cask ..."

brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup
brew install caskroom/cask/brew-cask

brew cask install airmail-amt
brew cask install angry-ip-scanner
brew cask install bartender
brew cask install boot2docker
brew cask install chromecast
brew cask install colorpicker
brew cask install colorpicker-hex
brew cask install crashplan
brew cask install daisydisk
brew cask install dash
brew cask install dropbox
brew cask install filebot
brew cask install fing
brew cask install firefox
brew cask install flowdock
brew cask install google-chrome
brew cask install iterm2
brew cask install kodi
brew cask install lastpass
brew cask install lunchy
brew cask install nmap
brew cask install pgadmin3
brew cask install sublime-text
brew cask install the-unarchiver
brew cask install vagrant
brew cask install virtualbox