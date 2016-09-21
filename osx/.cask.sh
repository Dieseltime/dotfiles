echo "Installing applications via homebrew cask ..."

brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup
brew install caskroom/cask/brew-cask
brew tap caskroom/versions

HOMEBREW_CASK_OPTS="--appdir=/Applications --force"

# Install apps available via App Store
mas signin vanhess@gmail.com

mas install 443987910	  # 1Password
mas install 405843582	  # Alfred
mas install 668841348	  # Authy Bluetooth
mas install 417375580	  # BetterSnapTool
mas install 411643860	  # DaisyDisk
mas install 458034879	  # Dash
mas install 586862299	  # Duplicate Cleaner For iPhoto
mas install 406056744	  # Evernote
mas install 463541543	  # Gemini
mas install 668208984	  # GIPHY CAPTURE
mas install 1054607607  # Helium
mas install 408981434	  # iMovie
mas install 926036361	  # LastPass
mas install 592704001	  # Photos Duplicate Cleaner
mas install 407963104	  # Pixelmator
mas install 409907375	  # Remote Desktop
mas install 803453959	  # Slack
mas install 411678673	  # SourceTree
mas install 404010395	  # TextWrangler
mas install 747961939	  # Toad
mas install 403388562	  # Transmit
mas install 497799835	  # Xcode

# Everything else via brew cask

brew cask install appcleaner
brew cask install angry-ip-scanner
brew cask install ascension
brew cask install bartender
brew cask install colorpicker
brew cask install colorpicker-hex
brew cask install crashplan
brew cask install dropbox
brew cask install filebot
brew cask install firefox
brew cask install franz
brew cask install google-chrome
brew cask install iterm2
brew cask install lunchy
brew cask install spectacle
brew cask install the-unarchiver
brew cask install vagrant
brew cask install virtualbox
