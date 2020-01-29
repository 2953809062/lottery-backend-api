package controllers

import (
	"common/response"
	"config"
	"strconv"

	"github.com/gin-gonic/gin"
)

var Conf = struct {
	LogLevels func(*gin.Context)
	LogTypes  func(*gin.Context)
}{
	LogLevels: func(c *gin.Context) {
		rows := []map[string]string{}
		for id, name := range config.LogLevels {
			rows = append(rows, map[string]string{
				"id":   strconv.Itoa(int(id)),
				"name": name,
			})
		}
		response.Result(c, rows)
	},
	LogTypes: func(c *gin.Context) {
		rows := []map[string]string{}
		for id, name := range config.LogTypes {
			rows = append(rows, map[string]string{
				"id":   strconv.Itoa(int(id)),
				"name": name,
			})
		}
		response.Result(c, rows)
	},
}
