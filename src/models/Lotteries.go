package models

/// 彩种
type Lotteries struct {
	Id         uint64 `json:"id"`                  //8/编号
	CategoryId uint64 `json:"lottery_category_id"` //分类编号
	TagId      uint64 `json:"tag_id"`              //标签编号
	Sort       int32  `json:"sort"`                //8/排序
	Status     uint32 `json:"status"`              //4/状态
	Created    uint32 `json:"created"`             //4/添加时间
	Updated    uint32 `json:"updated"`             //4/修改时间
	Name       string `json:"name"`                //名称
	Remark     string `json:"remark"`              //备注
}
