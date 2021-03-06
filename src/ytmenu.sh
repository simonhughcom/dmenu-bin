#!/bin/sh

# Search using various search engines
# Can search using primary selection

# file to save search history to
# keep it in /run to make it non persistant
hfile="$XDG_RUNTIME_DIR/youtube_watch_history"

# if hfile file doesent exist make it
[ -f "$hfile" ] || touch "$hfile"

# get primary selection and history from $hfile and pass into dmenu
url=$(echo "$(xclip -sel clip)" | tac - $hfile | awk 'NF' | dmenu -i -l 10 -p "URL: ") || exit 1

#pass url to ytp script
ytp $url

# append url to fistory file
echo "$url" >> $hfile
