#! /bin/bash

CURRENT_DIR=$(cd "$(dirname "$0")";pwd)
cd $CURRENT_DIR/../; rebar3 eunit
