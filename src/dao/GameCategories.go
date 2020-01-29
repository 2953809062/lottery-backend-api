package dao

import "common"

var GameCategories = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "game_categories",
	},
}
