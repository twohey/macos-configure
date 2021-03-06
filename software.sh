#!/bin/bash
# Copyright (C) 2017-2019 Paul Twohey. All Rights reserved. See LICENSE file

# script to install packages for a mac computer
echo "must be logged into the App Store or this will not work"

set -e
set -x

# check if brew exists and install if not
if ! type "brew" > /dev/null; then
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew tap Homebrew/bundle
brew tap caskroom/cask

# requires password which is sad, thus make first
brew cask install wireshark
brew install mtr

# manage Java through brew - this also requires a password
brew cask install java

# macOS AppStore scripting
brew install mas

# ensure user is signed into the AppStore
mas account

# NB: users must have already authorized these applications or
# they will not be able to be installed
mas install 409183694  # Keynote
mas install 408981434  # iMovie
mas install 409201541  # Pages
mas install 409203825  # Numbers
mas install 803453959  # Slack
mas install 1142578753 # OmniGraffle 7
mas install 604825918  # Valentina Studio
mas install 418138339  # HTTP Client
mas install 926036361  # LastPass

# mac apps
brew cask install firefox
brew cask install google-chrome
brew cask install vlc
brew cask install skype
brew cask install zoom
brew cask install kindle
brew cask install skyfonts

# developer mac apps
mas install 497799835 # Xcode
# ensure Xcode license is accepted
sudo xcodebuild -license accept

mas install 604825918 # Valentina Studio


# save the eyes and sleep cycles
brew cask install flux

# developer apps
brew cask install sourcetree
brew cask install charles
# brew cask install cyberduck

# editors
brew cask install aquamacs
brew cask install atom
brew cask install eclipse-jee
brew cask install intellij-idea-ce
brew cask install sublime-text
brew cask install textmate
brew cask install visual-studio-code

# image tools
brew cask install imageoptim

# docker tools
# brew cask install docker
brew install shellcheck

# web dev
brew install httpie
brew install jmeter
brew install jq
brew install yarn

# java
brew install maven

# go
brew install go

# for signing things
brew install gpg

brew install rust
