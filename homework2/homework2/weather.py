import rclpy
from rclpy.node import Node
from std_msgs.msg import String
import requests
import json

class WeatherPublisher(Node):
    def __init__(self):
        super().__init__('weather_publisher')
        self.publisher_ = self.create_publisher(String, 'weather_info', 10)
        timer_period = 10.0  # 10秒ごとに更新
        self.timer = self.create_timer(timer_period, self.publish_weather_info)
        self.api_key = '387c1a9825674184050a1f5a269bc9cb'  # OpenWeatherMapのAPIキー
        self.location = 'Chiba,JP'  # 地名を指定

    def fetch_weather_info(self):
        url = f'http://api.openweathermap.org/data/2.5/weather?q={self.location}&appid={self.api_key}&lang=ja&units=metric'
        try:
            response = requests.get(url)
            if response.status_code == 200:
                weather_data = response.json()
                description = weather_data['weather'][0]['description']
                temp = weather_data['main']['temp']
                humidity = weather_data['main']['humidity']
                return f'天気: {description}, 温度: {temp}°C, 湿度: {humidity}%'
            else:
                self.get_logger().error(f'Error fetching weather data: {response.status_code}')
                return '天気情報の取得に失敗しました'
        except Exception as e:
            self.get_logger().error(f'Exception occurred: {e}')
            return '天気情報の取得中にエラーが発生しました'

    def publish_weather_info(self):
        weather_info = self.fetch_weather_info()
        msg = String()
        msg.data = weather_info
        self.publisher_.publish(msg)
        self.get_logger().info(f'Published: {weather_info}')

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

