### 游戏后端

- 安装插件
```bash
go get -v golang.org/x/lint/golint
go get -v golang.org/x/tools/cmd/guru
go get -v golang.org/x/sync/errgroup
go get -v golang.org/x/xerrors
go get -v github.com/nsf/gocode
#go get -v github.com/mdempsky/gocode
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

cd $GOPATH/.go/src
go install  golang.org/x/tools/gopls

#go get -v github.com/lib/pq
```
