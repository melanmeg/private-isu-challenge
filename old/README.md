# private-isu-challenge

## スコア推移

### 初期スコア

```bash
{"pass":true,"score":4366,"success":4205,"fail":0,"messages":[]}
```

### commentsテーブル post_id_index(変更>idx_post_id_created_at_desc) 追加
```bash
{"pass":true,"score":34655,"success":32526,"fail":0,"messages":[]}
```

### 静的ファイルをキャッシュ
```bash
{"pass":true,"score":35412,"success":33324,"fail":0,"messages":[]}
```

### postsテーブル posts_order_idx(変更>idx_created_at_desc), posts_user_idx 追加
```bash
{"pass":true,"score":36243,"success":34161,"fail":0,"messages":[]}
```

### LIMIT 20
```bash
{"pass":true,"score":43344,"success":41806,"fail":133,"messages":["1ページに表示される画像の数が足りません (GET /)"]}
```

### posts, usersをjoin。posts_user_idx削除
```bash
{"pass":true,"score":44437,"success":41681,"fail":0,"messages":[]}
```

### ユーザー情報を一度に取得してN+1解消
```bash
{"pass":true,"score":95237,"success":91531,"fail":0,"messages":[]}
```

### 画像ファイル取得時と同時にすべて書き出す。/image/* にマッチするリクエストを画像ファイルが存在する場合はそのファイルを返す（キャッシュも有効）
```bash
{"pass":true,"score":88500,"success":84534,"fail":0,"messages":[]}
```

### コメントを一度に取得を一度に取得してN+1解消
```bash
{"pass":true,"score":103296,"success":99339,"fail":0,"messages":[]}
```

### 1.コメントとユーザー情報をバッチで取得。2.データ構造のマッピング。3.コードの読みやすさと保守性を向上。by ChatGPT
```bash
{"pass":true,"score":162687,"success":156868,"fail":0,"messages":[]}
```

### たぶん不要だったGROUP BYカラム削除
```bash
{"pass":true,"score":161000,"success":155095,"fail":0,"messages":[]}
```

### commentsテーブル idx_user_id 追加
```bash
{"pass":true,"score":169587,"success":163265,"fail":0,"messages":[]}
```

### 不要なカラム削減、ORDER BYなくても良さそうだった。（なぜかスコアさがる...）
```bash
{"pass":true,"score":161227,"success":155871,"fail":0,"messages":[]}
```

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
