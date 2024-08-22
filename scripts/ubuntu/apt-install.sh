#!/bin/bash

# Update the package list
sudo apt update

# Install each package listed in packages.txt
while IFS= read -r packages; do
  echo "Installing $package..."
  sudo apt install -y "$package"
done <"../packages.txt"

echo "All packages installed successfully!"

sudo apt -y upgrade

sudo apt autoremove
