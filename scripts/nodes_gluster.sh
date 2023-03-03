#!/bin/bash

MASTERHOST=$1

echo $MASTERHOST

# Check if "master" machine is running
if [ "$(vagrant status | grep 'node3' | awk '{print $2}')" == "running" ]; then
    vagrant ssh node1 -- -t "sudo mount.glusterfs localhost:/gv0 /mnt;exit"
    vagrant ssh node2 -- -t "sudo mount.glusterfs localhost:/gv0 /mnt;exit"
else
    echo "Master machine is not running."
fi
