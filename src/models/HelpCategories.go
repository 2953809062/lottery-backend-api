package models

/// 帮助分类
type HelpCategories struct {
	Id     uint64 `json:"id"`     //编号
	Name   string `json:"name"`   //名称
	Remark string `json:"remark"` //备注
}
