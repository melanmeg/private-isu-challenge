# private-isu-challenge

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
$ mysql -u isuconp -pisuconp isuconp -e "ALTER TABLE `comments` ADD INDEX `idx_user_id` (`user_id`);"
$ mysql -u isuconp -pisuconp isuconp -e "ALTER TABLE `posts` ADD INDEX `posts_user_idx` (`user_id`,`created_at` DESC);"
$ sudo systemctl restart mysql

$ go get github.com/redis/go-redis/v8
$ sudo systemctl restart mysql
```

## スコア推移

### 初期スコア

## 参考
- https://github.com/kazeburo/private-isu-challenge
- https://github.com/kaz/pprotein
- https://trap.jp/post/1710/
- https://github.com/kaz/pprotein
