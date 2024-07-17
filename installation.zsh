#!/bin/zsh

# Function to wait for user confirmation
function wait_for_confirmation {
    read -p "Press Enter to continue..."
}

echo "Creating Bycycle_all directory inside Documents"
cd ~/Documents
mkdir Bycycle_all

echo "Entering Bycycle_all"
cd Bycycle_all

echo "After pressing enter, Xcode will open. In Xcode, you'll need to login with github account and a token and download the repository. Make sure to download the repository to ~/Documents/Bycycle_all. This script will run in the background for approximately 20 minutes without requiring any action."
wait_for_confirmation
open -a Xcode

echo "Ensuring ~/.zshenv exists"
touch $HOME/.zshenv

echo "Entering Bycycle_all"
cd Bycycle_all

echo "Downloading homebrew"
git clone https://github.com/Homebrew/brew.git

echo "Switching to tag / version 4.3.8 of homebrew"
git checkout tags/4.3.8

echo "Adding homebrew to the path in .zshenv"
echo 'export PATH="$PATH:$HOME/Documents/Bycycle_all/brew/bin"' >> ~/.zshenv
source ~/.zshenv
echo "Checking if brew works i.e. was added to the path correctly"
brew --version

# Download Flutter SDK (ARM version)
echo "Downloading Flutter SDK..."
cd ~/Documents/Bycycle_all
curl -O "https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_arm64_3.22.2-stable.zip"

echo "Setting Flutter SDK path..."
echo 'export PATH="$HOME/Documents/Bycycle_all/flutter/bin:$PATH"' >> ~/.zshenv
source ~/.zshenv

echo "Verifying Flutter installation..."
flutter -v
flutter doctor

echo "Installing cocoapds using brew. After 3-15 minutes a popup will ask for administrator priviledges, but clicking no will actually not affect the installation. But in any case, it will need to be done"
sleep 5
brew install cocoapods


echo "Installing VSCode. Highly prone to failure, maybe should be done by going to Apple Store instead"
brew install --cask visual-studio-code

echo "Setup probably completed successfully!"

echo "Opening iPhone simulator"
open -a Simulator
echo "Wait 2 seconds for it to open"
sleep 2

echo "flutter run inside ~/Documents/Bycycle_all/ByCycle"
cd ~/Documents/Bycycle_all/ByCycle
flutter run
