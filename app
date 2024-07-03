#!/bin/bash

if [ -f ./.env ]; then
  . .env
else
  echo '.env file not found, please run `make env`'
  exit 1
fi

port=3000
path=$HANDBOOK_PATH
if [ "$2" = "spec" ]; then
  port=4000
  path=$SPEC_PATH
fi
if [ "$2" = "midyear" ]; then
  port=5000
  path=$MIDYEAR_PATH
fi
if [ "$2" = "final" ]; then
  port=5000
  path=$FINAL_PATH
fi

make $1 path="$path" port=$port
