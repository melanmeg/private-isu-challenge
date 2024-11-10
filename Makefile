all: deploy

# 変数定義 ------------------------

USER:=isucon
GIT_DIR:=/home/isucon/private_isu
BUILD_DIR:=$(GIT_DIR)/webapp/golang
SERVICE_NAME:=isu-go.service

ISUCON_DB_HOST:=127.0.0.1  # localhostだとbindしないので注意
ISUCON_DB_PORT:=3306
ISUCON_DB_NAME:=isuconp
ISUCON_DB_USER:=isuconp
ISUCON_DB_PASSWORD:=isuconp

NGINX_LOG:=/var/log/nginx/access.log
DB_SLOW_LOG:=/var/log/mysql/mysql-slow.log

# メインで使うコマンド ------------------------

# ベンチマーク前に実施
.PHONY: deploy
deploy:
	git pull
	# go build
	make -C $(BUILD_DIR)
	sudo systemctl restart $(SERVICE_NAME)
	# nginx
	sudo rm -f $(NGINX_LOG)
	sudo systemctl restart nginx
	# mysql
	sudo rm -f $(DB_SLOW_LOG)
	sudo systemctl restart mysql

# DBに接続する
.PHONY: mysql
mysql:
	mysql -h $(ISUCON_DB_HOST) -P $(ISUCON_DB_PORT) -u $(ISUCON_DB_USER) -p$(ISUCON_DB_PASSWORD) $(ISUCON_DB_NAME)

# Gitの初期設定
.PHONY: git-setup
git-setup:
	# git用の設定は適宜変更して良い
	git config --global user.email "isucon@example.com"
	git config --global user.name "isucon"

	# deploykeyの作成
	ssh-keygen -t ed25519 -C "" -f ~/.ssh/id_ed25519 -N ""
