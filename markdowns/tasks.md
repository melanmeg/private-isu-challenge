# タスク

## 作業サーバ
- 一人一台で作業できる

## 初めにやること

### 全員
- マニュアル確認
- ssh_config設定
- ポートフォワーディング(netdataやpprofを見るなら)

### アプリ
- Webブラウザでアプリの起動を確認する
- 開発環境整備(デバッグツールなど)
- コードを読む
- インデックスを貼る、N+1解決
- その他ボトルネック解消、コード修正

### インフラ
- 各サーバーにSSH(デプロイキー)の設定
  - `ssh-keygen -t ed25519 -C "" -f ~/.ssh/id_ed25519 -N ""`
- アプリの言語をGoに設定する
- 開発環境整備(デバッグツールなど)
- webappをGit管理
- Ansible修正
- CI設定(変数登録)
  - Secrets: SSH_PRIVATE_KEY
  - Variables: HOST1, HOST2, HOST3, ALP, MYSQL, PPROF (, HOST_BENCH)
- CI実行
  - collect.shでOS情報を取得
  - netdata, alp, pprof, pt-query-digest インストール
  - mysql, nginx ログ設定
  - alp, pprof, pt-query-digest測定
  - デプロイ自動化
- サーバー分割

## isucon PDCA
1. アクセスログとデータベースのログを取得
    - nginx
    - alp
    - mysql
    - app (pprof)
2. サーバのメトリクスを取得する
    - ベンチマーク実行中のtopコマンドでサーバのリソース使用状況を見る
    - netdata導入してメトリクス見るもよし
3. ボトルネックのAPIを特定する
4. 遅い原因を特定する
    - クエリが遅いのか
        - クエリの実行回数
        - クエリの実行時間
    - アプリが遅いのか
        - cpu
        - memory
5. コード修正を反映する（Githubからデプロイまでを自動化したい）
6. ベンチマークを回す
