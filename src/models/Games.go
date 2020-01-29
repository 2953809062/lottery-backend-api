package models

/// 游戏
type Games struct {
	Id         uint64 `json:"id"`               //编号
	CategoryId uint64 `json:"game_category_id"` //分类编号
	Name       string `json:"name"`             //名称
	Remark     string `json:"remark"`           //备注
	Status     uint16 `json:"status"`           //状态
	Created    uint32 `json:"created"`          //添加时间
	Updated    uint32 `json:"updated"`          //修改时间
}
