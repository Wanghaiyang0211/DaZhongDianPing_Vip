#!/bin/bash

# get screen resolution
resolu=$(adb shell wm size)
width=$(expr "$resolu" : '.*\ \(.*\)\x')
height=$(expr "$resolu" : '.*\x\(.*\)')
echo $resolu
echo $width
echo $height

# judge if the screen is power on/off
flag=$(adb shell dumpsys window policy|grep mScreenOnFully)
flag=$(expr "$flag" : '.*\mScreenOnFully=\(.*\)')

if [ "$flag"x = "false"x ]; then
    # unlock
    adb shell input keyevent 26
    adb shell input swipe $(($width/2)) $height $(($width/2)) 0
fi

left_pull=$(($height/4))
left_push=$(($height/8))
# screen shot
adb shell "/system/bin/screencap -p /storage/self/primary/screenshot.png"
adb pull "/storage/self/primary/screenshot.png" "../images/1.png"
adb shell input swipe $(($width/2)) $(($height-$left_pull)) $(($width/2)) $left_pull
adb shell "/system/bin/screencap -p /storage/self/primary/screenshot.png"
adb pull "/storage/self/primary/screenshot.png" "../images/2.png"
adb shell input swipe $(($width/2)) $left_push $(($width/2)) $(($height-$left_push))

if [ "$flag"x = "false"x ]; then
    # lock
    adb shell input keyevent 26
fi

