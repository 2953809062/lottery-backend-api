package router

import (
	"controllers"
	"middlewares"

	"github.com/gin-gonic/gin"
)

/// 初始化路由
func Init(router *gin.Engine) {

	router.Use(middlewares.Cors()) //跨域

	router.GET("/", controllers.Index.Index) //默认首页
	v1 := router.Group("/v1")                //v1
	{
		noAuth := v1.Group("/")
		{
			noAuth.GET("/", controllers.Index.Index)
			noAuth.GET("/index", controllers.Index.Index)
			noAuth.POST("/index/login", controllers.Index.Login)

			noAuth.GET("/conf/log_levels", controllers.Conf.LogLevels)
			noAuth.GET("/conf/log_types", controllers.Conf.LogTypes)

			noAuth.GET("/platforms", controllers.Platforms.List)
			noAuth.GET("/platforms/all", controllers.Platforms.All)
			noAuth.GET("/platforms/delete", controllers.Platforms.Delete)
			noAuth.GET("/platforms/detail", controllers.Platforms.Detail)
			noAuth.POST("/platforms/create", controllers.Platforms.Create)
			noAuth.POST("/platforms/update", controllers.Platforms.Update)

			noAuth.GET("/sites", controllers.Sites.List)
			noAuth.GET("/sites/all", controllers.Sites.All)
			noAuth.GET("/sites/delete", controllers.Sites.Delete)
			noAuth.GET("/sites/detail", controllers.Sites.Detail)
			noAuth.POST("/sites/create", controllers.Sites.Create)
			noAuth.POST("/sites//update", controllers.Sites.Update)

			noAuth.GET("/site_configs", controllers.SiteConfigs.List)
			noAuth.GET("/site_configs/delete", controllers.SiteConfigs.Delete)
			noAuth.GET("/site_configs/detail", controllers.SiteConfigs.Detail)
			noAuth.POST("/site_configs/create", controllers.SiteConfigs.Create)
			noAuth.POST("/site_configs/update", controllers.SiteConfigs.Update)

			noAuth.GET("/admin_roles", controllers.AdminRoles.List)
			noAuth.GET("/admin_roles/all", controllers.AdminRoles.All)
			noAuth.GET("/admin_roles/delete", controllers.AdminRoles.Delete)
			noAuth.GET("/admin_roles/detail", controllers.AdminRoles.Detail)
			noAuth.POST("/admin_roles/create", controllers.AdminRoles.Create)
			noAuth.POST("/admin_roles/update", controllers.AdminRoles.Update)

			noAuth.GET("/admins", controllers.Admins.List)
			noAuth.GET("/admins/delete", controllers.Admins.Delete)
			noAuth.GET("/admins/detail", controllers.Admins.Detail)
			noAuth.POST("/admins/create", controllers.Admins.Create)
			noAuth.POST("/admins/update", controllers.Admins.Update)

			noAuth.GET("/admin_logs", controllers.AdminLogs.List)
			noAuth.GET("/admin_logs/delete", controllers.AdminLogs.Delete)

			noAuth.GET("/admin_login_logs", controllers.AdminLoginLogs.List)
			noAuth.GET("/admin_login_logs/delete", controllers.AdminLoginLogs.Delete)

			noAuth.GET("/menus", controllers.Menus.List)
			noAuth.GET("/menus/delete", controllers.Menus.Delete)
			noAuth.GET("/menus/detail", controllers.Menus.Detail)
			noAuth.POST("/menus/create", controllers.Menus.Create)
			noAuth.POST("/menus/update", controllers.Menus.Update)

			noAuth.GET("/users", controllers.Users.List)
			noAuth.GET("/users/delete", controllers.Users.Delete)
			noAuth.GET("/users/detail", controllers.Users.Detail)
			noAuth.POST("/users/create", controllers.Users.Create)
			noAuth.POST("/users/update", controllers.Users.Update)

			noAuth.GET("/user_accounts", controllers.UserAccounts.List)
			noAuth.GET("/user_accounts/delete", controllers.UserAccounts.Delete)
			noAuth.GET("/user_accounts/detail", controllers.UserAccounts.Detail)
			noAuth.POST("/user_accounts/create", controllers.UserAccounts.Create)
			noAuth.POST("/user_accounts/update", controllers.UserAccounts.Update)

			noAuth.GET("/user_levels", controllers.UserLevels.List)
			noAuth.GET("/user_levels/all", controllers.UserLevels.All)
			noAuth.GET("/user_levels/delete", controllers.UserLevels.Delete)
			noAuth.GET("/user_levels/detail", controllers.UserLevels.Detail)
			noAuth.POST("/user_levels/create", controllers.UserLevels.Create)
			noAuth.POST("/user_levels/update", controllers.UserLevels.Update)

			noAuth.GET("/user_roles", controllers.UserRoles.List)
			noAuth.GET("/user_roles/all", controllers.UserRoles.All)
			noAuth.GET("/user_roles/delete", controllers.UserRoles.Delete)
			noAuth.GET("/user_roles/detail", controllers.UserRoles.Detail)
			noAuth.POST("/user_roles/create", controllers.UserRoles.Create)
			noAuth.POST("/user_roles/update", controllers.UserRoles.Update)

			noAuth.GET("/notices", controllers.Notices.List)
			noAuth.GET("/notices/delete", controllers.Notices.Delete)
			noAuth.GET("/notices/detail", controllers.Notices.Detail)
			noAuth.POST("/notices/create", controllers.Notices.Create)
			noAuth.POST("/notices/update", controllers.Notices.Update)

			noAuth.GET("/activities", controllers.Activities.List)
			noAuth.GET("/activities/delete", controllers.Activities.Delete)
			noAuth.GET("/activities/detail", controllers.Activities.Detail)
			noAuth.POST("/activities/create", controllers.Activities.Create)
			noAuth.POST("/activities/update", controllers.Activities.Update)

			noAuth.GET("/game_categories", controllers.GameCategories.List)
			noAuth.GET("/game_categories/all", controllers.GameCategories.All)
			noAuth.GET("/game_categories/delete", controllers.GameCategories.Delete)
			noAuth.GET("/game_categories/detail", controllers.GameCategories.Detail)
			noAuth.POST("/game_categories/create", controllers.GameCategories.Create)
			noAuth.POST("/game_categories/update", controllers.GameCategories.Update)

			noAuth.GET("/games", controllers.Games.List)
			noAuth.GET("/games/delete", controllers.Games.Delete)
			noAuth.GET("/games/detail", controllers.Games.Detail)
			noAuth.POST("/games/create", controllers.Games.Create)
			noAuth.POST("/games/update", controllers.Games.Update)

			noAuth.GET("/user_charges", controllers.UserCharges.List)
			noAuth.GET("/user_charges/delete", controllers.UserCharges.Delete)
			noAuth.GET("/user_charges/detail", controllers.UserCharges.Detail)
			noAuth.POST("/user_charges/create", controllers.UserCharges.Create)
			noAuth.POST("/user_charges/update", controllers.UserCharges.Update)

			noAuth.GET("/user_cards", controllers.UserCards.List)
			noAuth.GET("/user_cards/delete", controllers.UserCards.Delete)
			noAuth.GET("/user_cards/detail", controllers.UserCards.Detail)
			noAuth.POST("/user_cards/create", controllers.UserCards.Create)
			noAuth.POST("/user_cards/update", controllers.UserCards.Update)

			noAuth.GET("/user_withdraws", controllers.UserWithdraws.List)
			noAuth.GET("/user_withdraws/delete", controllers.UserWithdraws.Delete)
			noAuth.GET("/user_withdraws/detail", controllers.UserWithdraws.Detail)
			noAuth.POST("/user_withdraws/create", controllers.UserWithdraws.Create)
			noAuth.POST("/user_withdraws/update", controllers.UserWithdraws.Update)

			noAuth.GET("/banks", controllers.Banks.List)
			noAuth.GET("/banks/all", controllers.Banks.All)
			noAuth.GET("/banks/delete", controllers.Banks.Delete)
			noAuth.GET("/banks/detail", controllers.Banks.Detail)
			noAuth.POST("/banks/create", controllers.Banks.Create)
			noAuth.POST("/banks/update", controllers.Banks.Update)

			noAuth.GET("/provinces", controllers.Provinces.List)
			noAuth.GET("/provinces/all", controllers.Provinces.All)
			noAuth.GET("/provinces/delete", controllers.Provinces.Delete)
			noAuth.GET("/provinces/detail", controllers.Provinces.Detail)
			noAuth.POST("/provinces/create", controllers.Provinces.Create)
			noAuth.POST("/provinces/update", controllers.Provinces.Update)

			noAuth.GET("/cities", controllers.Cities.List)
			noAuth.GET("/cities/all", controllers.Cities.All)
			noAuth.GET("/cities/delete", controllers.Cities.Delete)
			noAuth.GET("/cities/detail", controllers.Cities.Detail)
			noAuth.POST("/cities/create", controllers.Cities.Create)
			noAuth.POST("/cities/update", controllers.Cities.Update)

			noAuth.GET("/configs", controllers.Configs.List)
			noAuth.GET("/configs/all", controllers.Configs.All)
			noAuth.GET("/configs/delete", controllers.Configs.Delete)
			noAuth.GET("/configs/detail", controllers.Configs.Detail)
			noAuth.POST("/configs/create", controllers.Configs.Create)
			noAuth.POST("/configs/update", controllers.Configs.Update)

			noAuth.GET("/parameters", controllers.Parameters.List)
			noAuth.GET("/parameters/all", controllers.Parameters.All)
			noAuth.GET("/parameters/delete", controllers.Parameters.Delete)
			noAuth.GET("/parameters/detail", controllers.Parameters.Detail)
			noAuth.POST("/parameters/create", controllers.Parameters.Create)
			noAuth.POST("/parameters/update", controllers.Parameters.Update)

			noAuth.GET("/help_categories", controllers.HelpCategories.List)
			noAuth.GET("/help_categories/all", controllers.HelpCategories.All)
			noAuth.GET("/help_categories/delete", controllers.HelpCategories.Delete)
			noAuth.GET("/help_categories/detail", controllers.HelpCategories.Detail)
			noAuth.POST("/help_categories/create", controllers.HelpCategories.Create)
			noAuth.POST("/help_categories/update", controllers.HelpCategories.Update)

			noAuth.GET("/helps", controllers.Helps.List)
			noAuth.GET("/helps/delete", controllers.Helps.Delete)
			noAuth.GET("/helps/detail", controllers.Helps.Detail)
			noAuth.POST("/helps/create", controllers.Helps.Create)
			noAuth.POST("/helps/update", controllers.Helps.Update)

			noAuth.GET("/lottery_categories", controllers.LotteryCategories.List)
			noAuth.GET("/lottery_categories/all", controllers.LotteryCategories.All)
			noAuth.GET("/lottery_categories/delete", controllers.LotteryCategories.Delete)
			noAuth.GET("/lottery_categories/detail", controllers.LotteryCategories.Detail)
			noAuth.POST("/lottery_categories/create", controllers.LotteryCategories.Create)
			noAuth.POST("/lottery_categories/update", controllers.LotteryCategories.Update)

			noAuth.GET("/lottery_tags", controllers.LotteryTags.List)
			noAuth.GET("/lottery_tags/all", controllers.LotteryTags.All)
			noAuth.GET("/lottery_tags/delete", controllers.LotteryTags.Delete)
			noAuth.GET("/lottery_tags/detail", controllers.LotteryTags.Detail)
			noAuth.POST("/lottery_tags/create", controllers.LotteryTags.Create)
			noAuth.POST("/lottery_tags/update", controllers.LotteryTags.Update)

			noAuth.GET("/lotteries", controllers.Lotteries.List)
			noAuth.GET("/lotteries/all", controllers.Lotteries.All)
			noAuth.GET("/lotteries/delete", controllers.Lotteries.Delete)
			noAuth.GET("/lotteries/detail", controllers.Lotteries.Detail)
			noAuth.POST("/lotteries/create", controllers.Lotteries.Create)
			noAuth.POST("/lotteries/update", controllers.Lotteries.Update)

			noAuth.GET("/play_groups", controllers.PlayGroups.List)
			noAuth.GET("/play_groups/all", controllers.PlayGroups.All)
			noAuth.GET("/play_groups/delete", controllers.PlayGroups.Delete)
			noAuth.GET("/play_groups/detail", controllers.PlayGroups.Detail)
			noAuth.POST("/play_groups/create", controllers.PlayGroups.Create)
			noAuth.POST("/play_groups/update", controllers.PlayGroups.Update)

			noAuth.GET("/play_types", controllers.PlayTypes.List)
			noAuth.GET("/play_types/all", controllers.PlayTypes.All)
			noAuth.GET("/play_types/delete", controllers.PlayTypes.Delete)
			noAuth.GET("/play_types/detail", controllers.PlayTypes.Detail)
			noAuth.POST("/play_types/create", controllers.PlayTypes.Create)
			noAuth.POST("/play_types/update", controllers.PlayTypes.Update)

			noAuth.GET("/play_notes", controllers.PlayNotes.List)
			noAuth.GET("/play_notes/all", controllers.PlayNotes.All)
			noAuth.GET("/play_notes/delete", controllers.PlayNotes.Delete)
			noAuth.GET("/play_notes/detail", controllers.PlayNotes.Detail)
			noAuth.POST("/play_notes/create", controllers.PlayNotes.Create)
			noAuth.POST("/play_notes/update", controllers.PlayNotes.Update)

			noAuth.GET("/plays", controllers.Plays.List)
			noAuth.GET("/plays/all", controllers.Plays.All)
			noAuth.GET("/plays/delete", controllers.Plays.Delete)
			noAuth.GET("/plays/detail", controllers.Plays.Detail)
			noAuth.POST("/plays/create", controllers.Plays.Create)
			noAuth.POST("/plays/update", controllers.Plays.Update)

			noAuth.GET("/open_times", controllers.OpenTimes.List)
			noAuth.GET("/open_times/delete", controllers.OpenTimes.Delete)
			noAuth.GET("/open_times/detail", controllers.OpenTimes.Detail)
			noAuth.POST("/open_times/create", controllers.OpenTimes.Create)
			noAuth.POST("/open_times/update", controllers.OpenTimes.Update)

			noAuth.GET("/open_periods", controllers.OpenPeriods.List)
			noAuth.GET("/open_periods/delete", controllers.OpenPeriods.Delete)
			noAuth.GET("/open_periods/detail", controllers.OpenPeriods.Detail)
			noAuth.POST("/open_periods/create", controllers.OpenPeriods.Create)
			noAuth.POST("/open_periods/update", controllers.OpenPeriods.Update)

			noAuth.GET("/open_numbers", controllers.OpenNumbers.List)
			noAuth.GET("/open_numbers/delete", controllers.OpenNumbers.Delete)
			noAuth.GET("/open_numbers/detail", controllers.OpenNumbers.Detail)
			noAuth.POST("/open_numbers/create", controllers.OpenNumbers.Create)
			noAuth.POST("/open_numbers/update", controllers.OpenNumbers.Update)

			noAuth.GET("/orders", controllers.Orders.List)
			noAuth.GET("/bets", controllers.Bets.List)

			noAuth.GET("/lottery_plays", controllers.LotteryPlays.List)
			noAuth.GET("/lottery_plays/all", controllers.LotteryPlays.All)
			noAuth.GET("/lottery_plays/delete", controllers.LotteryPlays.Delete)
			noAuth.GET("/lottery_plays/detail", controllers.LotteryPlays.Detail)
			noAuth.POST("/lottery_plays/create", controllers.LotteryPlays.Create)
			noAuth.POST("/lottery_plays/update", controllers.LotteryPlays.Update)

		}
	}
}
