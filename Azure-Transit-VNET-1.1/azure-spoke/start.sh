#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
apt-get update &&
apt-get install -y python-pip &&
pip install applicationinsights &&
#export these as environment variables?
echo $1 >> temp_appinsights.key
./publish.py $1 &&
sleep 60 && 
shutdown --no-wall -P +30
