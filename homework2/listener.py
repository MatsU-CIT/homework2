# SPDX-FileCopyrightText: 2025 Yusuke Matsumoto s23c1134bg@s.chibakoudai.jp
# SPDX-License-Identifier: BSD-3-Clause
import rclpy
from rclpy.node import Node
from std_msgs.msg import String

class WeatherSubscriber(Node):
    def __init__(self):
        super().__init__('weather_subscriber')
        self.subscription = self.create_subscription(
            String,
            'weather_info',
            self.weather_callback,
            10
        )
        self.subscription

    def weather_callback(self, msg):
        self.get_logger().info(f'受信した天気情報は次の通りです: "{msg.data}"')

def main(args=None):
    rclpy.init(args=args)
    weather_subscriber = WeatherSubscriber()
    try:
        rclpy.spin(weather_subscriber)
    except KeyboardInterrupt:
        pass
    finally:
        weather_subscriber.destroy_node()
        rclpy.shutdown()

if __name__ == '__main__':
    main()
