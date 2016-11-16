### Build Status
[![Build status](https://travis-ci.org/AzaZPPL/Timeleft-in-Hostname.svg?branch=master)](https://travis-ci.org/AzaZPPL/Timeleft-in-Hostname)

# Timeleft in Hostname
Shows the time left in the servers hostname

# Requirements:
* [SourceMod 1.8 and above](http://www.sourcemod.net/downloads.php)

# Installation:
1. Copy the .smx to your addons/sourcemod/plugins folder.
2. Restart your server.
3. Change settings in cfg/sourcemod/plugin.timeleft-in-hostname.cfg

# Usage:
You can either add `{{timeleft}}` in your hostname and it will replace it with the time thats left
Or you dont add anything and it will put the timeleft add the end of the hostname.

# Changelog:
These are the changes
## 1.4
- [x] New: when server is hibernating fallback to `mp_timelimit`
- [x] Fix: when a map change occurs the timer would not stop and would infinitely add more timers
- [x] Fix: when a map change occurs the time would not be set fast enough so you would see `{{timeleft}}` or no time.

## 1.3
- [x] New: when the time is lower than 0 or is not set it will return the values back to `00:00`
- [x] Fix: Fix the strange `29:58 15:23` issue

## 1.2
- [x] Fix: Timeleft would get the wrong hostname after a map restart was initiated.

## 1.1
- [x] Fixed an issue where the plugin had started but the hostname was not yet loaded into convar `hostname`
- [x] Fixed an issue where the `{{timeleft}}` was not being changed if it was at the beginning of the hostname
- [x] Increased speed by using `FormatEx` instead of `Format`

## 1.0
- [x] Initial Release.
