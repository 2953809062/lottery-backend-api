package models

/// 彩种玩法
type LotteryPlays struct {
	Id          uint64  `json:"id"`          //编号
	CategoryId  uint64  `json:"category_id"` //8/彩种分类
	PlayGroupId uint64  `json:"play_group_id"`
	PlayTypeId  uint64  `json:"play_type_id"`
	PlayId      uint64  `json:"play_id"`
	LotteryId   uint64  `json:"lottery_id"`
	Odds        float32 `json:"odds"`
	Remark      string  `json:"remark"` //备注
}
