package models

/// 注单
type Bets struct {
	Id          uint64  `json:"id"`            //编号
	OrderNum    string  `json:"order_numb"`    //订单编号
	LotteryId   uint64  `json:"lottery_id"`    //彩种编号
	OrderId     uint64  `json:"order_id"`      //订单编号
	UserId      uint64  `json:"user_id"`       //用户编号
	UserName    string  `json:"user_name"`     //用户名称
	OpenNumber  string  `json:"open_number"`   //开奖号码
	CategoryId  uint64  `json:"category_id"`   //分类编号
	TagId       uint64  `json:"tag_id"`        //标签编号
	Period      string  `json:"period"`        //奖期
	PlayGroupId uint64  `json:"play_group_id"` //玩法大类
	PlayTypeId  uint64  `json:"play_type_id"`  //玩法子类
	PlayId      uint64  `json:"play_id"`       //玩法编号
	BetNumbers  string  `json:"bet_numbers"`   //投注号码
	Ymd         uint32  `json:"ymd"`           //年月日
	BetAmount   float32 `json:"bet_amount"`    //投注金额
	BetCount    uint32  `json:"bet_count"`     //投注数量
	BetTime     uint32  `json:"bet_time"`      //投注时间
	Prize       float32 `json:"prize"`         //中奖金额
	OpenTime    uint32  `json:"open_time"`     //开奖时间
	Prized      float32 `json:"prized"`        //已中金额
	PrizedCount uint32  `json:"prized_count"`  //已中注数
	PrizedTime  uint32  `json:"prized_time"`   //已中时间
	Created     uint32  `json:"created"`       //添加时间
	Updated     uint32  `json:"updated"`       //修改时间
	Status      uint8   `json:"status"`        //状态
}
