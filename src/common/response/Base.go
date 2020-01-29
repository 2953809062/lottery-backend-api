package response

import (
	"github.com/gin-gonic/gin"
)

/// 输出成功消息
func Ok(c *gin.Context) {
	c.JSON(200, struct {
		Code uint16 `json:"code"`
	}{
		Code: 200,
	})
}

/// 输出错误信息
func Err(c *gin.Context, message string) {
	c.JSON(200, struct {
		Code    uint16 `json:"code"`
		Message string `json:"message"`
	}{
		Code:    400,
		Message: message,
	})
}

/// 输出消息
func Message(c *gin.Context, message string) {
	c.JSON(200, struct {
		Code    uint16 `json:"code"`
		Message string `json:"message"`
	}{
		Code:    200,
		Message: message,
	})
}

/// 输出结果
func Result(c *gin.Context, result interface{}) {
	c.JSON(200, struct {
		Code   uint16      `json:"code"`
		Result interface{} `json:"result"`
	}{
		Code:   200,
		Result: result,
	})
}

/// 输出分页结果
func Pager(c *gin.Context, list interface{}, total uint64) {
	c.JSON(200, struct {
		Code   uint16      `json:"code"`
		Result interface{} `json:"result"`
	}{
		Code: 200,
		Result: struct {
			List  interface{} `json:"list"`
			Total uint64      `json:"total"`
		}{
			List:  list,
			Total: total,
		},
	})
}
