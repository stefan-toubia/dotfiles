#!/bin/bash

# Restart Cursor with a fresh shell environment
# Only closes the current project window, not all Cursor instances
# Requires accessibility permissions for System Events

# Close current window gracefully using keyboard shortcut
osascript -e 'tell application "System Events" to tell process "Cursor" to keystroke "w" using {command down, shift down}' 2>/dev/null
(
	sleep 1
	zsh -ic 'cursor .'
) &
