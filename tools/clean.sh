#! /bin/bash

CURRENT_DIR=$(cd "$(dirname "$0")";pwd)
cd $CURRENT_DIR/../; rm -rf ./_build; rm -rf ./rebar.lock
