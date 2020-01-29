package controllers

import (
	"common"
	"dao"
	"models"
)

/// 后台菜单
var UserAccounts = struct {
	*common.Backend //基类
}{
	Backend: &common.Backend{
		Model: dao.UserAccounts,
		Headers: []map[string]string{
			{"id": "编号"},
			{"user_id": "用户编号"},
			{"user_name": "用户名称"},
			{"remain": "可用余额"},
			{"frozen": "冻结金额"},
			{"total": "可用总额"},
			{"charged": "充值总额"},
			{"activity": "活动总额"},
			{"withdraw": "提现总额"},
			{"total_in": "入账总额"},
			{"total_out": "出账总额"},
			{"is_locked": "是否锁定"},
			{"updated": "最后修改"},
		},
		Rows: func() interface{} {
			return &[]models.UserAccountsRow{}
		},
		Row: func() interface{} {
			return &models.UserAccounts{}
		},
	},
}
