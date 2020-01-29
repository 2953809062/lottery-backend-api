package controllers

import (
	"common/response"
	"dao"

	"github.com/gin-gonic/gin"
)

/// 默认页
var Index = struct {
	Index func(*gin.Context)
	Login func(*gin.Context)
}{
	Index: func(c *gin.Context) { //默认首页
		response.Ok(c)
	},
	Login: func(c *gin.Context) { //登录
		if err := dao.Index.Login(c); err != nil {
			response.Err(c, err.Error())
			return
		}
		response.Ok(c)
	},
}
