#!/bin/bash

set -e

CONFIG_FILE='/etc/consul.json'

erb /etc/consul.json.erb > "$CONFIG_FILE"

exec consul agent -config-file "$CONFIG_FILE"
