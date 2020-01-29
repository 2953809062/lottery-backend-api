package models

/// 用户提现
type UserWithdraws struct {
	Id          uint64  `json:"id"`            //编号
	UserId      uint64  `json:"user_id"`       //用户编号
	UserName    string  `json:"user_name"`     //用户名称
	Amount      float32 `json:"amount"`        //金额
	BankId      uint32  `json:"bank_id"`       //银行编号
	BankName    string  `json:"bank_name"`     //银行名称
	BankSubName string  `json:"bank_sub_name"` //支行名称
	BankNo      string  `json:"bank_no"`       //银行账号
	RealName    string  `json:"real_name"`     //真实姓名
	Status      uint16  `json:"status"`        //状态
	Created     uint32  `json:"created"`       //添加时间
	Updated     uint32  `json:"updated"`       //修改时间
	Finished    uint32  `json:"finished"`      //完成时间
	Reason      string  `json:"reason"`        //拒绝原因
	CardId      uint64  `json:"card_id"`       //绑卡编号
	ProvinceId  uint64  `json:"province_id"`   //省份编号
	CityId      uint64  `json:"city_id"`       //城市编号
}

/// rows
type UserWithdrawsRow struct {
	Id          uint64  `json:"id"`
	UserId      uint64  `json:"user_id"`
	UserName    string  `json:"user_name"`
	Amount      float32 `json:"amount"`
	BankName    string  `json:"bank_name"`
	BankSubName string  `json:"bank_sub_name"`
	BankNo      string  `json:"bank_no"`
	RealName    string  `json:"real_name"`
	Status      uint16  `json:"status"`
	Created     uint32  `json:"created"`
	Finished    uint32  `json:"finished"`
	Reason      string  `json:"reason"`
	ProvinceId  uint64  `json:"province_id"`
	CityId      uint64  `json:"city_id"`
}
