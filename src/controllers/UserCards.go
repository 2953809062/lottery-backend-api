package controllers

import (
	"common"
	"dao"
	"models"
)

/// 用户绑卡
var UserCards = struct {
	*common.Backend //基类
}{
	Backend: &common.Backend{
		Model: dao.UserCards,
		Headers: []map[string]string{
			{"id": "编号"},
			{"user_id": "用户编号"},
			{"user_name": "用户名称"},
			{"bank_name": "银行名称"},
			{"bank_sub_name": "支行名称"},
			{"bank_no": "银行账号"},
			{"real_name": "真实姓名"},
			{"province_id": "省份"},
			{"city_id": "城市"},
			{"created": "添加时间"},
			{"remark": "备注"},
		},
		OptionCreate: true,
		OptionUpdate: true,
		Rows: func() interface{} {
			return &[]models.UserCardsRow{}
		},
		Row: func() interface{} {
			return &models.UserCards{}
		},
	},
}
