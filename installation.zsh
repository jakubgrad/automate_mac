#!/bin/zsh
echo "You might want to install chrome, click on Download, then on googlechrome.dmg, and drag chrom to the taskbar (no to the Applications bc of admin priviledges)"
open -a Safari https://www.google.com/chrome/

echo "Ensuring ~/.zshenv exists"
touch $HOME/.zshenv

echo "Downloading homebrew"
git clone https://github.com/Homebrew/brew.git

echo "Switching to tag / version 4.3.8 of homebrew"
git checkout tags/4.3.8

echo "Adding homebrew to the path in .zshenv"
echo 'export PATH="$PATH:$HOME/Documents/Bycycle_all/brew/bin"' >> ~/.zshenv
source ~/.zshenv
echo "Checking if brew works i.e. was added to the path correctly"
brew --version

echo "Installing Github CLI"
brew install gh

echo "Creating Bycycle_all directory inside Documents"
cd ~/Documents
mkdir Bycycle_all

echo "Entering Bycycle_all"
cd ~/Documents/Bycycle_all

echo "Login to Github in the command line to download BasantaPoudel/Bycycle"
gh auth login
gh repo clone BasantaPoudel/Bycycle

echo "Downloading vscode"
curl -L --url "https://code.visualstudio.com/sha/download?build=stable&os=darwin-universal" -o VSCode-darwin-universal.zip
echo "Unzipping vscode"
unzip VSCode-darwin-universal.zip
echo "Removing the leftover .zip of vscode"
rm -rf VSCode-darwin-universal.zip


# Download Flutter SDK (ARM version)
echo "Downloading Flutter SDK..."
cd ~/Documents/Bycycle_all
curl -O "https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_arm64_3.22.2-stable.zip"

# Extracting flutter zip
echo "Setting Flutter SDK path..."
unzip flutter_macos*
echo "Setting Flutter SDK path..."
echo 'export PATH="$HOME/Documents/Bycycle_all/flutter/bin:$PATH"' >> ~/.zshenv
source ~/.zshenv

echo "Installing flutter extension for VSCode"
cd ~/Documents/Bycycle_all
Visual\ Studio\ Code.app/Contents/Resources/app/bin/code --install-extension dart-code.flutter
echo "Opening the downloaded Bycycle repository with VSCode"
Visual\ Studio\ Code.app/Contents/Resources/app/bin/code ByCycle

echo "Verifying Flutter installation..."
flutter -v
flutter doctor

echo "Installing cocoapds using brew. After 3-15 minutes a popup will ask for administrator priviledges, but clicking no will actually not affect the installation. But in any case, it will need to be done"
sleep 5
brew install cocoapods

echo "Installing command line neovim"
brew install neovim

echo "Setup probably completed successfully!"

echo "Opening iPhone simulator"
open -a Simulator
echo "Wait 2 seconds for it to open"
sleep 2

echo "flutter run inside ~/Documents/Bycycle_all/ByCycle"
cd ~/Documents/Bycycle_all/ByCycle
flutter run

