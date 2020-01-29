package models

/// 开奖奖期
type OpenPeriods struct {
	Id           uint64 `json:"id"`            //编号
	LotteryId    uint64 `json:"lottery_id"`    //彩种编号
	PeriodNumber string `json:"period_number"` //奖期
	TimeClose    string `json:"time_close"`    //封盘时间
	TimeOpen     string `json:"time_open"`     //开奖时间
	DayOffset    uint8  `json:"day_offset"`    //天数编移
	IsBegin      uint8  `json:"is_begin"`      //是否首期
	IsEnd        uint8  `json:"is_end"`        //是否末期
	IsOpened     uint8  `json:"is_opened"`     //是否开过
	Sort         int32  `json:"sort"`          //排序
	Created      uint32 `json:"created"`       //添加时间
	Updated      uint32 `json:"updated"`       //修改时间
}
