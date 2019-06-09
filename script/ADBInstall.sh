#!/bin/bash

# install adb
if command -v adb >/dev/null 2>&1; then
    echo 'exists adb'
else 
    echo 'adb installing...'
    sudo apt-get update
    sudo apt-get install android-tools-adb
    echo 'adb install finish'
fi