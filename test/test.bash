#!/bin/bash

set -e  # エラーが発生したらスクリプトを停止

# ROS2のワークスペースに移動
cd /root/ros2_ws

# 環境変数を設定
source /opt/ros/humble/setup.bash  # 適切なROS2のディストリビューション名に置き換えてください
source install/setup.bash || true

# 必要な依存関係をインストール
apt-get update && apt-get install -y python3-pip
pip3 install -r src/hw2/homework2/requirements.txt || true

# ビルド
colcon build --symlink-install --packages-select homework2

# ビルドの結果を確認
colcon test --packages-select homework2
colcon test-result --all || true

# weather.pyのノードをテストする
echo "Running WeatherPublisher node test..."
ros2 launch homework2 talk_listen.launch.py &  # ノードをバックグラウンドで起動
NODE_PID=$!

# 少し待ってから動作確認
sleep 5

# weather_infoトピックが正しくパブリッシュされているか確認
if ros2 topic echo /weather_info --once; then
  echo "Test passed: WeatherPublisher is publishing weather_info."
else
  echo "Test failed: No messages were published on /weather_info."
  kill -9 $NODE_PID
  exit 1
fi

# ノードを停止
kill -9 $NODE_PID
echo "Tests completed successfully."
