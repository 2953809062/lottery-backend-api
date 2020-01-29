package models

/// 游戏分类
type GameCategories struct {
	Id     uint64 `json:"id"`     //编号
	Name   string `json:"name"`   //名称
	Remark string `json:"remark"` //备注
}
