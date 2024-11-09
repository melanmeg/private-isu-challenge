- メモ
```bash
$ mysql -u isuconp -pisuconp isuconp -e "alter table comments add index post_id_index (post_id, created_at DESC);"

EXPLAIN SELECT `id`, `user_id`, `body`, `mime`, `created_at` FROM `posts` ORDER BY `created_at` DESC;
$ mysql -u isuconp -pisuconp isuconp -e "alter table posts add index posts_order_idx (created_at DESC);"
$ mysql -u isuconp -pisuconp isuconp -e "alter table posts add index posts_user_idx (user_id, created_at DESC);"

$ mysql -u isuconp -pisuconp isuconp -e "alter table comments add index idx_user_id (user_id);"

EXPLAIN SELECT COUNT(*) AS count,
      c.post_id,
      c.created_at
FROM comments c
WHERE c.post_id IN (1,2,3)
GROUP BY c.id, c.post_id
ORDER BY c.created_at DESC;

$ mysql -u isuconp -pisuconp isuconp -e "alter table `comments` add index `idx_user_id` (`user_id`);"
```

- 次のタスク：
  - ORDER BYはやっぱ必要そう
    - ※コミットIDでブランチ切る`git checkout <commit-id>`これでまずは動作確認する。
  - memcachedに何かキャッシュする
  - 一旦サーバー分割してみたい
