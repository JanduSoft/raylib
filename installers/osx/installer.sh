#!/bin/bash


###############################################
# Installer script for set up Raylib on a Mac.
# by (@Jandujar2)
###############################################


###############################################
#             Constants
###############################################

RAYLIB_GIT_URL="https://github.com/raysan5/raylib"
CURL="/usr/bin/curl"
GIT="/usr/bin/git"
INSTALL_DIR="$HOME/raylib"





## Check user is not root
if [ "$EUID" -eq 0 ]; then
  echo "ERROR: Please run as single user"
  echo "ERROR: Root not allowed"
  exit
fi

## Install Apple Command Line Utilities
if xcode-select --install 2>&1 | grep installed; then
  echo "Apple Command Line Utilities Installed"
else
  echo "Apple Command Line Utilities not installed, install it and restart raylib installer"
  osascript -e 'tell app "System Events" to display dialog "Press Install and restart Raylib Installer Script" buttons "OK" default button 1 with title "ERROR: Missing xcode command-line tools"'
  exit
fi

## Check if raylib dir exists
if [ ! -d $INSTALL_DIR ]; then
    echo "Creating directory: $INSTALL_DIR"
    mkdir -p $INSTALL_DIR
else
	echo "ERROR: Dir $INSTALL_DIR already exists"
	echo "       Delete the directory and restart the installation"
	exit
fi

## Goto to raylib dir
pushd $INSTALL_DIR

## Download Raylib
echo "Clonning Raylib"
$GIT clone $RAYLIB_GIT_URL .

## Delete unneeded files
echo "Removing unneded files"
rm -rf .git
rm -f .gitignore
rm -f .travis.yml

## Return to current dir
popd


## Create alias on the desktop
echo "Creating Link to the Desktop"
ln -s $INSTALL_DIR $HOME/Desktop/raylib
