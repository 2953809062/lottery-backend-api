## 一、安装Golang
#### 1.1 下载安装包

下载 tar.gz 压缩包: https://golang.org/dl/

#### 1.2 安装GO

执行命令: tar -C /usr/local/go xx.tar.gz 

#### 1.3 创建GOPATH目录
```bash
mkdir ~/.go
```
#### 1.3 设置环境变量
修改 ~/.profile 文件
```bash
export GOPATH=$HOME/.go
export GOROOT=/usr/local/go #注意此处必须设为 /usr/local/go
export PATH=$PATH:/usr/local/go/bin:$HOME/.go/bin
```

## 二、安装插件

将以下内码放置于 xx.sh 文件当中执行

```bash
go get -v golang.org/x/lint/golint
go get -v golang.org/x/tools/cmd/guru
go get -v golang.org/x/sync/errgroup
go get -v golang.org/x/xerrors
go get -v github.com/nsf/gocode
go get -v github.com/spf13/viper
go get -v github.com/go-xorm/xorm
go get -v github.com/go-sql-driver/mysql
go get -v github.com/go-ffmt/ffmt
go get -v golang.org/x/tools/cmd/goimports
go get -v golang.org/cmd/gofmt
go get -v github.com/nsf/gocode
go get -v github.com/gin-gonic/gin
go get -v github.com/sergi/go-diff/diffmatchpatch
go get -v honnef.co/go/tools/simple
go get -v honnef.co/go/tools/staticcheck
go get -v honnef.co/go/tools/stylecheck
go get golang.org/x/tools/gopls

go get -v github.com/lib/pq
```

## 三、创建数据库
```sql
/* 创建主数据库 */
CREATE DATABASE IF NOT EXISTS sys_platform DEFAULT CHARSAET=UTF8 COLLATE=UTF8_GENERAL_CI;
GRANT ALL PRIVILEGES ON sys_platform.* TO 'platform_sys'@'%' IDENTIFIED BY 'platform-x-147';
FLUSH PRIVILEGES;
/* 创建游戏数据库 */
CREATE DATABASE IF NOT EXISTS game001 DEFAULT CHARSAET=UTF8 COLLATE=UTF8_GENERAL_CI;
GRANT ALL PRIVILEGES ON game001.* TO 'game001'@'%' IDENTIFIED BY 'game001-x-lsl';
FLUSH PRIVILEGES;
```
