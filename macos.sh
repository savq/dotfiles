#!/bin/sh

## Dock

# defaults delete com.apple.dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock mineffect -string scale
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock launchanim -bool false
killall Dock


## Finder

# defaults delete com.apple.finder
defaults write com.apple.finder FXPreferredViewStyle -string Nlsv
defaults write com.apple.finder FXRemoveOldTrashItems  -bool true
defaults write com.apple.finder NewWindowTarget -string PfHm
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder _FXSortFoldersFirst  -bool true
killall Finder


## Itsycal

if [ -f "$HOME/Library/Preferences/com.mowglii.ItsycalApp.plist" ]
then
    # defaults delete com.mowglii.ItsycalApp
    defaults write com.mowglii.ItsycalApp BeepBeepOnTheHour -bool true
    defaults write com.mowglii.ItsycalApp ClockFormat -string 'Y-MM-dd EEEEE HH:mm'
    defaults write com.mowglii.ItsycalApp HideIcon -bool true
    defaults write com.mowglii.ItsycalApp HighlightedDOWs -int 65
    defaults write com.mowglii.ItsycalApp MoCalendarNumRows  -int 10
    defaults write com.mowglii.ItsycalApp SizePreference -int 1
    defaults write com.mowglii.ItsycalApp WeekStartDOW -int 1

    ## Hide default clock when using Itsycal
    defaults write com.apple.menuextra.clock IsAnalog -bool true
fi

## Trackpad

defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
