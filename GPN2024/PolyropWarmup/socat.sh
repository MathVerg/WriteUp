#!/bin/sh

socat -v TCP-LISTEN:14140,reuseaddr,fork EXEC:"./composer.py",stderr
