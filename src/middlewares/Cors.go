package middlewares

import (
	"fmt"
	"net/http"
	"regexp"
	"strings"

	"github.com/gin-gonic/gin"
)

/// 跨域请求
func Cors() gin.HandlerFunc {
	return func(c *gin.Context) {
		method := c.Request.Method
		origin := c.Request.Header.Get("Origin")
		host := c.Request.Host
		//fmt.Println("头部信息: ---------------------------------------------------- >>>")
		//for k, v := range c.Request.Header {
		//	fmt.Printf("Key: %-30s, Value: %v\n", k, v)
		//}
		realOrigin := strings.Trim(origin, "http://")
		fmt.Printf("\nReal Orgin = %v, Host = %v, Request URI = %v, URL = %v\n", realOrigin, host, c.Request.RequestURI, c.Request.URL)
		//fmt.Println("头部信息: ---------------------------------------------------- <<<")
		/// 需要在此处检查

		var filterHost = [...]string{"http://localhost.*", "http://*.hfjy.com"}
		// filterHost 做过滤器，防止不合法的域名访问
		var isAccess = true
		for _, v := range filterHost {
			match, _ := regexp.MatchString(v, origin)
			if match {
				isAccess = true
			}
		}
		if isAccess {
			// 核心处理方式
			c.Header("Access-Control-Allow-Origin", "*")
			c.Header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept")
			c.Header("Access-Control-Allow-Methods", "GET, OPTIONS, POST, PUT, DELETE")
			c.Set("content-type", "application/json")
		}
		//放行所有OPTIONS方法
		if method == "OPTIONS" {
			c.JSON(http.StatusOK, "Options Request!")
		}

		c.Next()
	}
}
