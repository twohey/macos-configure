#!/bin/bash
# script to install packages for a mac computer
set -e


brew tap caskroom/cask

# macOS AppStore scripting
brew install mas

# mac apps
mas install 803453959  # Slack
mas install 1142578753 # OmniGraffle 7
mas install 409183694  # Keynote
brew cask install firefox
brew cask install google-chrome
brew cask install vlc
brew cask install skype
brew cask install kindle

# save the eyes and sleep cycles
brew cask install flux

# developer apps
mas install 604825918 # Valentina Studio
brew cask install sourcetree
brew cask install charles
brew cask install wireshark
# brew cask install cyberduck

# editors
brew cask install aquamacs
brew cask install atom
brew cask install eclipse-jee
brew cask install intellij-ce
brew cask install sublime-text
brew cask install textmate
brew cask install visual-studio-code

# docker tools
# brew cask install docker

# web dev
brew install httpie
brew install jmeter

# java
brew install maven

