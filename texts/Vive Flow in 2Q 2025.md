
# Vive Flow new old stock in 2Q 2025 

## とは

- 楽天アマゾン転売で新品\12k～15kが相場、まともなVRデバイスとして最安
  - \15k以上で買う価値は**ない**
  - 使い道も**ない**
- スタンドアローン、Inside-Out、パンケーキレンズ
- ディオプター調整機能がある!!!!!!!!!
- 後頭部を通らないメガネ型構造
- **ALVR非対応**(囲い込み狙いのAPIのため対応予定なし)
- 外部USB電源は必須

## アップデート

- 長期在庫品のFW 1.5はオンラインアップデートできそうでできない。HTC RUUによる更新が必要。
- RUUで2.xを焼いた後は最終 VIVE Flow Software - 2.20.623.01 - March 2 1, 2024 までアプリから更新できる(Wi-Fi不要)
- 1.xでは公式の説明と異なりスマホ接続中もSSID直打ちすれば2.4GHz接続ができる。2.xでは潰されている。
- 1.xはチュートリアルが合成音声だが2.xはなんか音声作品みたいな声になってる。内容は同じ。
- 1.xに入ってるFirefox Realityはホームページのドメイン webxr[.]todayが業者に取られているのでだるい。ハンドトラッキング使えんし即アプデ推奨(でも2.4GHzのWi-Fiは使えなくなる)
- RUUを当てるとユーザーデータは消えるのでセットアップはやり直し 

### 手順
1. VIVEFLOW_Windows.zip(3.23GB)をHTCからDL
1. 付属のドライバは入れておく
1. 丸ボタンをけっこう長押しして強制電源カット
1. ボリュームダウン(外側)を押しながらUSBを接続
    - 懐かしめの選択画面が出れば成功。RUU突入はスクリプトがやってくれる 
1. アップデートスクリプトを実行
    - モデムがないのでモデムの項でFAILが出る。これは無視していい
    - 始める前に本体を机に置いて手を離すこと。ずっと持ってるとだるい

## CloudXR環境

- NVIDIA GPUが必須。

## スマホコントローラー

- 公式アプリにスマホコントローラー起動ボタン・起動中画面があるわけではない
- Androidのユーザー支援機能を使って、Flowが接続中の場合、かつ指定動作を行った場合に画面を乗っ取っている
- 乗っ取り中は通常タッチが無効になりコントローラー機能のみが使えるようになるが、表示は変わらない
- ヘッドセットを外すと乗っ取りが無効になって通常通り使えるようになる
- ハンドトラッキングで常用することはできない。スマホコントローラーを接続した上で放置が前提
- というかトラッキングモデルがつまみモーションを考慮してないので発動条件がすごく怪しい

## アプリ開発

- OpenJDK 11, HTC Vive Wave SDK 5.6.0, Android SDK 28 が最終バージョン
  - Wave **XR**には対応しない。OpenXRも対応しない。まーだVive覇権を諦めてない
- gradle-wrapper.properties -> distributionUrl=https\://services.gradle.org/distributions/gradle-7.5.1-bin.zip
- File -> Settings -> Build Tools -> Gradle -> Gradle JDK -> JDK 11をインストール後選択

これでビルドが通る。デバッグビルドはAndroid Studioから普通に起動できる。そこだけはかなりアド

# 盲腸

https://www.vive.com/jp/support/flow/category_howto/how-to-update-vive-flow-to-support-iphone.html
https://blog.dnpp.org/vive_flow_virtual_desktop_hack_using_obs
https://lastshooting.blogspot.com/2014/07/android-studioinstallfailedoldersdk.html
https://ugokutennp.hatenablog.com/entry/2022/01/17/032640
https://note.com/kirisamenanoha/n/nb84efb63ddf7
https://note.com/solight/n/nec3e59f97bd9
https://note.com/az3yr_vrc_rep/n/nc2efd49ddad0
https://zenn.dev/nakashun/articles/74fd01fc57175d
