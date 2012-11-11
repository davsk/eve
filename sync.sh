#! /usr/bin/env bash

go build
scp ./eve root@dasa.cc:var/eve/eve.replace
rsync -av --delete res/ root@dasa.cc:var/eve/res/
rsync -av --delete views/ root@dasa.cc:var/eve/views/
ssh root@dasa.cc "gostart eve"
