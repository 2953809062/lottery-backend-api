package models

/// 省份
type Provinces struct {
	Id     uint64 `json:"id"`     //编号
	Name   string `json:"name"`   //名称
	Code   string `json:"code"`   //编码
	Remark string `json:"remark"` //备注
}
