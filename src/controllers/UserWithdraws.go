package controllers

import (
	"common"
	"dao"
	"models"
)

/// 用户提现
var UserWithdraws = struct {
	*common.Backend //基类
}{
	Backend: &common.Backend{
		Model: dao.UserWithdraws,
		Headers: []map[string]string{
			{"id": "编号"},
			{"user_id": "用户编号"},
			{"user_name": "用户名称"},
			{"real_name": "真实姓名"},
			{"amount": "提现金额"},
			{"bank_name": "银行名称"},
			{"bank_sub_name": "支行名称"},
			{"bank_no": "银行账号"},
			{"status": "状态"},
			{"created": "申请时间"},
			{"finished": "完成时间"},
			{"reason": "拒绝理由"},
		},
		Rows: func() interface{} {
			return &[]models.UserWithdrawsRow{}
		},
		Row: func() interface{} {
			return &models.UserWithdraws{}
		},
	},
}
