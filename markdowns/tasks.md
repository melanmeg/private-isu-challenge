# タスクについて

## 初めにやること

### 全員
- マニュアル確認
- sshのconfig設定
- ポートフォワーディング

### アプリ
- Webブラウザでアプリの起動を確認する
- 開発環境整備
- インデックスを貼る、N+1解決
- その他ボトルネック解消、コード修正

### インフラ
- 各サーバーにデプロイキーを設定
- アプリの言語をGoに設定する
- 開発環境整備
- webappをGit管理
- Ansible修正
- Github Actions変数設定
  - Secrets: SSH_PRIVATE_KEY
  - Variables: HOST1, HOST2, HOST3
- Github Actions実行
  - collect.shでOS情報を取得
  - pproteinインストール
  - mysql, nginx ログ設定
  - デプロイ自動化
- サーバー分割

### 各サーバー間の通信のために DNS/ホスト名 設定をAnsibleで仕込む
- サーバー1: isu1
- サーバー2: isu2
- サーバー3: isu3
- ローカル： isu-local
