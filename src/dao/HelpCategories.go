package dao

import "common"

/// 帮助分类
var HelpCategories = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "help_categories",
	},
}
