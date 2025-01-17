# SPDX-FileCopyrightText: 2025 Yusuke Matsumoto s23c1134bg@s.chibakoudai.jp
# SPDX-License-Identifier: BSD-3-Clause
import rclpy
from rclpy.node import Node
from std_msgs.msg import String
import requests
import json

class WeatherPublisher(Node):
    def __init__(self):
        super().__init__('weather_publisher')
        self.publisher_ = self.create_publisher(String, 'weather_info', 10)
        timer_period = 1.0  # 1秒ごとに天気情報を表示
        self.timer = self.create_timer(timer_period, self.publish_weather_info)
        self.api_key = '387c1a9825674184050a1f5a269bc9cb'  # OpenWeatherMapから取得したAPIキーはここに入力
        self.location = 'Narashino,JP'  # 天気を確認したい場所の地名をここで指定

    def fetch_weather_info(self):
        url = f'http://api.openweathermap.org/data/2.5/weather?q={self.location}&appid={self.api_key}&lang=ja&units=metric' #パラメータ付与したURLにより、上記で指定した都市における現在の天気を取得するAPIをコールする
        try:
            response = requests.get(url)
            if response.status_code == 200:
                weather_data = response.json()
                description = weather_data['weather'][0]['description']
                temp = weather_data['main']['temp']
                humidity = weather_data['main']['humidity']
                return f'指定地点の現在の天気は: {description}, 温度は: {temp}°C, 湿度は: {humidity}% となっております。yeah'
            else:
                self.get_logger().error(f'Error fetching weather data: {response.status_code}')
                return '天気情報の取得に失敗しました………'
        except Exception as e:
            self.get_logger().error(f'Exception occurred: {e}')
            return '天気情報の取得中にエラーが発生してしまいました………'

    def publish_weather_info(self):
        weather_info = self.fetch_weather_info()
        msg = String()
        msg.data = weather_info
        self.publisher_.publish(msg)

def main(args=None):
    rclpy.init(args=args)
    weather_publisher = WeatherPublisher()
    try:
        rclpy.spin(weather_publisher)
    except KeyboardInterrupt:
        pass
    finally:
        weather_publisher.destroy_node()
        rclpy.shutdown()

if __name__ == '__main__':
    main()


