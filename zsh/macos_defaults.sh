# ========== Keybord modifier ==========
#defaults -currentHost read  -g   
#keyboard_vid=$(ioreg -n 'Apple Internal Keyboard' -r | grep -E 'idVendor' | awk '{ print $4 }'); echo ${keyboard_vid}
#keyboard_pid=$(ioreg -n 'Apple Internal Keyboard' -r | grep -E 'idProduct' | awk '{ print $4 }')
#keyboardid="${keyboard_vid}-${keyboard_pid}-0"
## Capls Lock キーを control キーにする．
#defaults -currentHost write -g com.apple.keyboard.modifiermapping.${keyboardid} -array-add '<dict><key>HIDKeyboardModifierMappingDst</key><integer>30064771300</integer><key>HIDKeyboardModifierMappingSrc</key><integer>30064771129</integer></dict>'
# osascript  fix_control_key.scpt 
# read -p "システム環境設定>セキュリティとプライバシ>プライバシー>アクセシビリティ にて、ターミナルからのアプリケーションの制御を許可してください"
# osascript  fix_control_key.scpt

# ========== General ==========
defaults write "Apple Global Domain" com.apple.mouse.scaling 3
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 15
defaults write -g NSDocumentRevisionsWindowTransformAnimation -bool false
defaults write -g QLPanelAnimationDuration -float 0
defaults write -g QLPanelAnimationDuration -float 0.10

# ========== Dock ==========
## size
defaults write com.apple.dock tilesize -int 32

## position
defaults write com.apple.dock orientation -string "left"

## autohide
defaults write com.apple.dock autohide -bool true

## animate opening application
defaults write com.apple.dock launchanim -bool false

## Show indicators for open applications
defaults write com.apple.dock show-process-indicators -bool true

##  Minimize windows into application icon
defaults write com.apple.dock minimize-to-application -bool true

# ========== Dock ==========
## disabble drop shadow
defaults write com.apple.screencapture disable-shadow true

## change default filename
defaults write com.apple.screencapture name "Screen Shot"

defaults write com.apple.dock position-immutable -boolean true

# ========== Finder ==========
defaults write com.apple.finder DisableAllAnimations -boolean true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.finder PathBarRootAtHome -bool yes

# ========== Siri ==========

## Siri icon on menu ber
defaults write com.apple.Siri StatusMenuVisible -bool false

# ========== killall ==========
killall Dock
killall Finder
killall cfprefsd
killall SystemUIServer
