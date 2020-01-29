var routers = {
	activities:		[[600, 400], function() { }, function() { }],
	admin_roles:	[[600, 250], function() { }, function() { }],
	admins:			[[600, 500], function() { caches.fill('adminRoles'); }, function() { caches.fill('adminRoles'); }],
	banks:			[[600, 400], function() { }, function() { }],
	configs:		[[600, 400], function() { }, function() { }],
	game_categories: [[600, 250], function() { }, function() { }],
	games:			[[600, 400], function() { caches.fill('gameCategories'); }, function() { caches.fill('gameCategories'); }],
	menus:			[[600, 400], function() { }, function() { }],
	notices:		[[600, 400], function() { }, function() { }],
	platforms:		[[600, 400], function() { }, function() { }],
	site_configs:	[[600, 500], function() { 
		caches.fill('platforms');
		caches.fill('sites');
	}, function() { 
		caches.fill('platforms');
		caches.fill('sites');
	}],
	sites:			[[600, 400], function() { caches.fill('platforms'); }, function() { caches.fill('platforms'); }],
	user_cards:		[[600, 400], function() { }, function() { }],
	user_levels:	[[600, 250], function() { }, function() { }],
	user_roles:		[[600, 250], function() { }, function() { }],
	users:			[[600, 400], function() { 
		caches.fill('userRoles');
		caches.fill('userLevels');
	}, function() { }],
	provinces:		[[], function() { }, function() { }],
	cities:			[[], function() { caches.fill("provinces"); }, null],
	admin_logs:		[null, function() { 
		caches.fill('logTypes');
		caches.fill('logLevels');
	}],
	help_categories: [[600, 250]],
	helps:			[[600, 500], function() { caches.fill('helpCategories'); }, function() { caches.fill('helpCategories'); }],
	lottery_tags:	[[600, 250]],
	lottery_categories:	[[600, 250]],
	lotteries:		[[600, 480], function() { 
		caches.fill('lotteryTags');
		caches.fill('lotteryCategories');
	}, function() { 
		caches.fill('lotteryTags');
		caches.fill('lotteryCategories');
	}],
	open_times: 		[[600, 580], function() { caches.fill('lotteries'); }, function() { caches.fill('lotteries'); }],
	open_periods: 	[[600, 580], function() { caches.fill('lotteries'); }, function() { caches.fill('lotteries'); }],
	open_numbers: 	[[600, 480], function() { caches.fill('lotteries'); }, function() { caches.fill('lotteries'); }],
	play_groups:	[[600, 250]],
	play_types:		[[600, 320], function() { caches.fill('playGroups'); }, function() { caches.fill('playGroups'); }],
	plays:			[[600, 400], function() { 
		caches.fill('playGroups');
		caches.fill('playTypes');
	}, function() { 
		caches.fill('playGroups');
		caches.fill('playTypes');
	}],
	play_notes:		[[600, 350], function() { caches.fill('lotteries'); }, function() { caches.fill('lotteries'); }],
	parameters:		[[600, 400]],
	orders: [null, function() { }, function() { }],
	bets: [null, function() { 
		caches.fill('lotteries');
		caches.fill('playGroups');
		caches.fill('playTypes');
		caches.fill('plays');
	}, function() { 
		caches.fill('lotteries');
		caches.fill('playGroups');
		caches.fill('playTypes');
		caches.fill('plays');
	}],
	lottery_plays:	[[600, 400], function() { 
		caches.fill('playGroups');
		caches.fill('playTypes');
		caches.fill('plays');
		caches.fill('lotteries');
	}, function() { 
		caches.fill('playGroups');
		caches.fill('playTypes');
		caches.fill('plays');
		caches.fill('lotteries');

	}]
};
