#!/bin/bash
# confd.sh

# need download confd, then add it to path
confd -confdir="./confd" -config-file="./confd/conf.d/config.toml" -onetime=false -interval=2 -backend consul -node 127.0.0.1:8500
