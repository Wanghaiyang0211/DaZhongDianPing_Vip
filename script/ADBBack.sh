#!/bin/bash

# get screen resolution
resolu=$(adb shell wm size)
width=$(expr "$resolu" : '.*\: \(.*\)\x')
height=$(expr "$resolu" : '.*\x\(.*\)')

if [ ! $width -o ! $height ]; then
  echo "resolution is NULL, please check is devices is connected"
  exit
fi

width=`echo "$width" | tr -cd "[0-9]" `
height=`echo "$height" | tr -cd "[0-9]" `

# judge if the screen is power on/off
flag=$(adb shell dumpsys window policy|grep mScreenOnFully)

if [[ $flag == *false* ]]; then
    # unlock
    adb shell input keyevent 26
    adb shell input swipe $(($width/2)) $(($height/2)) $(($width/2)) $(($height/4))
    adb shell input swipe $(($width/2)) $(($height/6)) $(($width/2)) $(($height/2))
fi

adb shell input keyevent 4
adb shell input swipe $(($width/2)) $(($height/6)) $(($width/2)) $(($height/2)) 50
adb shell input swipe $(($width/2)) $(($height/6)) $(($width/2)) $(($height/2)) 50

if [[ $flag == *false* ]]; then
    # lock
    adb shell input keyevent 26
fi

