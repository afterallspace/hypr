#!/bin/bash

if [ "$1" == "start" ]; then
    /usr/bin/powerprofilesctl set performance
    /usr/bin/nvidia-smi -pm 1
    /usr/bin/nvidia-smi -lgc 450,1450
elif [ "$1" == "stop" ]; then
    /usr/bin/powerprofilesctl set balanced
    /usr/bin/nvidia-smi -rgc
    /usr/bin/nvidia-smi -pm 0
fi
