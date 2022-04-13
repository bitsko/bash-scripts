#!/usr/bin/env bash

if [[ -z $(command -v zip) ]]; then echo "install zip" ; exit 1; fi
if [[ -z $(command -v exiftool) ]]; then echo "install exiftool" ; exit 1; fi

if [[ -z "$1" ]] || [[ -z "$2" ]]; then
        echo "./zipimg.sh imagename filename "$'\n'\
                "or ./zipimg.sh imagename filename -pw"$'\n'\
                "or ./zipimg.sh extract filename"
        exit 1
fi

if [[ -n "$3" ]] && [[ "$3" -ne "-pw" ]]; then echo "input error in third positional parameter"; exit 1; fi

wasConverted=0
wasZipped=0
theFile="$2"

if [[ "$1" == extract ]]; then
        cp "$theFile" "$theFile".zip
        unzip "$theFile".zip
        rm "$theFile".zip
        exit 0
else
        theImage="$1"
fi
if [[ $(exiftool  "$theImage"  | grep 'File Type Extension' | awk '{ print $5 }') != 'png' ]]; then
        read -p "Image is not a .png, would you like to convert it to one?" yn
                case $yn in
                        [Yy]* )   if [[ -z $(command -v convert) ]]; then echo "install imagemagick" ; exit 1;
                                else
                                        imgName=$(echo "$theImage" | awk -F. '{print $1}')
                                        convert "$theImage" "$imgName".png
                                        wasConverted=1
                                        theImage="$imgName".png
                                        echo "converted the image to $theImage"
                                fi;;
                        [Nn]* )    echo "aborting"; exit 1;;
                esac
fi

date=$(($(date +%s)*"$RANDOM"))

if [[ $(exiftool  "$theFile"  | grep 'File Type Extension' | awk '{ print $5 }') != 'zip' ]]; then
        echo "creating zip of $theFile"
        wasZipped=1
        if [[ "$3" == "-pw" ]]; then
                zip -er "$theFile$date".zip "$theFile"
                theFile="$theFile$date".zip
        else
                zip -r "$theFile$date".zip "$theFile"
                theFile="$theFile$date".zip
        fi
fi

if [[ "$wasConverted" == "1" ]]; then
        cat "$theImage" "$theFile" >> zip."$1".png
        rm "$theImage"
        echo "the file is zip.$1.png"
elif [[ "$wasConverted" == "0" ]]; then
        cat "$theImage" "$theFile" >> zip."$1"
        echo "the file is zip.$1"
fi
if [[ "$wasZipped" == "1" ]]; then
        rm "$theFile"
fi
