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

### ssh port foward

```bash
ssh -N -L 0.0.0.0:19999:localhost:19999 isu1  # netdata
ssh -N -L 0.0.0.0:9000:localhost:9000 measure  # pprotein
ssh -N -L 0.0.0.0:8080:localhost:8080 measure  # phpmyadmin

# wipe process
kill $(ps aux | grep 'ssh -fN -L 0.0.0.0:19999:localhost:19999 isu1' | grep -v grep | awk '{print $2}')
ps aux | grep ssh
```
