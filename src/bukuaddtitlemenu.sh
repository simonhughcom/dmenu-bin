#!/bin/sh

# Add bookmark to buku with tags and title

URL=$(xclip -sel clip -o)


title=$(gethtmltitle "$URL" | dmenu -i -p "TITLE for $URL: ")

# if nothing is chosen then exit
[ "$title" != "" ] || exit

echo $title

tags=$(echo "FOR $URL" | dmenu -i -p "TAGS: ")

# if nothing is chosen then exit
[ "$tags" != "" ] || exit

echo $title
echo $tags

# if no title or tags are chosen then exit
[ "$title" != "FOR $URL" ] || exit
[ "$tags" != "FOR $URL" ] || exit

echo $title
echo $tags

bukuadd "$URL" "$tags" --title "$title"
