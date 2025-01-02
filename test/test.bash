#!/bin/bash

set -e  # エラーが発生したらスクリプトを停止
set -x  # 実行されるコマンドを表示

# 引数の確認
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <ros2_workspace_root>"
  exit 1
fi

ROS2_WS="$1"

# ROS2ワークスペースのセットアップ
source /opt/ros/foxy/setup.bash  # 必要に応じてROSのバージョンを変更
cd "$ROS2_WS"
colcon build  # ワークスペースをビルド
source install/setup.bash

# テストノードの起動
ros2 run homework2 weather_publisher &  # weather_publisherノードをバックグラウンドで起動
PUBLISHER_PID=$!

# テストの実行
sleep 5  # weather_publisherがメッセージをパブリッシュするのを待機
echo "Checking for published messages..."

# トピックの確認
OUTPUT=$(ros2 topic echo /weather_info --once)

# 結果の検証
if echo "$OUTPUT" | grep -q "現在の天気"; then
  echo "Test passed: Weather information published successfully."
else
  echo "Test failed: No weather information published."
  kill $PUBLISHER_PID
  exit 1
fi

# ノードを終了
kill $PUBLISHER_PID
echo "Test completed successfully."

