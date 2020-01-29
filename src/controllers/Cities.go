package controllers

import (
	"common"
	"dao"
	"models"
	"validations"

	"github.com/gin-gonic/gin"
)

/// 城市
var Cities = struct {
	All             func(*gin.Context) //缓存
	*common.Backend                    //基类
}{
	Backend: &common.Backend{
		Model: dao.Cities,
		Headers: []map[string]string{
			{"id": "编号"},
			{"province_id": "省份"},
			{"province_code": "省份编码"},
			{"name": "名称"},
			{"code": "编码"},
			{"remark": "备注"},
		},
		OptionAll: true,
		Rows: func() interface{} {
			return &[]models.Cities{}
		},
		Row: func() interface{} {
			return &models.Cities{}
		},
		Validator: validations.Cities,
		QueryCond: map[string]interface{}{
			"province_id":   "=",
			"name":          "%",
			"code":          "%",
			"province_code": "%",
			"remark":        "%",
		},
	},
}
