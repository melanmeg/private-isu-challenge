# ISUCON Commands

### ansible local
```bash
$ ansible-playbook --key-file ~/.ssh/main -i hosts ./playbooks/isu1.yml -C
```

### shell

```bash
# archive
tar zcvfp /home/isucon/webapp.tar.gz /home/isucon/private_isu/webapp

# unarchive
tar zxvfp /home/isucon/webapp.tar.gz -C /home/isucon/private_isu/webapp

# mysqldump
mysqldump -u isuconp isuconp | gzip > /tmp/isuconp.dump.sql.gz

# scp
scp isu1:/tmp/webapp.tar.gz ./
scp isu1:/tmp/isuconp.dump.sql.gz ./

# mysql
mysql -u isucon -pisucon
```

---

### alp

```bash
sudo cat /var/log/nginx/access.log \
| alp ltsv -m '/image/[0-9]+,/posts/[0-9]+,/@\w' \
--sort avg -r -o count,1xx,2xx,3xx,4xx,5xx,min,max,avg,sum,p99,method,uri
```

---

### pt-query-digest

```bash
#sudo sed -i '/^INSERT INTO `posts`/d' /var/log/mysql/mysql-slow.log
sudo pt-query-digest /var/log/mysql/mysql-slow.log
```

---

### pprof

```bash
# profile
sudo curl -o cpu.pprof http://localhost:6060/debug/pprof/profile?seconds=60
sudo go tool pprof -http localhost:1080 cpu.pprof
ssh -N -L 0.0.0.0:1080:localhost:1080 isu1
http://localhost:1080/
#http://192.168.11.21:1080/
```

---

### Golang

```bash
go get github.com/go-delve/delve/cmd/dlv
go get github.com/kaz/pprotein
```

---

### ssh port foward

```bash
ssh -N -L 0.0.0.0:19999:localhost:19999 isu1  # netdata
ssh -N -L 0.0.0.0:1080:localhost:1080 isu1  # pprof
ssh -N -L 0.0.0.0:3306:localhost:3306 isu1  # mysql

# access
http://localhost:1080/

# wipe ps
kill $(ps aux | grep 'ssh -fN -L 0.0.0.0:19999:localhost:19999 isu1' | grep -v grep | awk '{print $2}')
kill $(ps aux | grep 'ssh -fN -L 0.0.0.0:1080:localhost:1080 isu1' | grep -v grep | awk '{print $2}')
ps aux | grep ssh
```
