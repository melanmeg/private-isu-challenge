# ISUCON Commands

### ansible local
```bash
$ ansible-playbook --key-file ~/.ssh/main -i hosts ./playbook.yml -C
```

### backup

```bash
# archive
tar zcvfp /home/isucon/webapp.tar.gz /home/isucon/private_isu/webapp

# unarchive
tar zxvfp /home/isucon/webapp.tar.gz -C /home/isucon/private_isu/webapp

# mysqldump
mysqldump -u isuconp isuconp | gzip > /tmp/isuconp.dump.sql.gz
```

### Golang

```bash
go get github.com/go-delve/delve/cmd/dlv
go get github.com/bradfitz/gomemcache/memcache
go get github.com/bradleypeabody/gorilla-sessions-memcache
go get github.com/kaz/pprotein
```

### ssh portforwording
```bash
# 端末側で実行する
ssh -NL 19999:localhost:19999 isu1  # netdata
ssh -NL 9000:localhost:9000 isu-measure  # pprotein
ssh -NL 8080:localhost:8080 isu-measure  # phpmyadmin
```

- もし計測サーバーを外部ネットワークに配置して、ポートフォワードで設定する場合 ↓
```bash
# 計測サーバーで実行する
ssh -fNL 0.0.0.0:6060:localhost:6060 isu1  # for pprotein
ssh -fNL 0.0.0.0:19000:localhost:19000 isu1  # for pprotein
ssh -NL 0.0.0.0:3306:localhost:3306 isu1  # for phpmyadmin

# pprotein, phpmyadminで指定するIPは、計測サーバーのIP

# wipe process
kill $(ps aux | grep 'ssh -fN -L 0.0.0.0:6060:localhost:6060 isu1' | grep -v grep | awk '{print $2}')
ps aux | grep ssh
```
