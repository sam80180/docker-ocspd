#!/bin/bash

# timezone
DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
echo "Asia/Taipei" > /etc/timezone
rm -f /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Taipei /etc/localtime
dpkg-reconfigure -f noninteractive tzdata

sed -i "s/\[supervisord\]/\[supervisord\]\nnodaemon=true\n/" /etc/supervisor/supervisord.conf

# clean
rm -f $0 ~/.bash_history ; exit

