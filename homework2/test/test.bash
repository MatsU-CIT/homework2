#!/bin/bash
set -e

# ROS 2 ワークスペースのセットアップ
source /opt/ros/humble/setup.bash
source $1/ros2_ws/install/setup.bash

# 必要なディレクトリへ移動する
cd $1/ros2_ws

# ビルド
colcon build --packages-select homework2

# ビルド結果をソース
source install/setup.bash

# テスト用ROS 2ノードをバックグラウンドで起動
ros2 run homework2 weather_publisher &
NODE_PID=$!

# ノード起動まで待機
sleep 5

# weather_infoトピックが正しく動作しているかの確認
RESULT=$(timeout 10 ros2 topic echo /weather_info -n 1)

# 取得したデータを確認
if echo "$RESULT" | grep -q "指定地点の現在の天気は:"; then
  echo "Weather node test passed."
  kill $NODE_PID
  exit 0
else
  echo "Weather node test failed."
  kill $NODE_PID
  exit 1
fi

