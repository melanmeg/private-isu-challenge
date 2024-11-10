# pprotein利用メモ

### phpmyadmin, pproteinを外部インスタンスで用意したい

### 参考：
  - [pprotein でボトルネックを探して ISUCON で優勝する](https://zenn.dev/team_soda/articles/20231206000000)
  - [ISUCON12で優勝しました(チーム NaruseJun)](https://zenn.dev/tohutohu/articles/8c34d1187e1b21)

### Goにコードを仕込む
- echov4の場合
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

- standaloneの場合
```golang
import (
  "github.com/kaz/pprotein/integration/standalone"
)

func main() {
  standalone.Integrate(":6060")
}
```

### pprotein の group/targets の設定
```json
[
  {
    "Type": "pprof",
    "Label": "webapp",
    "URL": "http://10.1.1.11:6060/debug/pprof/profile",
    "Duration": 60
  },
  {
    "Type": "httplog",
    "Label": "nginx",
    "URL": "http://10.1.1.11:19000/debug/log/httplog",
    "Duration": 60
  },
  {
    "Type": "slowlog",
    "Label": "mysql",
    "URL": "http://10.1.1.11:19000/debug/log/slowlog",
    "Duration": 60
  }
]
```

### pprotein の httplog/config の設定
```
sort: sum # max|min|avg|sum|count|uri|method|max-body|min-body|avg-body|sum-body|p1|p50|p99|stddev
reverse: true
query_string: true
output: count,5xx,4xx,method,uri,min,max,sum,avg,p99

matching_groups:
  - ^/image/[0-9]+$
  - ^/image/[0-9]+\..+$
  - ^/posts/[0-9]+$
  - ^/posts.*
  - ^/@\w$
```

### pprotein の slowlog/config の設定
  - デフォルトで
