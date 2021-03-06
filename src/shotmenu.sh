#!/bin/sh

# SHOTMENU
# Simon H Moore
# 
# Takes a screenshot or opens screenshot from screenshot dir using dmenu.
# 
# Requires dmenu, scrot and sxiv to work.

screenshot() {
    # Gives a list of screen shot options:

    # Get user choice
    choice=$(echo "Window\nSelect" | dmenu -p "choose")

    # Perform chosen screen shot
    case "$choice" in 
        Window) shot -u && exit & ;; # screenshot currently focused window
        Select) shot -s && exit & ;; # screenshot selected area
    esac
}

list() {
    # list all screenshots and open selected screenshot in sxiv
    shots_dir=~/Pictures/shots/
    
    # get choice of screenshot
    choice=$(ls -r $shots_dir | dmenu -i -l 10) || exit

    # open selected screenshot in sxiv
    sxiv "$shots_dir/$choice"
}


case "$1" in
    list | -l) list;;
    screenshot | -s) screenshot;;
esac
