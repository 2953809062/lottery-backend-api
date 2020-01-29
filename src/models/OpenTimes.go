package models

/// 开奖时间
type OpenTimes struct {
	Id           uint64 `json:"id"`            //编号
	LotteryId    uint64 `json:"lottery_id"`    //彩种编号
	PeriodNumber string `json:"period_number"` //期数
	TimeClose    string `json:"time_close"`    //封盘时间
	TimeOpen     string `json:"time_open"`     //开奖时间
	Sort         int32  `json:"sort"`          //排序
	DayOffset    uint8  `json:"day_offset"`    //天数偏移
	IsBegin      uint8  `json:"is_begin"`      //是否首期
	IsEnd        uint8  `json:"is_end"`        //是否末期
}
