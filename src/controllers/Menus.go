package controllers

import (
	"common"
	"dao"
	"models"
	"validations"
)

/// 后台菜单
var Menus = struct {
	*common.Backend //基类
}{
	Backend: &common.Backend{
		Model: dao.Menus,
		Headers: []map[string]string{
			{"id": "编号"},
			{"name": "用户名称"},
			{"type": "菜单类型"},
			{"level": "菜单层级"},
			{"url": "链接地址"},
			{"status": "状态"},
			{"sort": "排序"},
			{"created": "添加时间"},
		},
		OptionCreate: true,
		OptionUpdate: true,
		OptionDelete: true,
		Rows: func() interface{} {
			return &[]models.MenusRow{}
		},
		Row: func() interface{} {
			return &models.Menus{}
		},
		Validator: validations.Menus,
	},
}
