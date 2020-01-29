package models

/// 玩法
type Plays struct {
	Id         uint64  `json:"id"`                  //8/编号
	CategoryId uint64  `json:"lottery_category_id"` //8/彩种分类
	GroupId    uint64  `json:"play_group_id"`       //总类编号
	TypeId     uint64  `json:"play_type_id"`        //子类编号
	Name       string  `json:"name"`                //名称
	Odds       float32 `json:"odds"`                //4/赔率
	Remark     string  `json:"remark"`              //备注
}
