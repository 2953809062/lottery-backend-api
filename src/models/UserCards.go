package models

/// 用户绑卡
type UserCards struct {
	Id          uint64 `json:"id"`            //编号
	UserId      uint64 `json:"user_id"`       //用户编号
	UserName    string `json:"user_name"`     //用户名称
	BankId      uint64 `json:"bank_id"`       //银行编号
	BankName    string `json:"bank_name"`     //银行名称
	BankSubName string `json:"bank_sub_name"` //支行名称
	BankNo      string `json:"bank_no"`       //银行账号
	RealName    string `json:"real_name"`     //真实姓名
	Remark      string `json:"remark"`        //备注
	ProvinceId  uint32 `json:"province_id"`   //省份编号
	CityId      uint32 `json:"city_id"`       //城市编号
	Created     uint32 `json:"created"`       //添加时间
	Updated     uint32 `json:"updated"`       //修改时间
}

/// rows
type UserCardsRow struct {
	Id          uint64 `json:"id"`            //编号
	UserId      uint64 `json:"user_id"`       //用户编号
	UserName    string `json:"user_name"`     //用户名称
	BankId      uint64 `json:"bank_id"`       //银行编号
	BankName    string `json:"bank_name"`     //银行名称
	BankSubName string `json:"bank_sub_name"` //支行名称
	BankNo      string `json:"bank_no"`       //银行账号
	RealName    string `json:"real_name"`     //真实姓名
	Remark      string `json:"remark"`        //备注
	ProvinceId  uint32 `json:"province_id"`   //省份编号
	CityId      uint32 `json:"city_id"`       //城市编号
	Created     uint32 `json:"created"`       //添加时间
}
