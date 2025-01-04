#!/bin/bash
# SPDX-FileCopyrightText: 2024 Yusuke Matsumoto s23c1134bg@s.chibakoudai.jp
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

cd $dir/ros2_ws
colcon build
source $dir/.bashrc
timeout 10 ros2 launch homework2 talk_listen.launch.py > /tmp/homework2.log

cat /tmp/homework2.log |
grep 'yeah'
