package models

/// 活动
type Activities struct {
	Id          uint64 `json:"id"`           //编号
	Title       string `json:"title"`        //标题
	Status      uint16 `json:"status"`       //状态
	Sort        int64  `json:"sort"`         //排序
	Content     string `json:"content"`      //内容
	PeriodStart uint32 `json:"period_start"` //添加时间
	PeriodEnd   uint32 `json:"period_end"`   //修改时间
	Created     uint32 `json:"created"`      //添加时间
	Updated     uint32 `json:"updated"`      //修改时间
}

/// rows
type ActivitiesRow struct {
	Id          uint64 `json:"id"`
	Title       string `json:"title"`
	Status      uint16 `json:"status"`
	Sort        int64  `json:"sort"`
	PeriodStart uint32 `json:"period_start"` //添加时间
	PeriodEnd   uint32 `json:"period_end"`   //修改时间
	Created     uint32 `json:"created"`
	Updated     uint32 `json:"updated"`
}
