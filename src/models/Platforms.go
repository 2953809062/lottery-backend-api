package models

/// 平台
type Platforms struct {
	Id      uint64 `json:"id" xorm:"id"`         //8/编号
	Sort    int32  `json:"sort" xorm:"sort"`     //8/排序
	Status  uint32 `json:"status" xorm:"status"` //4/状态
	Created uint32 `json:"created"`              //4/添加时间
	Updated uint32 `json:"updated"`              //4/修改时间
	Name    string `json:"name"`                 //名称
	Remark  string `json:"remark"`               //备注
}

/// rows
type PlatformsRow struct {
	Id      uint64 `json:"id"`
	Name    string `json:"name"`
	Remark  string `json:"remark"`
	Sort    int64  `json:"sort"`
	Status  uint32 `json:"status"`
	Created uint32 `json:"created"`
	Updated uint32 `json:"updated"`
}
