#!/bin/bash

# colour constants
GREEN='\033[0;32m=========='
RED='\033[0;31m'
NCL='==========\033[0m' # No Color
NC='\033[0m' # No Color

QT_DIR="$HOME/Qt/6.5.0"
QTCREATOR_DIR="$HOME/Qt/Tools/QtCreator"

if [ ! -d "$HOME/Qt" ]; then
  echo -e " ${GREEN} Making folder for Qt"
  mkdir $HOME/Qt
fi

# Install Qt
if [ ! -d "$QT_DIR" ]; then
  echo -e "Installing Qt with aqt installer"
  pip install aqtinstall
  aqt install-qt linux desktop 6.5.0 --modules qtserialbus qt5compat qtserialport -O ~/Qt
  
  else
  echo -e "${RED} $QT_DIR already exists"
fi

# Install Qt Creator
if [ ! -d "$QTCREATOR_DIR" ]; then
  echo -e "${RED} $QTCREATOR_DIR does not exist. ${NC}"
  echo -e "{$GREEN} " 
  aqt install-tool linux desktop tools_qtcreator -O ~/Qt
  else
  echo -e "${RED} $QTCREATOR_DIR already exists"
fi

# Directory to add to the PATH
new_directory="$HOME/Qt/Tools/QtCreator/bin/"

# Check if the directory is already in the PATH
if [[ ":$PATH:" == *":$new_directory:"* ]]; then
  echo "Directory is already in the PATH"
else
  # Add the directory to the PATH in the current session
  export PATH="$PATH:$new_directory"
  echo "Directory added to PATH in the current session"

  # Check if the shell profile file exists
  if [ -f "$HOME/.bashrc" ]; then
    # Check if the directory is already in the PATH in the profile file
    if grep -qF "$new_directory" "$HOME/.bashrc"; then
      echo "Directory is already in the PATH in the profile file"
    else
      # Add the directory to the PATH in the profile file
      echo "export PATH=\"\$PATH:$new_directory\"" >> "$HOME/.bashrc"
      echo "Directory added to PATH in the profile file"
      echo "Please restart your shell or run 'source ~/.bashrc' to apply changes"
    fi
  else
    echo "Warning: Profile file ~/.bashrc not found. Please add the directory to your PATH manually."
  fi
fi






