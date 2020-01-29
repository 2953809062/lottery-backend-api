package models

/// 城市
type Cities struct {
	Id           uint64 `json:"id"`            //编号
	ProvinceId   uint64 `json:"province_id"`   //省份编号
	ProvinceCode string `json:"province_code"` //省份编码
	Name         string `json:"name"`          //名称
	Code         string `json:"code"`          //编码
	Remark       string `json:"remark"`        //备注
}
