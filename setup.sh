#!/usr/bin/env bash

# install xcode command-line tools
#echo "Installing XCode Command Line Tools."
xcode-select --install

# install homebrew
echo "Installing Homebrew."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# turn off analytics
echo "Turning Off Homebrew Analytics"
brew analytics off

# brew formulas
echo "Installing Homebrew Formulas."
brew install \
	# dev
	git \
	tree \
	fzf \
	fd \
	ripgrep \
	parallel \
	tmux \
	gnupg \
	xz \
	zstd \
	lz4 \
	curl \
	jq \
	ffmpeg \
	openssh \
	p7zip \
	ssh-copy-id \
	rsync \
	just \
	pinentry-mac \
	lazygit \
	lazydocker \
	gh \
	# tor
	tor \
	torsocks \
	# zsh
	zsh \
	zsh-syntax-highlighting \
	zsh-autosuggestions \
	zsh-completions \
	brew-cask-completion \
	# misc
	graphicsmagick \
	tectonic \
	typst \
	pandoc \
	yt-dlp \
	aria2 \
	# programming
	rustup-init \
	go \
	python \
	llvm \
	pipx \
	typescript \
	node \
	npm \
	pnpm \
	# editor/LSPs
	helix \
	marksman \
	deno \
	mat2 \
	cmus \
	ruff \
	ruff-lsp \
	black \
	yaml-language-server \
	bash-language-server \
	taplo
brew services start tor
$(brew --prefix)/opt/fzf/install

# brew casks
echo "Installing Homebrew Casks."
brew install --cask \
  signal \
	tor-browser \
	brave-browser \
	visual-studio-code \
	utm \
	stats \
	obs \
	iina \
	docker \
	protonvpn \
	cryptomator \
	sparrow \
	bisq \
	android-file-transfer \
	transmission \
	zsa-wally \
	balenaetcher \
	postman \
	inkscape \
	dangerzone \
	exifcleaner
# Cryptomator uses FUSE-T
brew tap macos-fuse-t/homebrew-cask
brew install fuse-t

# Rust
rustup-init
rustup default stable
rustup component add clippy
rustup component add rustfmt
rustup component add rust-analyzer
# rustup completions
mkdir $HOME/.zfunc
rustup completions zsh > $HOME/.zfunc/_rustup
rustup completions zsh cargo > ~/.zfunc/_cargo

# SSH Keys
ssh-add --apple-use-keychain ~/.ssh/id_ed25519

# customizations

# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do
	sudo -n true
	sleep 60
	kill -0 "$$" || exit
done 2>/dev/null &

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable Notification Center and remove the menu bar icon
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2>/dev/null

# Disable automatic capitalization as it's annoying when typing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Disable Resume system-wide
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Enable subpixel font rendering on non-Apple LCDs
# Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
defaults write NSGlobalDomain AppleFontSmoothing -int 2

# Enable HiDPI display modes (requires restart)
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Enable AirDrop over Ethernet and on unsupported Macs running Lion
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Expand the following File Info panes:
# "General", "Open with", and "Sharing & Permissions"
defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true

# Don't animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# Don't show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool true

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Don’t show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

# Move Dock to the right
defaults write com.apple.dock orientation -string right

# Reset Launchpad, but keep the desktop wallpaper intact
find "${HOME}/Library/Application Support/Dock" -name "*-*.db" -maxdepth 1 -delete

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Disable the annoying line marks
defaults write com.apple.Terminal ShowLineMarks -int 0

# Enable the debug menu in Disk Utility
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true

# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0

# Open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# Disable Safari’s thumbnail cache for History and Top Sites
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# Disable Safari’s thumbnail cache for History and Top Sites
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# Make Safari’s search banners default to Contains instead of Starts With
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# Remove useless icons from Safari's bookmarks bar
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# MacOS Ventura from Unredacted Magazine #5
# disables all leftover Siri services
defaults write com.apple.assistant.support 'Assistant Enabled' -bool false
launchctl disable "user/$UID/com.apple.assistantd"
launchctl disable "gui/$UID/com.apple.assistantd"
sudo launchctl disable 'system/com.apple.assistantd'
launchctl disable "user/$UID/com.apple.Siri.agent"
launchctl disable "gui/$UID/com.apple.Siri.agent"
sudo launchctl disable 'system/com.apple.Siri.agent'
defaults write com.apple.SetupAssistant 'DidSeeSiriSetup' -bool True
defaults write com.apple.systemuiserver 'NSStatusItem Visible Siri' 0
defaults write com.apple.Siri 'StatusMenuVisible' -bool false
defaults write com.apple.Siri 'UserHasDeclinedEnable' -bool true
defaults write com.apple.assistant.support 'Siri Data Sharing Opt-In Status' -int 2
# disables various remote connections
sudo systemsetup -setremotelogin off
sudo launchctl disable 'system/com.apple.tftpd'
sudo defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool true
sudo launchctl disable system/com.apple.telnetd
cupsctl --no-share-printers
cupsctl --no-remote-any
cupsctl --no-remote-admin

# set hostname
sudo scutil --set ComputerName macbook
sudo scutil --set LocalHostName macbook
sudo scutil --set HostName macbook

echo "Killing Apps."
for app in "Activity Monitor" \
	"cfprefsd" \
	"Dock" \
	"Finder" \
	"SystemUIServer" \
	"Terminal"; do
	killall "$app" &>/dev/null
done

echo "Done! Note that some of these changes require a logout/restart to take effect."
