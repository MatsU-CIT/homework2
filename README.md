# homework2
23C1134_ロボットシステム学課題2提出用

# 課題ノード(weather.py)
[![License]()]()
[![test]()]()


## 使い方-世界各地の天気情報
- 世界中の都市における現在の天気を確認することが出来ます。

### APIキーの導入方法
①　下記のリンクより「OpenWeatherMap」のサイトにアクセス  
　　- [https://openweathermap.org/](https://openweathermap.org/)  
②　サインアップ

### 実行例
- 千葉県習志野市の現在の天気を確認したい場合  
①　```weather.py```内の```self.location```に```Narashino,JP```と入力  
② 　ワークスペースのディレクトリにてビルド  
```colcon build```  
```source ~/.bashrc```  
③　```ros2 run homework2 weather```で実行  

# テスト環境
- Ubuntu 22.04 LTS

## ライセンス
- このソフトウェアパッケージは，3条項BSDライセンスの下，再頒布および使用が許可されます．

- このパッケージのコードの一部は，下記のスライド（CC-BY-SA 4.0 by Ryuichi Ueda）のものを，本人の許可を得て自身の著作としたものです．
    - [ryuichiueda/slides_marp/tree/master/robosys2024](https://github.com/ryuichiueda/slides_marp/tree/master/robosys2024)

  © 2024 Yusuke Matsumoto

