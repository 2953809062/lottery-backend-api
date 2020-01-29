package models

/// 玩法
type PlayTypes struct {
	Id         uint64 `json:"id" xorm:"id"`        //8/编号
	CategoryId uint64 `json:"lottery_category_id"` //8/彩种分类
	GroupId    uint64 `json:"play_group_id"`       //总类编号
	Name       string `json:"name"`                //名称
	Remark     string `json:"remark"`              //备注
}
