package controllers

import (
	"common"
	"dao"
	"models"
	"validations"
)

/// 省份
var Provinces = struct {
	*common.Backend //基类
}{
	Backend: &common.Backend{
		Model: dao.Provinces,
		Headers: []map[string]string{
			{"id": "编号"},
			{"name": "名称"},
			{"code": "编码"},
			{"remark": "备注"},
		},
		Rows: func() interface{} {
			return &[]models.Provinces{}
		},
		Row: func() interface{} {
			return &models.Provinces{}
		},
		OptionAll: true,
		Validator: validations.Provinces,
		QueryCond: map[string]interface{}{
			"code":   "%",
			"name":   "%",
			"remark": "%",
		},
	},
}
