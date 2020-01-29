package models

/// 玩法总类
type PlayGroups struct {
	Id         uint64 `json:"id" xorm:"id"`        //8/编号
	CategoryId uint64 `json:"lottery_category_id"` //8/彩种分类
	Name       string `json:"name"`                //名称
	IsSpecial  uint16 `json:"is_special"`          //特别玩法
	Remark     string `json:"remark"`              //备注
}
