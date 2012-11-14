#! /usr/bin/env sh
dos2unix $1
gawk -f convert.awk $1
