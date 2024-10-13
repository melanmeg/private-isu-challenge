# プロファイリング

- phpmyadmin, pproteinを外部インスタンスで用意してイイ感じにしたい

- 参考：
  - [pprotein でボトルネックを探して ISUCON で優勝する](https://zenn.dev/team_soda/articles/20231206000000)
  - [ISUCON12で優勝しました(チーム NaruseJun)](https://zenn.dev/tohutohu/articles/8c34d1187e1b21)

# pprotein利用メモ

1. ローカルにclone `git clone https://github.com/kaz/pprotein.git`
2. ローカルでcompose up
  - `network_mode: host` を追加
3. SSHポートフォワーディング
  - ssh -fN -L 19000:localhost:19000 isu1
  - ssh -fN -L 6060:localhost:6060 isu1
4. 以下手順実施

- 依存ツールのインストール
```bash
# Goパッケージインストール
go get github.com/kaz/pprotein

# pprofのグラフ描画に使うgraphviz
sudo apt install -y graphviz gv

# スロークエリログの分析に使うslp
wget https://github.com/tkuchiki/slp/releases/download/v0.2.0/slp_linux_amd64.tar.gz
tar -xvf slp_linux_amd64.tar.gz
sudo mv slp /usr/local/bin/slp

# アクセスログの分析に使うalp
wget https://github.com/tkuchiki/alp/releases/download/v1.0.21/alp_linux_amd64.tar.gz
tar -xvf alp_linux_amd64.tar.gz
sudo mv alp /usr/local/bin/alp

# pprotein本体
wget https://github.com/kaz/pprotein/releases/download/v1.2.3/pprotein_1.2.3_linux_amd64.tar.gz
tar -xvf pprotein_1.2.3_linux_amd64.tar.gz
mv pprotein-agent /home/isucon/pprotein-agent
```

- pprotein-agentのserviceを起動 `sudo vim /etc/systemd/system/pprotein-agent.service`
```
[Unit]
Description=pprotein-agent service

[Service]
ExecStart=/home/isucon/pprotein-agent
WorkingDirectory=/home/isucon
Environment=PATH=$PATH:/usr/local/bin
Restart=always
User=root

[Install]
WantedBy=multi-user.target
```

- サービス起動
```bash
sudo systemctl start pprotein-agent
```

- Goにコードを仕込む（echov4の場合）
> その他に、echo, git, mux, standalone なども統合可能。
> ref: https://github.com/kaz/pprotein/tree/master/integration
```golang
import (
  "github.com/kaz/pprotein/integration/echov4"
)

func main() {
  echov4.EnableDebugHandler(e)
}
```

- Goにコードを仕込む（standaloneの場合）
```golang
import (
  "github.com/kaz/pprotein/integration/standalone"
)

func main() {
  standalone.Integrate(":6060")
}
```

- group/targets の設定
```json
[
  {
    "Type": "pprof",
    "Label": "webapp",
    "URL": "http://localhost:6060/debug/pprof/profile",
    "Duration": 10
  },
  {
    "Type": "httplog",
    "Label": "nginx",
    "URL": "http://localhost:19000/debug/log/httplog",
    "Duration": 10
  },
  {
    "Type": "slowlog",
    "Label": "mysql",
    "URL": "http://localhost:19000/debug/log/slowlog",
    "Duration": 10
  }
]
```

- httplog/config の設定
```
sort: sum # max|min|avg|sum|count|uri|method|max-body|min-body|avg-body|sum-body|p1|p50|p99|stddev
reverse: true
query_string: true
output: count,5xx,4xx,method,uri,min,max,sum,avg,p99

matching_groups:
  - ^/image/[0-9]+$
  - ^/image/[0-9]+\..+$
  - ^/posts/[0-9]+$
  - ^/@\w$
```

- slowlog/config の設定
  - 未定

# 各サーバー間の通信のために DNS/ホスト名 設定をAnsibleで仕込む
- サーバー1: isu1
- サーバー2: isu2
- サーバー3: isu3
- ローカル： isu-local
