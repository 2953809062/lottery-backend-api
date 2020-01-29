package models

/// 开奖结果
type OpenNumbers struct {
	Id           uint64 `json:"id"`            //编号
	LotteryId    uint64 `json:"lottery_id"`    //彩种编号
	PeriodNumber string `json:"period_number"` //奖期
	Numbers      string `json:"numbers"`       //开奖号码
	OpenTime     string `json:"open_time"`     //开奖时间
	Sort         int32  `json:"sort"`          //排序
	IsFinished   uint8  `json:"is_finished"`   //是否开完
	Created      uint32 `json:"created"`       //添加时间
	Updated      uint32 `json:"updated"`       //修改时间
}
