package models

/// 用户充值
type UserCharges struct {
	Id             uint64  `json:"id"`              //编号
	UserId         uint64  `json:"user_id"`         //用户编号
	Amount         float32 `json:"amount"`          //充值金额
	AmountReal     float32 `json:"amount_real"`     //实充金额
	AmountActivity float32 `json:"amount_activity"` //活动赠送
	AmountGift     float32 `json:"amount_gift"`     //充值赠送
	PayType        uint16  `json:"pay_type"`        //支付方式, 线上, 线下
	IsFirst        uint16  `json:"is_first"`        //是否首充
	Status         uint16  `json:"status"`          //状态
	Created        uint32  `json:"created"`         //添加时间
	Updated        uint32  `json:"updated"`         //修改时间
	Finished       uint32  `json:"finished"`        //完成时间
	UserName       string  `json:"user_name"`       //用户名称
	Reason         string  `json:"reason"`          //拒绝原因
}

/// for controller rows
type UserChargesRow struct {
	Id             uint64  `json:"id"`
	UserId         uint64  `json:"user_id"`
	Amount         float32 `json:"amount"`
	AmountReal     float32 `json:"amount_real"`
	AmountActivity float32 `json:"amount_activity"`
	AmountGift     float32 `json:"amount_gift"`
	PayType        uint16  `json:"pay_type"`
	IsFirst        uint16  `json:"is_first"`
	Status         uint16  `json:"status"`
	Created        uint32  `json:"created"`
	Updated        uint32  `json:"updated"`
	Finished       uint32  `json:"finished"`
	UserName       string  `json:"user_name"`
	Reason         string  `json:"reason"`
}
