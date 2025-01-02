#!/bin/bash

set -e  # エラーが発生したらスクリプトを停止

cd /root/ros2_ws
source /opt/ros/humble/setup.bash

# パッケージのビルド
colcon build --symlink-install --packages-select homework2
if [ $? -ne 0 ]; then
  echo "Build failed: Could not build the homework2 package."
  exit 1
fi

# ビルド後のセットアップ
source install/setup.bash

# テストの実行
colcon test --packages-select homework2
colcon test-result --all || true

# ノードの起動とテスト
echo "Running WeatherPublisher node test..."
ros2 launch homework2 talk_listen.launch.py &  # ノードをバックグラウンドで起動
NODE_PID=$!

sleep 5

# 起動中のノード確認
ros2 node list | grep 'weather_publisher' > /dev/null
if [ $? -ne 0 ]; then
  echo "Test failed: WeatherPublisher node is not running."
  kill -9 $NODE_PID || true
  exit 1
fi

# トピック確認
if ros2 topic list | grep '/weather_info' > /dev/null; then
  if ros2 topic echo /weather_info --once; then
    echo "Test passed: WeatherPublisher is publishing weather_info."
  else
    echo "Test failed: No messages were published on /weather_info."
    kill -9 $NODE_PID || true
    exit 1
  fi
else
  echo "Test failed: /weather_info topic does not exist."
  kill -9 $NODE_PID || true
  exit 1
fi

kill -9 $NODE_PID || true
echo "Tests completed successfully."
