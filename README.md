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

# 1.1
- [x] Fixed an issue where the plugin had started but the hostname was not yet loaded into convar `hostname`
- [x] Fixed an issue where the `{{timeleft}}` was not being changed if it was at the beginning of the hostname
- [x] Increased speed by using `FormatEx` instead of `Format`

# 1.0
- [x] Initial Release.
