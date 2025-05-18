#!/bin/bash

while true; do
    timeout -k 6h 6h /home/pwn/server $1 &> /dev/null
    pkill -9 -f "/home/pwn/server"
    sleep 1
done