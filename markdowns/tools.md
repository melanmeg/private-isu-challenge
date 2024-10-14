# プロファイリング

- phpmyadmin, pproteinを外部インスタンスで用意してイイ感じにしたい

- 参考：
  - [pprotein でボトルネックを探して ISUCON で優勝する](https://zenn.dev/team_soda/articles/20231206000000)
  - [ISUCON12で優勝しました(チーム NaruseJun)](https://zenn.dev/tohutohu/articles/8c34d1187e1b21)

1. ローカルにclone `git clone https://github.com/kaz/pprotein.git`
2. ローカルでcompose up
  - `network_mode: host` を追加
3. SSHポートフォワーディング
  - ssh -N -L 0.0.0.0:19000:localhost:19000 isu1
  - ssh -N -L 0.0.0.0:6060:localhost:6060 isu1
  - ssh -N -L 0.0.0.0:3306:localhost:3306 isu1
4. 以下手順実施

# 各サーバー間の通信のために DNS/ホスト名 設定をAnsibleで仕込む
- サーバー1: isu1
- サーバー2: isu2
- サーバー3: isu3
- ローカル： isu-local

# phpmyadmin 使い方
