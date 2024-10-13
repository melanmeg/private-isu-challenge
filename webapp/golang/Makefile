all: app

app: *.go go.mod go.sum
	go build -o app
	sudo systemctl restart isu-go
