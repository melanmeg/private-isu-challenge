all: app

# 初期化時に必要
.PHONY: init
init:
	sudo rm -rf /usr/local/go
	$(eval TAR_FILENAME := $(shell curl -fsSL 'https://go.dev/dl/?mode=json' | jq -r '.[0].files[] | select(.os == "linux" and .arch == "amd64" and .kind == "archive") | .filename'))
	$(eval URL := $(shell echo https://go.dev/dl/$(TAR_FILENAME)))
	curl -fsSL $(URL) -o /tmp/go.tar.gz
	sudo tar -C /usr/local -xzf /tmp/go.tar.gz
	rm -f /tmp/go.tar.gz
	go get github.com/go-delve/delve/cmd/dlv
	go get github.com/redis/go-redis/v8
	go get github.com/bradfitz/gomemcache/memcache
	go get github.com/bradleypeabody/gorilla-sessions-memcache
	go get github.com/kaz/pprotein

app: *.go go.mod go.sum
	go build -o app
	sudo systemctl restart isu-go
