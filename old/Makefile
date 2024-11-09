all: deploy

# 変数定義 ------------------------

USER:=isucon
GIT_DIR:=/home/isucon/private_isu
BUILD_DIR:=$(GIT_DIR)/webapp/golang
SERVICE_NAME:=isu-go.service

ISUCON_DB_HOST:=127.0.0.1
ISUCON_DB_PORT:=3306
ISUCON_DB_NAME:=isuconp
ISUCON_DB_USER:=isuconp
ISUCON_DB_PASSWORD:=isuconp

NGINX_LOG:=/var/log/nginx/access.log
DB_SLOW_LOG:=/var/log/mysql/mysql-slow.log

# http://localhost:19999/netdata.confのdirectories.webで確認可能
NETDATA_WEBROOT_PATH:=/var/lib/netdata/www
NETDATA_CUSTUM_HTML:=tool-config/netdata/*

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


# alpでアクセスログを確認する
.PHONY: alp
alp:
	sudo cat $(NGINX_LOG) \
	| alp ltsv -m '/image/[0-9]+,/posts/[0-9]+,/@\w' \
	--sort avg -r -o count,1xx,2xx,3xx,4xx,5xx,min,max,avg,sum,p99,method,uri

.PHONY: alp2
alp2:
	sudo alp ltsv --file=$(NGINX_LOG) --config=alp-config.yml


# slow queryを確認する
.PHONY: slow-query
slow-query:
	# sudo sed -i '/^INSERT INTO `posts`/d' $(DB_SLOW_LOG)
	sudo pt-query-digest $(DB_SLOW_LOG)

.PHONY: slow-query2
slow-query2:
	sudo pt-query-digest --filter 'length($$event->{arg}) <= 2000' $(DB_SLOW_LOG)


# pprofで記録する
.PHONY: pprof
pprof:
	curl -o pprof/cpu_$$(date +"%Y-%m-%d-%H-%M-%S").pprof http://localhost:6060/debug/pprof/profile?seconds=60

.PHONY: fgprof
fgprof:
	curl -o pprof/cpu_$$(date +"%Y-%m-%d-%H-%M-%S").pprof http://localhost:6060/debug/fgprof?seconds=6

# pprofで確認する
.PHONY: pprof-check
pprof-check:
	$(eval latest := $(shell ls -rt pprof/ | tail -n 1))
	go tool pprof -http localhost:1080 /pprof/$(latest)

.PHONY: fgprof-check
fgprof-check:
	$(eval latest := $(shell ls -rt pprof/ | tail -n 1))
	go tool pprof -http localhost:1080 pprof/$(latest)


# DBに接続する
.PHONY: mysql
mysql:
	mysql -h $(ISUCON_DB_HOST) -P $(ISUCON_DB_PORT) -u $(ISUCON_DB_USER) -p$(ISUCON_DB_PASSWORD) $(ISUCON_DB_NAME)


# Git設定する
.PHONY: git-setup
git-setup:
	# git用の設定は適宜変更して良い
	git config --global user.email "isucon@example.com"
	git config --global user.name "isucon"

	# deploykeyの作成
	ssh-keygen -t ed25519 -C "" -f ~/.ssh/id_ed25519 -N ""


# private-isuでGOROOT空だったので、そのような場合に実行
.PHONY: go-reinstall
go-reinstall:
	sudo rm -rf /usr/local/go
	$(eval TAR_FILENAME := $(shell curl -fsSL 'https://go.dev/dl/?mode=json' | jq -r '.[0].files[] | select(.os == "linux" and .arch == "amd64" and .kind == "archive") | .filename'))
	$(eval URL := $(shell echo https://go.dev/dl/$(TAR_FILENAME)))
	curl -fsSL $(URL) -o /tmp/go.tar.gz
	sudo tar -C /usr/local -xzf /tmp/go.tar.gz
	rm -f /tmp/go.tar.gz
