#!/bin/bash

dir=~
[ "$1" != "" ] && dir="$1"

cd $dir/ros2_ws
colcon build
source $dir/.bashrc
timeout 20 ros2 launch homework2 talk_listen.launch.py > /tmp/homework2.log

cat /tmp/homework2.log |
grep 'yeah'
