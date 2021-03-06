package main

import (
	"db"
	"router"

	"github.com/gin-gonic/gin"
	_ "github.com/go-sql-driver/mysql"
)

/// main
func main() {
	db.LoadConfigs()
	// 启动主程序
	app := gin.Default()
	router.Init(app)
	_ = app.Run(":8801")
}
