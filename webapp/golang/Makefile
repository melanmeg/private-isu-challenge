all: app

# 初期化時に必要
.PHONY: init
init:
	go get github.com/go-delve/delve/cmd/dlv
	go get github.com/bradfitz/gomemcache/memcache
	go get github.com/bradleypeabody/gorilla-sessions-memcache
	go get github.com/kaz/pprotein

app: *.go go.mod go.sum
	go build -o app
	sudo systemctl restart isu-go
