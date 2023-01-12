#!/bin/bash 

# install volta
if [ ! `command -v volta` ]; then  
  echo "Installing volta"
  curl https://get.volta.sh | bash

  # update path temporarily so that node will be immediately resolved
  export VOLTA_HOME="$HOME/.volta"
  export PATH="$VOLTA_HOME/bin:$PATH"
fi

# install node
[ ! `command -v node` ] && \
  $HOME/.volta/bin/volta install node

if [ IS_OSX ]; then

  # Install Homebrew
  if [ ! `command -v brew` ]; then
    echo "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  # Install jq
  if [ ! `command -v jq` ]; then
    echo "Installing 'jq' from homebrew."
    brew install jq
  fi
fi