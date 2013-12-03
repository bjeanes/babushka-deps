dep 'system' do
  requires \
    'system name set',
    'ssh key',
    'set up personal deps',
    'dot files',
    'packages',
    'rubies',
    'prefs'
end

dep 'ssh key', :key do
  requires 'system name set'

  key.default! '~/.ssh/id_rsa'.p.expand

  met? { key.p.exists? }
  meet { shell "ssh-keygen -t rsa -b 4096  -f #{key.to_s.inspect}" }
end

dep 'set up personal deps' do
  user = ENV['USER']
  source_name = File.basename(File.dirname(__FILE__))
  personal = '~/.babushka/deps'.p

  met? {
    user != source_name || personal.exists?
  }

  meet { shell 'ln', '-s', File.dirname(__FILE__), personal.to_s }
end

# A lot of these borrowed from
# https://github.com/mathiasbynens/dotfiles/blob/master/.osx
dep 'prefs' do
  met? { false }
  meet {
    met? { true }

    # Set expanded save dialogs as default
    shell %w[defaults write -g NSNavPanelExpandedStateForSaveMode -bool YES]

    # Enable the debug menu in Safari.
    shell %w[defaults write com.apple.safari IncludeDebugMenu -bool YES]

    # Disable dashbaord
    shell %w[defaults write com.apple.dashboard mcx-disabled -bool YES]

    # Disable the sound effects on boot
    sudo %w[nvram SystemAudioVolume="\ "]

    # Disable opening and closing window animations
    shell %w[defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false]

    # Increase window resize speed for Cocoa applications
    shell %w[defaults write NSGlobalDomain NSWindowResizeTime -float 0.001]

    # Expand print panel by default
    shell %w[defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true]

    # Save to disk (not to iCloud) by default
    shell %w[defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false]

    # Automatically quit printer app once the print jobs complete
    shell %w[defaults write com.apple.print.PrintingPrefs Quit\ When\ Finished -bool true]

    # Disable the “Are you sure you want to open this application?” dialog
    shell %w[defaults write com.apple.LaunchServices LSQuarantine -bool false]

    # Display ASCII control characters using caret notation in standard text views
    # Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
    shell %w[defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true]

    # Disable Resume system-wide
    shell %w[defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false]

    # Disable automatic termination of inactive apps
    shell %w[defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true]

    # Reveal IP address, hostname, OS version, etc. when clicking the clock
    # in the login window
    sudo %w[defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName]

    # Restart automatically if the computer freezes
    shell %w[systemsetup -setrestartfreeze on]

    # Disable smart quotes as they’re annoying when typing code
    shell %w[defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false]

    # Disable smart dashes as they’re annoying when typing code
    shell %w[defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false]

    # Trackpad: enable tap to click for this user and for the login screen
    shell %w[defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true]
    shell %w[defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1]
    shell %w[defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1]

    # Enable full keyboard access for all controls
    # (e.g. enable Tab in modal dialogs)
    shell %w[defaults write NSGlobalDomain AppleKeyboardUIMode -int 3]

    # Use scroll gesture with the Ctrl (^) modifier key to zoom
    shell %w[defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true]
    shell %w[defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144]

    # Follow the keyboard focus while zoomed in
    shell %w[defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true]

    # Disable press-and-hold for keys in favor of key repeat
    shell %w[defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false]

    # Set a blazingly fast keyboard repeat rate
    shell %w[defaults write NSGlobalDomain KeyRepeat -int 0]

    # Automatically illuminate built-in MacBook keyboard in low light
    shell %w[defaults write com.apple.BezelServices kDim -bool true]
    # Turn off keyboard illumination when computer is not used for 5 minutes
    shell %w[defaults write com.apple.BezelServices kDimTime -int 300]
    # Require password immediately after sleep or screen saver begins
    shell %w[defaults write com.apple.screensaver askForPassword -int 1]
    shell %w[defaults write com.apple.screensaver askForPasswordDelay -int 0]

    # Save screenshots to the desktop
    shell %w[defaults write com.apple.screencapture location -string "${HOME}/Desktop"]

    # Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
    shell %w[defaults write com.apple.screencapture type -string "png"]

    # Finder: disable window animations and Get Info animations
    shell %w[defaults write com.apple.finder DisableAllAnimations -bool true]

    # Finder: Show icons for hard drives, servers, and removable media on the desktop
    shell %w[defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true]
    shell %w[defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true]
    shell %w[defaults write com.apple.finder ShowMountedServersOnDesktop -bool true]
    shell %w[defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true]

    # Finder: show all filename extensions
    shell %w[defaults write NSGlobalDomain AppleShowAllExtensions -bool true]

    # Finder: show status bar
    shell %w[defaults write com.apple.finder ShowStatusBar -bool true]

    # Finder: show path bar
    shell %w[defaults write com.apple.finder ShowPathbar -bool true]

    # Finder: allow text selection in Quick Look
    shell %w[defaults write com.apple.finder QLEnableTextSelection -bool true]

    # Display full POSIX path as Finder window title
    shell %w[defaults write com.apple.finder _FXShowPosixPathInTitle -bool true]

    # When performing a search, search the current folder by default
    shell %w[defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"]
    # Avoid creating .DS_Store files on network volumes
    shell %w[defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true]

    # Enable AirDrop over Ethernet and on unsupported Macs running Lion
    shell %w[defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true]

    # Enable the MacBook Air SuperDrive on any Mac
    sudo %w[nvram boot-args="mbasd=1"]

    # Set the icon size of Dock items to 36 pixels
    shell %w[defaults write com.apple.dock tilesize -int 36]

    # Minimize windows into their application’s icon
    shell %w[defaults write com.apple.dock minimize-to-application -bool true]
    # Show indicator lights for open applications in the Dock
    shell %w[defaults write com.apple.dock show-process-indicators -bool true]

    # Wipe all (default) app icons from the Dock
    # This is only really useful when setting up a new Mac, or if you don’t use
    # the Dock to launch apps.
    # FIXME: only if one of the default apps is there (like Garageband)
    shell %w[defaults write com.apple.dock persistent-apps -array]

    # Don’t animate opening applications from the Dock
    shell %w[defaults write com.apple.dock launchanim -bool false]

    # Speed up Mission Control animations
    shell %w[defaults write com.apple.dock expose-animation-duration -float 0.1]

    # Don’t show Dashboard as a Space
    shell %w[defaults write com.apple.dock dashboard-in-overlay -bool true]

    # Don’t automatically rearrange Spaces based on most recent use
    shell %w[defaults write com.apple.dock mru-spaces -bool false]

    # Remove the auto-hiding Dock delay
    shell %w[defaults write com.apple.dock autohide-delay -float 0]
    # Remove the animation when hiding/showing the Dock
    shell %w[defaults write com.apple.dock autohide-time-modifier -float 0]

    # Enable Safari’s debug menu
    shell %w[defaults write com.apple.Safari IncludeInternalDebugMenu -bool true]

    # Make Safari’s search banners default to Contains instead of Starts With
    shell %w[defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false]

    # Remove useless icons from Safari’s bookmarks bar
    shell %w[defaults write com.apple.Safari ProxiesInBookmarksBar "()"]

    # Enable the Develop menu and the Web Inspector in Safari
    shell %w[defaults write com.apple.Safari IncludeDevelopMenu -bool true]
    shell %w[defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true]
    shell %w[defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true]

    # Add a context menu item for showing the Web Inspector in web views
    shell %w[defaults write NSGlobalDomain WebKitDeveloperExtras -bool true]

    # Only use UTF-8 in Terminal.app
    shell %w[defaults write com.apple.terminal StringEncodings -array 4]
    # Prevent Time Machine from prompting to use new hard drives as backup volume
    shell %w[defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true]

    # Disable local Time Machine backups
    shell 'bash', '-c',  'hash tmutil &> /dev/null && sudo tmutil disablelocal'

    # Use plain text mode for new TextEdit documents
    shell %w[defaults write com.apple.TextEdit RichText -int 0]
    # Open and save files as UTF-8 in TextEdit
    shell %w[defaults write com.apple.TextEdit PlainTextEncoding -int 4]
    shell %w[defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4]

    # Enable the debug menu in Disk Utility
    shell %w[defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true]
    shell %w[defaults write com.apple.DiskUtility advanced-image-options -bool true]

    # Enable the WebKit Developer Tools in the Mac App Store
    shell %w[defaults write com.apple.appstore WebKitDeveloperExtras -bool true]

    # Enable Debug Menu in the Mac App Store
    shell %w[defaults write com.apple.appstore ShowDebugMenu -bool true]

    # Messages: Disable smart quotes as it’s annoying for messages that contain code
    shell %w[defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false]

    # Messages: Disable continuous spell checking
    shell %w[defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false]

    # Allow installing user scripts via GitHub or Userscripts.org
    # FIXME: make sure Chrome is installed first
    shell %w[defaults write com.google.Chrome ExtensionInstallSources -array "https://*.github.com/*" "http://userscripts.org/*"]
    shell %w[defaults write com.google.Chrome.canary ExtensionInstallSources -array "https://*.github.com/*" "http://userscripts.org/*"]
  }
end

dep 'system name set', :name do
  name.default! 'Cort'

  met? { shell('hostname -s') == name }
  meet {
    sudo *%w[scutil --set ComputerName], name
    sudo *%w[scutil --set HostName], name
    sudo *%w[scutil --set LocalHostName], name
    sudo *%w[defaults write
      /Library/Preferences/SystemConfiguration/com.apple.smb.server
       NetBIOSName -string], name
  }
end
