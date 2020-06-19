#!/bin/bash

set -e

erb /etc/consul.json.erb > /etc/consul.json

exec consul agent -config-file /etc/consul.json
