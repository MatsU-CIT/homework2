# homework2
23C1134_ロボットシステム学課題2提出用

# ROS2パッケージ:世界各地の天気情報
[![License](https://img.shields.io/badge/License-BSD_3--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)
[![test](https://github.com/MatsU-CIT/homework2/actions/workflows/test.yml/badge.svg)](https://github.com/MatsU-CIT/homework2/actions/workflows/test.yml)

## 概要
- 世界中の都市における現在の天気を確認することが出来るROS2パッケージです。

## ノード:weather.py
世界各地の地域を指定しておくと、その地域の現在の天気情報を1秒毎にトピックにパブリッシュします。

## トピック:weather_info
weather.pyからパブリッシュされた、以下の情報を持ちます。  
```
受信した天気情報は次の通りです: "{msg.data}"
```

## 実行
- 千葉県習志野市の現在の天気を確認したい場合  
①
```weather.py```内の```self.location```に```Narashino,JP```
と入力  

②
ワークスペースのディレクトリにてビルド  
```
colcon build
```
  
```
source ~/.bashrc
```
③
```
ros2 run homework2 weather
```
で実行  

④
トピックの内容は以下のコマンドで確認可能です。  
```
ros2 topic echo weather_info
```

トピック内容例

```
data: '指定地点の現在の天気は: 曇りがち, 温度は: 6.38°C, 湿度は: 100% となっております。yeah'
---
data: '指定地点の現在の天気は: 曇りがち, 温度は: 7°C, 湿度は: 100% となっております。yeah'
---
data: '指定地点の現在の天気は: 曇りがち, 温度は: 7°C, 湿度は: 100% となっております。yeah'
---
data: '指定地点の現在の天気は: 曇りがち, 温度は: 7°C, 湿度は: 100% となっております。yeah'
 ---
data: '指定地点の現在の天気は: 曇りがち, 温度は: 6.38°C, 湿度は: 100% となっております。yeah'
```

### APIキーの導入方法
①
下記のリンクより「OpenWeatherMap」のサイトにアクセス  
　　- [https://openweathermap.org/](https://openweathermap.org/)  
②
サイト右上にある「Sign in」をクリック  
③
「Create an Account」をクリック  
④
必要事項の入力・チェックボックスにチェック・使用目的の解答などを行い、メール認証を経てアカウントを作成  
⑤
「API keys」をクリックしAPIキーを取得  
⑥
取得したAPIキーを```weather.py```のノード内の```self.api_key```にコピペし導入完了  

※OpenWeatherMapにおけるアカウント作成に関する詳しい情報は以下のサイト参照  
　　- [https://auto-worker.com/blog/?p=1612](https://auto-worker.com/blog/?p=1612)  

## テスト済み環境
- Ubuntu 22.04 LTS
 - ROS2 Humble(GitHub Actions)
- Ubuntu 24.04 LTS
 - ROS2 Jazzy(開発環境)
## ライセンス
- このソフトウェアパッケージは，3条項BSDライセンスの下，再頒布および使用が許可されます．

- このパッケージのコードの一部は，下記のスライド（CC-BY-SA 4.0 by Ryuichi Ueda）のものを，本人の許可を得て自身の著作としたものです．
    - [ryuichiueda/slides_marp/tree/master/robosys2024](https://github.com/ryuichiueda/slides_marp/tree/master/robosys2024)

  © 2025 Yusuke Matsumoto

