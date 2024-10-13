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
$ mysql -u isuconp -pisuconp isuconp -e "alter table posts add index posts_order_idx (created_at DESC);"
EXPLAIN SELECT `id`, `user_id`, `body`, `mime`, `created_at` FROM `posts` ORDER BY `created_at` DESC;
$ mysql -u isuconp -pisuconp isuconp -e "alter table posts add index posts_user_idx (user_id, created_at DESC);"
EXPLAIN SELECT `id`, `user_id`, `body`, `mime`, `created_at` FROM `posts` ORDER BY `created_at` DESC;

$ mysql -u isuconp -pisuconp isuconp -e "alter table comments add index post_index(post_id, created_at DESC);"
$ mysql -u isuconp -pisuconp isuconp -e "alter table comments add index idx_user_id (user_id);"
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
- [ISUCON9予選1日目で最高スコアを出しました](https://to-hutohu.com/2019/09/09/isucon9-qual/#%E5%BD%93%E6%97%A5)
- nwiizoさん, megumishさん 参考リンク
  - [ISUCON8 本戦に出てまあまあだった話](https://hikalium.hatenablog.jp/entry/2018/10/20/225806)
  - [自分のチームのISUCONでの戦い方](https://catatsuy.medium.com/%E8%87%AA%E5%88%86%E3%81%AE%E3%83%81%E3%83%BC%E3%83%A0%E3%81%AEisucon%E3%81%A7%E3%81%AE%E6%88%A6%E3%81%84%E6%96%B9-c8fe121316aa)
  - [ISUCON 夏祭り 2023 ハンズオン資料](https://speakerdeck.com/rosylilly/isucon-xia-ji-ri-2023-hanzuonzi-liao)
