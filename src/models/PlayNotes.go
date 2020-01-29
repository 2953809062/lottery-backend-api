package models

/// 玩法说明
type PlayNotes struct {
	Id        uint64 `json:"id"`         //8/编号
	LotteryId uint64 `json:"lottery_id"` //彩种编号
	Title     string `json:"title"`      //标题
	Content   string `json:"content"`    //内容
	Sort      int32  `json:"sort"`       //8/排序
	Status    uint32 `json:"status"`     //4/状态
	Created   uint32 `json:"created"`    //4/添加时间
	Updated   uint32 `json:"updated"`    //4/修改时间
}

/// rows
type PlayNotesRow struct {
	Id        uint64 `json:"id"`         //8/编号
	LotteryId uint64 `json:"lottery_id"` //彩种编号
	Title     string `json:"title"`      //标题
	Sort      int32  `json:"sort"`       //8/排序
	Status    uint32 `json:"status"`     //4/状态
	Created   uint32 `json:"created"`    //4/添加时间
	Updated   uint32 `json:"updated"`    //4/修改时间
}
