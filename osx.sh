#!/bin/sh
#
# OS X setup
#
# Sources:
#  https://github.com/ptb/Mac-OS-X-Lion-Setup/blob/master/setup.sh
#  https://github.com/mathiasbynens/dotfiles/blob/master/.osx
#  http://osxnotes.net/defaults.html
#
# Reference
#  defaults read [domain [key]]
#  defaults write domain { plist | key 'value' }
#  /usr/bin/osascript -e 'tell application "System Events" to tell appearance preferences to get properties'

#############################################################################
# Utility Functions
#############################################################################

# h1(), h2(), h3() : Headers
	function h1()  { echo "\n\033[1m\033[4m$@\033[0m"; }
	function h2()  { echo "\n \033[1m$@\033[0m"; }
	function h3()  { echo "\n  $@"; }
# log(exit, message) : Log success/failure
	function log() {
		local exit=$1
		if [[ $exit -eq 0 ]];	then
			echo "  \033[32m✔\033[0m $2"
		else
			echo "  \033[1;31m✖\033[0m $2"
		fi
	}
# set_default(domain, key, type, value) : Change preference showing both before/after values
	function set_default () {
		local before=`/usr/bin/defaults read $1 $2 2>/dev/null`
		if [[ "$before" == "$4" ]]; then
			echo "    \033[2m$2\033[0m"
		else
			/usr/bin/defaults write "$@" #quote so bash doesn't expand string values with spaces
			log $? "$2 \033[2m$before ➜ $4\033[0m"
		fi
	}
# set_appearance(property, value) : Change appearance preferance via AppleScript
	function set_appearance () {
		local before=$(/usr/bin/osascript -e 'tell application "System Events" to tell appearance preferences to get '"$1" 2>/dev/null)
		if [[ "$before" == "$2" ]]; then
			echo "    \033[2m$1\033[0m"
		else
			/usr/bin/osascript -e 'tell application "System Events" to tell appearance preferences to set '"$1"' to '"$2"
			log $? "$1 \033[2m$before ➜ $2\033[0m"
		fi
	}

#############################################################################
# System Preferences
#############################################################################
h1 "System Preferences"
	h2 "General"
		# Appearance
			#	1 - Blue (default)
			#	6 - Graphite
			set_default -g 'AppleAquaColorVariant' -int 1
		# Highlight color
			# Graphite
			# Sliver
			# Blue (default) - "0.709800 0.835300 1.000000"
			# Gold
			# Red
			# Orange
			# Green
			# Purple
			# Other ...
			set_default -g 'AppleHighlightColor' -string "0.709800 0.835300 1.000000"
		# Sidebar icon size
			# 1 - Small
			# 2 - Medium (default)
			# 3 - Large
			set_default -g 'NSTableViewDefaultSizeMode' -int 2
		# Show scroll bars
			# 'Automatic' (default)
			# 'WhenScrolling'
			# 'Always'
    	set_default -g 'AppleShowScrollBars' -string 'Automatic'
    # Click in the scroll bar to
    	# 0 - jump to next page (default)
    	# 1 - jump to here
    	set_default -g 'AppleScrollerPagingBehavior' -int 0
    # Ask to keep chenges when closing documents
    	# 0 - no (default)
    	# 1 - yes
    	set_default -g 'NSCloseAlwaysConfirmsChanges' -int 0
    # Close windows when quitting an application
    	# NOTE: careful, the text and setting are opposite
    	# 0 - Close windows (default)
    	# 1 - Keep windows
    	set_default -g 'NSQuitAlwaysKeepsWindows' -int 0
    # Recent items
    	# Default for all is 10
			set_appearance "recent documents limit" 10
			set_appearance "recent applications limit" 10
			set_appearance "recent servers limit" 10
    # Use LCD font smoothing when available
    	# true (default)
    	# false
    	set_appearance "font smoothing" true
    # TODO: Needs research - font smoothing, smooth scrolling
			# font smoothing limit:0, 
			# font smoothing style:automatic, 
			# smooth scrolling:true, 
	h2 "Desktop & Screen Saver"
		h3 "Desktop"
			# NOTE: not much here intentionally since I use images/iPhoto backgrounds
			#				See ptb's repo for example of solid color background

			# Translucent menu bar
				# 0 - off
				# 1 - on (default)
				set_default -g 'AppleEnableMenuBarTransparency' -int 1
		h3 "Screen Saver"
			# Screen Saver
				# NOTE: screen saver turned off, let power mgmt deal with this
				/usr/bin/defaults -currentHost write com.apple.screensaver '{ idleTime = 0; moduleDict = { moduleName = "Computer Name"; path = "/System/Library/Frameworks/ScreenSaver.framework/Resources/Computer Name.saver"; type = 0; }; }';
				log $? "Turned off"
		h3 "Hot Corners"
			# Bottom Left: sleep
				# TODO: document possible values
		    set_default com.apple.dock 'wvous-bl-corner' -int 10
		    set_default com.apple.dock 'wvous-bl-modifier' -int 0
	h2 "Dock"
		# Size
			# small (16) - large (128)
			# TODO: double check the default
			set_default com.apple.dock 'tilesize' -int 32
		# Magnification
			# 0 - off
			# 1 - on (default)
			set_default com.apple.dock 'magnification' -int 0
			# min (16) - max (128)
			# TODO: what is the default
			set_default com.apple.dock 'largesize' -int 64
		# Position on screen
			# left
			# bottom (default)
			# right
			set_default com.apple.dock 'orientation' -string 'left'
		# Minimize windows using
			# genie - Genie effect (default)
			# scale - Scale effect
			set_default com.apple.dock 'mineffect' -string 'genie'
		# Double-click window title bar to minimize
			# 0 - no (default)
			# 1 - yes
			set_default -g 'AppleMiniaturizeOnDoubleClick' -int 0
		# Minimize windows into application icon
			# 0 - no (default)
			# 1 - yes
			set_default com.apple.dock 'minimize-to-application' -int 0
		# Animate opening applications
			# 0 - no
			# 1 - yes (default)
			set_default com.apple.dock 'launchanim' -int 1
		# Automatically hide and show the Dock
			# 0 - no (default)
			# 1 - yes
			set_default com.apple.dock 'autohide' -int 1
		# Show indicator lights for open applications
			# 0 - no
			# 1 - yes (default)
			set_default com.apple.dock 'show-process-indicators' -int 1
	h2 "Misson Control"
		# TODO: double check all defaults here
		# Show Dashboard as a Space
			# 0 - show (default)
			# 1 - hide
			set_default com.apple.dock 'dashboard-in-overlay' -int 1
		# Automatically rearrange Spaces based on most recent use
			# 0 - no
			# 1 - yes (default)
			set_default com.apple.dock 'mru-spaces' -int 1
		# When switching to an application, switch to a Space with open windows
			# 0 - no
			# 1 - yes (default)
			# TODO -- set_default ?
		# Group windows by application
			# 0 - no
			# 1 - yes (default)
			set_default com.apple.dock 'expose-group-by-app' -int 1
		# Displays have separate Spaces
			# 0 - no
			# 1 - yes (default)
			# TODO - set_default ?


	# h2 "Language & Region"
	# h2 "Security & Privacy"
	# h2 "Spotlight"
	# h2 "Notifications"
	# h2 "Displays"
	# h2 "Energy Saver"
	# h2 "Keyboard"
	# h2 "Mouse"
	# h2 "Trackpad"
	# h2 "Printers & Scaners"
	# h2 "Sound"
	# h2 "iCloud"
	# h2 "Internet Accounts"
	# h2 "Network"
	# h2 "Bluetooth"
	# h2 "Sharing"
	# h2 "Users & Groups"
	# h2 "Parental Controls"
	# h2 "App Store"
	# h2 "Dictation & Speech"
	# h2 "Date & Time"
	# h2 "Startup Disk"
	# h2 "Time Machine"
	# h2 "Accessibility"

#############################################################################
# Hidden Settings
#############################################################################

# h1 "Hidden Settings"


