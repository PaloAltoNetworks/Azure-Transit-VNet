#!/bin/bash

apt-get update &&
apt-get install -y python-pip &&
pip install azure-cli applicationinsights &&
pip install azure-batch &&
pip install azure-mgmt-storage &&
pip install setuptools && 
pip install azure &&

mkdir /tmp/monitor
chmod 777 /tmp/monitor
cp monitor.py /tmp/monitor/monitor.py
chmod 777 /tmp/monitor/monitor.py

PARAM_FILE=/tmp/monitor/monitor.cfg
echo "[DEFAULT]" > $PARAM_FILE
echo "AZURE_SUBSCRIPTION_ID=$1" >> $PARAM_FILE
echo "AZURE_CLIENT_ID=$2" >> $PARAM_FILE
echo "AZURE_CLIENT_SECRET=$3" >> $PARAM_FILE
echo "AZURE_TENANT_ID=$4" >> $PARAM_FILE
echo "PANORAMA_IP=$5" >> $PARAM_FILE
echo "PANORAMA_API_KEY=$6" >> $PARAM_FILE
echo "LICENSE_DEACTIVATION_API_KEY=$7" >> $PARAM_FILE
echo "HUB_NAME=$8" >> $PARAM_FILE
echo "STORAGE_ACCT_NAME=$9" >> $PARAM_FILE

crontab -l > _tmp_file
echo "*/5 * * * * /tmp/monitor/monitor.py" >> _tmp_file
crontab _tmp_file
