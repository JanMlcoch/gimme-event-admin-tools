#!/usr/bin/env bash

sudo killall nginx
sudo ./nginx/sbin/nginx -c ./conf/nginx.conf -p ./nginx/
