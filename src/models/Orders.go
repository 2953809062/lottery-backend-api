package models

/// 订单
type Orders struct {
	Id       uint64  `json:"id"`        //编号
	UserId   uint64  `json:"user_id"`   //用户编号
	UserName string  `json:"user_name"` //用户名称
	Ymd      uint32  `json:"ymd"`       //年月日
	Quantity uint32  `json:"quantity"`  //注单数量
	Amount   float32 `json:"amount"`    //订单金额
	Created  uint32  `json:"created"`   //创建时间
	Updated  uint32  `json:"updated"`   //修改时间
	Status   uint8   `json:"status"`    //订单状态
}
