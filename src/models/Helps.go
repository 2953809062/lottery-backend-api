package models

/// 菜单
type Helps struct {
	Id      uint64 `json:"id"`      //编号
	Title   string `json:"title"`   //标题
	Status  uint16 `json:"status"`  //状态
	Sort    int64  `json:"sort"`    //排序
	Content string `json:"content"` //内容
	Created uint32 `json:"created"` //添加时间
	Updated uint32 `json:"updated"` //修改时间
}

/// rows
type HelpsRow struct {
	Id         uint64 `json:"id"`
	CategoryId uint64 `json:"help_category_id"`
	Title      string `json:"title"`
	Status     uint16 `json:"status"`
	Sort       int64  `json:"sort"`
	Content    string `json:"content"`
	Created    uint32 `json:"created"`
	Updated    uint32 `json:"updated"`
}
