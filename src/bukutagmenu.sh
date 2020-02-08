#!/bin/sh

# Give a list of tags for bookmarks to search and open them in current browser

choice="$(buku --np --stag | sed '/^.* [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] .*$/d' | awk '{printf "%s %s\n",$2,$3}' | dmenu -i -l 10 | awk '{print $1}')"

# if nothing is chosen then exit
[ "$choice" != "" ] || exit

bukumenu -t "$choice"
