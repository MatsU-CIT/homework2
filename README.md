# homework2
23C1134_ロボットシステム学課題2提出

# ROS2パッケージ-世界各地の天気情報
[![License](https://img.shields.io/badge/License-BSD_3--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)
[![test]()]()


## 使い方-世界各地の天気情報
- 世界中の都市における現在の天気を確認することが出来るROS2パッケージです。

### APIキーの導入方法
①　下記のリンクより「OpenWeatherMap」のサイトにアクセス  
　　- [https://openweathermap.org/](https://openweathermap.org/)  
②　サイト右上にある「Sign in」をクリック  
③　「Create an Account」をクリック  
④　必要事項の入力・チェックボックスにチェック・使用目的の解答などを行い、メール認証を経てアカウントを作成  
⑤　「API keys」をクリックしAPIキーを取得  
⑥　取得したAPIキーを```weather.py```のノード内の```self.api_key```にコピペし導入完了  
  
※OpenWearMapにおけるアカウント作成に関する詳しい情報は以下のサイト参照  
　　- [https://auto-worker.com/blog/?p=1612](https://auto-worker.com/blog/?p=1612)  

### 実行
- 千葉県習志野市の現在の天気を確認したい場合  
①　```weather.py```内の```self.location```に```Narashino,JP```と入力  
② 　ワークスペースのディレクトリにてビルド  
```colcon build```  
```source ~/.bashrc```  
③　同じディレクトリで```ros2 run homework2 weather```で実行  

# テスト環境
- Ubuntu 22.04 LTS

## ライセンス
- このソフトウェアパッケージは，3条項BSDライセンスの下，再頒布および使用が許可されます．

- このパッケージのコードの一部は，下記のスライド（CC-BY-SA 4.0 by Ryuichi Ueda）のものを，本人の許可を得て自身の著作としたものです．
    - [ryuichiueda/slides_marp/tree/master/robosys2024](https://github.com/ryuichiueda/slides_marp/tree/master/robosys2024)

  © 2024 Yusuke Matsumoto

