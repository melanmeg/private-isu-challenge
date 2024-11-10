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

# private-isuでGOROOT空だったので、そのような場合にGoをインストールする
.PHONY: go-reinstall
go-reinstall:
	sudo rm -rf /usr/local/go
	$(eval TAR_FILENAME := $(shell curl -fsSL 'https://go.dev/dl/?mode=json' | jq -r '.[0].files[] | select(.os == "linux" and .arch == "amd64" and .kind == "archive") | .filename'))
	$(eval URL := $(shell echo https://go.dev/dl/$(TAR_FILENAME)))
	curl -fsSL $(URL) -o /tmp/go.tar.gz
	sudo tar -C /usr/local -xzf /tmp/go.tar.gz
	rm -f /tmp/go.tar.gz
