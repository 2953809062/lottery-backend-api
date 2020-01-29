package models

/// 银行
type Banks struct {
	Id     uint64 `json:"id"`     //编号
	Name   string `json:"name"`   //名称
	Status uint16 `json:"status"` //状态
	Sort   int64  `json:"sort"`   //排序
	Remark string `json:"remark"` //备注
}
