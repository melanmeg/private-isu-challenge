# private-isu-challenge

## スコア推移

### 初期スコア

```bash
{"pass":true,"score":4366,"success":4205,"fail":0,"messages":[]}
```

### post_index 追加
```bash
{"pass":true,"score":34655,"success":32526,"fail":0,"messages":[]}
```

## 環境構築
- https://gist.github.com/melanmeg/41e5f575b494ca83b7ca8ba76c91cd05

- 初期設定
```bash
# SSH後に実行
$ cd ~

$ git clone https://github.com/melanmeg/private-isu-challenge.git && \
  mv private_isu private_isu.bk && \
  mv private-isu-challenge private_isu

$ ssh-keygen -t ed25519 -C "" -f ~/.ssh/id_ed25519 -N "" # デプロイキー

$ sudo apt update -y
```

- メモ
```bash
$ mysql -u isuconp -pisuconp isuconp -e "alter table comments add index post_index(post_id, created_at DESC);"
$ mysql -u isuconp -pisuconp isuconp -e "alter table posts add index posts_order_idx (created_at DESC);"
$ mysql -u isuconp -pisuconp isuconp -e "alter table comments add index idx_user_id (user_id);"
$ mysql -u isuconp -pisuconp isuconp -e "alter table posts add index posts_user_idx (user_id,created_at DESC);"
$ sudo systemctl restart mysql

$ go get github.com/redis/go-redis/v8
$ sudo systemctl restart mysql
```


## 参考
- [kazeburo/private-isu-challenge](https://github.com/kazeburo/private-isu-challenge)
- [kaz/pprotein](https://github.com/kaz/pprotein)
- [ISUCON12で2位になりました(織時屋)](https://trap.jp/post/1710/)
- [ISUCON12で優勝しました(チーム NaruseJun)](https://zenn.dev/tohutohu/articles/8c34d1187e1b21)
- [ISUCON13で優勝しました(チーム NaruseJun)](https://zenn.dev/tohutohu/articles/923bdf5dcd73af)
