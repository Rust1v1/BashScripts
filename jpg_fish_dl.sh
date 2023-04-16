#!/bin/bash

# Download all the images from a jpg fish album

[[ $# -eq 2 ]] || echo "Please Provide a link to the album first, then the prefix for the downloaded file names as CLArgs" && exit 1

ALBUM_URL=$1
PREFIX=$2

# Get all the image links
LINKS=$(curl $ALBUM_URL | rg -o "<img src=\"https://simp6\.jpg\.church/images/\S+\.jpg\"" | awk -F "=" '{print $2}')

let counter=0

for l in $LINKS; do
    link=$(echo $l | sed -e 's/^"//' -e 's/"$//')
    wget ${link} -O ${PREFIX}_${counter}.jpg
    let counter=counter+1
done
