#!/bin/bash
set -e

# ROS 2 ワークスペースのセットアップ
source /opt/ros/humble/setup.bash
source ~/ros2_ws/install/setup.bash

# 必要なディレクトリへ移動
cd ~/ros2_ws

# ビルド確認
colcon build --packages-select homework2

# ビルド後のワークスペースをソース
source install/setup.bash

# weather_publisherノードをバックグラウンドで起動
ros2 run homework2 weather_publisher &
NODE_PID=$!

# ノードの起動確認用に少し待機
sleep 5

# weather_infoトピックからデータを受信して確認
RESULT=$(timeout 10 ros2 topic echo /weather_info -n 1)

# 取得したデータに期待される文字列が含まれているか確認
if echo "$RESULT" | grep -q "指定地点の現在の天気は:"; then
  echo "Weather node test passed."
  kill $NODE_PID
  exit 0
else
  echo "Weather node test failed."
  kill $NODE_PID
  exit 1
fi

