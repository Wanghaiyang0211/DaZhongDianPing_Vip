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

left_pull=$(($height/4))
left_push=$(($height/8))

# screen shot
for i in $(seq 1 10) 
do
    adb shell "/system/bin/screencap -p /storage/emulated/0/DCIM/screenshot.png"
    adb pull "/storage/emulated/0/DCIM/screenshot.png" "../images/${i}.png"
    adb shell input swipe $(($width/2)) $(($height-$left_pull)) $(($width/2)) $left_pull 500
    sleep 1
done
adb shell input swipe $(($width/2)) $left_push $(($width/2)) $(($height-$left_push)) 50
sleep 1
adb shell input swipe $(($width/2)) $left_push $(($width/2)) $(($height-$left_push)) 50
sleep 1

if [[ $flag == *false* ]]; then   
    # lock
    adb shell input keyevent 26
fi

