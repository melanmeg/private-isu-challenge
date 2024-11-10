# private-isu-challenge

---

## スコア推移

### 初期スコア
```bash
{"pass":true,"score":4193,"success":4037,"fail":0,"messages":[]}
```
![slowQuery](./images/1.PNG)

### commentsテーブル idx_post_id_created_at_desc 追加
```bash
$ mysql -u isuconp -pisuconp isuconp -e "alter table comments add index idx_post_id_created_at_desc (post_id, created_at DESC);"
```
```bash
```

### 静的ファイルをキャッシュ
- https://github.com/melanmeg/private-isu-challenge/commit/9f8feaf67195e1fc3e1eb40347beea714852fab4
```bash
```

### postsテーブル idx_created_at_desc
```bash
$ mysql -u isuconp -pisuconp isuconp -e "alter table posts add index idx_created_at_desc (created_at DESC);"
```
```bash
```

### posts, usersをjoin. LIMIT 20
```bash
```

### 画像ファイル取得時と同時にすべて書き出す。/image/* にマッチするリクエストを画像ファイルが存在する場合はそのファイルを返す（キャッシュも有効）
- https://github.com/melanmeg/private-isu-challenge/commit/9665894c45f6c09bdfaf2efbc1dd09de8acbf144
- https://github.com/melanmeg/private-isu-challenge/commit/d7053047c2a1fac6ab9f1d6888ee28125f2eca4e
```bash
```

### commentsテーブル idx_user_id 追加
```bash
$ mysql -u isuconp -pisuconp isuconp -e "alter table comments add index idx_user_id (user_id);"
```
```bash
```

---

## 環境構築
- https://gist.github.com/melanmeg/41e5f575b494ca83b7ca8ba76c91cd05

> pproteinとphpmyadminの用意
- https://gist.github.com/melanmeg/d90533425d32b87f16b695667b8de141

- 初期設定
```bash
# SSH後に実行
$ cd ~ && \
  git clone https://github.com/melanmeg/private-isu-challenge.git && \
  mv private_isu private_isu.bk && \
  mv private-isu-challenge private_isu && \
  ssh-keygen -t ed25519 -C "" -f ~/.ssh/id_ed25519 -N "" && \
  sudo apt update -y

# private-isuでGOROOT空だったので、そのような場合にGoをインストールする
$ sudo rm -rf /usr/local/go
$ TAR_FILENAME=$(curl 'https://go.dev/dl/?mode=json' | jq -r '.[0].files[] | select(.os == "linux" and .arch == "amd64" and .kind == "archive") | .filename')
$ URL="https://go.dev/dl/$TAR_FILENAME"
$ curl -fsSL "$URL" -o /tmp/go.tar.gz && \
  sudo tar -C /usr/local -xzf /tmp/go.tar.gz && \
  rm -f /tmp/go.tar.gz
$ cat <<EOF >> ~/.bashrc
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
EOF
```

---

## 参考
- [kazeburo/private-isu-challenge](https://github.com/kazeburo/private-isu-challenge)
- [kaz/pprotein](https://github.com/kaz/pprotein)
- [ISUCON12で2位になりました(織時屋)](https://trap.jp/post/1710/)
- [ISUCON12で優勝しました(チーム NaruseJun)](https://zenn.dev/tohutohu/articles/8c34d1187e1b21)
- [ISUCON13で優勝しました(チーム NaruseJun)](https://zenn.dev/tohutohu/articles/923bdf5dcd73af)
- [ISUCON9予選1日目で最高スコアを出しました](https://to-hutohu.com/2019/09/09/isucon9-qual/#%E5%BD%93%E6%97%A5)
- nwiizoさん, megumishさん 参考リンク
  - [ISUCON8 本戦に出てまあまあだった話](https://hikalium.hatenablog.jp/entry/2018/10/20/225806)
  - [自分のチームのISUCONでの戦い方](https://catatsuy.medium.com/%E8%87%AA%E5%88%86%E3%81%AE%E3%83%81%E3%83%BC%E3%83%A0%E3%81%AEisucon%E3%81%A7%E3%81%AE%E6%88%A6%E3%81%84%E6%96%B9-c8fe121316aa)
  - [ISUCON 夏祭り 2023 ハンズオン資料](https://speakerdeck.com/rosylilly/isucon-xia-ji-ri-2023-hanzuonzi-liao)
