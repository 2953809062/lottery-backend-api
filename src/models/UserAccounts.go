package models

/// 用户账户表
type UserAccounts struct {
	Id       uint64  `json:"id"`        //编号
	UserId   uint64  `json:"user_id"`   //用户编号
	UserName string  `json:"user_name"` //用户名称
	Remain   float32 `json:"remain"`    //可用余额
	Frozen   float32 `json:"frozen"`    //冻结金额
	Total    float32 `json:"total"`     //可用总计
	Activity float32 `json:"activity"`  //活动金额
	Charged  float32 `json:"charged"`   //充值总额
	Withdraw float32 `json:"withdraw"`  //提现总额
	TotalIn  float32 `json:"total_in"`  //总计入款
	TotalOut float32 `json:"total_out"` //总计出款
	Updated  uint32  `json:"updated"`   //最后更新
}

/// rows
type UserAccountsRow struct {
	Id       uint64  `json:"id"`
	UserId   uint64  `json:"user_id"`
	UserName string  `json:"user_name"`
	Remain   float32 `json:"remain"`
	Frozen   float32 `json:"frozen"`
	Total    float32 `json:"total"`
	Charged  float32 `json:"charged"`
	Activity float32 `json:"activity"`
	Withdraw float32 `json:"withdraw"`
	TotalIn  float32 `json:"total_in"`
	TotalOut float32 `json:"total_out"`
	IsLocked float32 `json:"is_locked"`
	Updated  uint32  `json:"updated"`
}
