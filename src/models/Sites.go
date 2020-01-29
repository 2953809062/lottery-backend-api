package models

/// 盘口
type Sites struct {
	Id         uint64 `json:"id"`          //8/编号
	PlatformId uint64 `json:"platform_id"` //8/平台编号
	Status     uint32 `json:"status"`      //4/状态
	Sort       int32  `json:"sort"`        //8/排序
	Created    uint32 `json:"created"`     //4/添加时间
	Updated    uint32 `json:"updated"`     //4/修改时间
	Remark     string `json:"remark"`      //备注
	Name       string `json:"name"`        //名称
	Urls       string `json:"urls"`        //域名
	Api        string `json:"api"`         //前台api
	AdminUrl   string `json:"admin_url"`   //后台地址
	AdminApi   string `json:"admin_api"`   //后台api
}

/// rows
type SitesRow struct {
	Id         uint64 `json:"id"`
	PlatformId uint64 `json:"platform_id"`
	Status     uint32 `json:"status"`
	Remark     string `json:"remark"`
	Name       string `json:"name"`
	Sort       int64  `json:"sort"`
	Created    uint32 `json:"created"`
	Updated    uint32 `json:"updated"`
}
