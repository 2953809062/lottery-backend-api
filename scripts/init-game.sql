/*** 库名: game001 ***/
/*** 用户: game001 ***/
/*** 密码: game001-x-lsl ***/
/** create new db **/
/* CREATE DATABASE IF NOT EXISTS game001 DEFAULT CHARSET=UTF8; */
/* GRANT ALL PRIVILEGES ON game001.* TO 'game001'@'%' IDENTIFIED BY 'game001-x-lsl'; */
/* FLUSH PRIVILEGES; */

USE game001;

/** 管理员表 **/
DROP TABLE IF EXISTS admins;
CREATE TABLE IF NOT EXISTS admins (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL DEFAULT '' COMMENT '管理员名称',
    password VARCHAR(32) NOT NULL DEFAULT '' COMMENT '管理员密码',
    secret VARCHAR(32) NOT NULL DEFAULT '' COMMENT 'secret',
    role_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '角色编号',
    login_count INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '登录次数',
    last_login INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '上次登录',
    last_ip VARCHAR(50) NOT NULL DEFAULT '' COMMENT '最后登录ip',
    last_region VARCHAR(50) NOT NULL DEFAULT '' COMMENT '最后登录地区',
    ips VARCHAR(200) NOT NULL DEFAULT '' COMMENT '允许登录IP',
    status TINYINT NOT NULL DEFAULT 0 COMMENT '状态',
    sort INT NOT NULL DEFAULT 0 COMMENT '排序',
    created INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '添加时间',
    updated INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '修改时间',
    remark VARCHAR(200) NOT NULL DEFAULT '' COMMENT '备注',
    PRIMARY KEY(id),
	INDEX(role_id),
    INDEX(sort),
    UNIQUE KEY(name)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI;
INSERT INTO admins(name, role_id, last_login, last_ip, last_region, ips, status, created, updated) VALUES
('admin', 1, UNIX_TIMESTAMP(), '127.0.0.1', '美国', '127.0.0.1', 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP());

/** 管理员角色表 **/
DROP TABLE IF EXISTS admin_roles;
CREATE TABLE IF NOT EXISTS admin_roles (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL DEFAULT '' COMMENT '角色名称',
    remark VARCHAR(200) NOT NULL DEFAULT '' COMMENT '备注',
    menus TEXT COMMENT '菜单权限',
    UNIQUE KEY(name),
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI;
INSERT INTO admin_roles (name, remark) VALUES
('系统用户', '平台最高管理权限'),
('管理员', '平台管理员'),
('编辑人员', '内容编辑'),
('财务人员', '财务管理'),
('运营人员', '运营推广'),
('测试用户', '后台测试');

/** 后台菜单表 **/
/* 类型: 1:主菜单, 2:子菜单, 3:标签  4:菜单 */
DROP TABLE IF EXISTS menus;
CREATE TABLE IF NOT EXISTS menus (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL DEFAULT '' COMMENT '菜单名称',
    type INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '菜单类型',
    level INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '菜单层级',
    status tinyINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态',
    sort INT NOT NULL DEFAULT 0 COMMENT '排序',
    url VARCHAR(100) NOT NULL DEFAULT '' COMMENT '链接地址',
    created INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '添加时间',
    updated INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '修改时间',
    UNIQUE KEY(name),
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI;
INSERT INTO menus (name, type, level, status, url, created, updated) VALUES
('默认菜单', 1, 1, 1, '/v1/admins', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());

/** 管理员日志表 **/
/* 日志级别: 0:普通 1:重要 2:警告, 3:致命 4:错误 5:特殊 9:其他 */
/* 日志类型: 0:普通操作 1:登录退出 2:权限相关 3:财务相关 4:内容相关 9:其他类型 */
DROP TABLE IF EXISTS admin_logs;
CREATE TABLE IF NOT EXISTS admin_logs (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	ymd INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '年月日',
    admin_id VARCHAR(50) NOT NULL DEFAULT '' COMMENT '管理员编号',
    admin_name VARCHAR(50) NOT NULL DEFAULT '' COMMENT '管理员名称',
    level tinyINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '日志级别',
    type tinyINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '日志类型',
    url VARCHAR(100) NOT NULL DEFAULT '' COMMENT '操作地址',
    remark VARCHAR(200) NOT NULL DEFAULT '' COMMENT '备注',
    created INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '添加时间',
    INDEX(type),
    INDEX(level),
    INDEX(admin_id),
    PRIMARY KEY(id, ymd)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI
PARTITION BY RANGE (ymd) (
	PARTITION p1911 VALUES LESS THAN (20191201),
	PARTITION p1912 VALUES LESS THAN (20200101),
	PARTITION p2001 VALUES LESS THAN (20200201),
	PARTITION p2002 VALUES LESS THAN (20200301),
	PARTITION p2003 VALUES LESS THAN (20200401),
	PARTITION p2004 VALUES LESS THAN (20200501),
	PARTITION p2005 VALUES LESS THAN (20200601),
	PARTITION p2006 VALUES LESS THAN (20200701),
	PARTITION p2007 VALUES LESS THAN (20200801),
	PARTITION p2008 VALUES LESS THAN (20200901),
	PARTITION p2009 VALUES LESS THAN (20201001),
	PARTITION p2010 VALUES LESS THAN (20201101),
	PARTITION p2011 VALUES LESS THAN (20201201),
	PARTITION p2012 VALUES LESS THAN (20210101),
	PARTITION p2101 VALUES LESS THAN MAXVALUE
);
INSERT INTO admin_logs(admin_id, admin_name, level, type, url, created, ymd) VALUES
(1, 'admin', 1, 1, '/v1/admins', UNIX_TIMESTAMP(), '20191121');

/** 管理员登录日志表 **/
DROP TABLE IF EXISTS admin_login_logs;
CREATE TABLE IF NOT EXISTS admin_login_logs (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	ymd INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '年月日',
    admin_id VARCHAR(50) NOT NULL DEFAULT '' COMMENT '管理员编号',
    admin_name VARCHAR(50) NOT NULL DEFAULT '' COMMENT '管理员名称',
    url VARCHAR(100) NOT NULL DEFAULT '' COMMENT '地址',
	ip VARCHAR(50) NOT NULL DEFAULT '' COMMENT '登录IP',
	region VARCHAR(50) NOT NULL DEFAULT '' COMMENT '登录地区',
    remark VARCHAR(200) NOT NULL DEFAULT '' COMMENT '备注',
    created INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '登录时间',
    INDEX(admin_id),
    PRIMARY KEY(id, ymd)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI 
PARTITION BY RANGE (ymd) (
	PARTITION p1911 VALUES LESS THAN (20191201),
	PARTITION p1912 VALUES LESS THAN (20200101),
	PARTITION p2001 VALUES LESS THAN (20200201),
	PARTITION p2002 VALUES LESS THAN (20200301),
	PARTITION p2003 VALUES LESS THAN (20200401),
	PARTITION p2004 VALUES LESS THAN (20200501),
	PARTITION p2005 VALUES LESS THAN (20200601),
	PARTITION p2006 VALUES LESS THAN (20200701),
	PARTITION p2007 VALUES LESS THAN (20200801),
	PARTITION p2008 VALUES LESS THAN (20200901),
	PARTITION p2009 VALUES LESS THAN (20201001),
	PARTITION p2010 VALUES LESS THAN (20201101),
	PARTITION p2011 VALUES LESS THAN (20201201),
	PARTITION p2012 VALUES LESS THAN (20210101),
	PARTITION p2101 VALUES LESS THAN MAXVALUE
);
INSERT INTO admin_login_logs(admin_id, admin_name, url, ip, region, created, ymd) VALUES
(1, 'admin', '/v1/admins', '127.0.0.1', '局域网', UNIX_TIMESTAMP(), '20191102');

/** 用户表 **/
/* 状态: 0:待审核 1:可用 2:冻结 3:停用 */
DROP TABLE IF EXISTS users;
CREATE TABLE IF NOT EXISTS users (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL DEFAULT '' COMMENT '用户名称',
    nickname VARCHAR(20) NOT NULL DEFAULT '' COMMENT '用户昵称',
    password VARCHAR(32) NOT NULL DEFAULT '' COMMENT '用户密码',
    role_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '角色编号',
    level_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户层级',
    last_login INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '最后登录时间',
    last_ip VARCHAR(50) NOT NULL DEFAULT '' COMMENT '最后登录IP',
    register_ip VARCHAR(50) NOT NULL DEFAULT '' COMMENT '注册IP',
    last_region VARCHAR(50) NOT NULL DEFAULT '' COMMENT '最后登录地区',
    login_count INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '登录次数',
    status tinyINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态',
    sort INT NOT NULL DEFAULT 0 COMMENT '排序',
    created INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '添加时间',
    updated INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '修改时间',
	INDEX(name),
	INDEX(role_id),
	INDEX(level_id),
	INDEX(created),
	INDEX(sort),
	INDEX(sort),
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI;
INSERT INTO users (name, nickname, role_id, level_id, last_login, last_ip, last_region, status, created, updated, register_ip) VALUES
('tempname', 'TEMPNAME', 1, 1, UNIX_TIMESTAMP(), '127.0.0.1', 'U.S.A', 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '127.0.0.1');

/** 用户财务表 **/
DROP TABLE IF EXISTS user_accounts;
CREATE TABLE IF NOT EXISTS user_accounts (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户编号',
    user_name VARCHAR(20) NOT NULL DEFAULT '' COMMENT '用户名称',
    remain DECIMAL(12, 3) NOT NULL DEFAULT 0 COMMENT '可用余额',
    frozen DECIMAL(12, 3) NOT NULL DEFAULT 0 COMMENT '冻结金额',
    total DECIMAL(12, 3) NOT NULL DEFAULT 0 COMMENT '账户总额',
    charged DECIMAL(12, 3) NOT NULL DEFAULT 0 COMMENT '充值总额',
    activity DECIMAL(12, 3) NOT NULL DEFAULT 0 COMMENT '活动金额',
    withdraw DECIMAL(12, 3) NOT NULL DEFAULT 0 COMMENT '提现总额',
    total_in DECIMAL(12, 3) NOT NULL DEFAULT 0 COMMENT '入账总额',
    total_out DECIMAL(12, 3) NOT NULL DEFAULT 0 COMMENT '出账总额',
    is_locked TINYINT NOT NULL DEFAULT 0 COMMENT '是否锁定',
    updated INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '最后账变时间',
    UNIQUE KEY(user_id),
	UNIQUE KEY(user_name),
	INDEX(is_locked),
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI;
INSERT INTO user_accounts(user_id, user_name, updated) VALUES
(1, 'tempname', UNIX_TIMESTAMP());

/** 用户层级表 **/
DROP TABLE IF EXISTS user_levels;
CREATE TABLE IF NOT EXISTS user_levels (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL DEFAULT '' COMMENT '名称',
    remark VARCHAR(200) NOT NULL DEFAULT '' COMMENT '备注',
    UNIQUE KEY(name),
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI;
INSERT INTO user_levels (name, remark) VALUES
('大客户', '优先级最高');

/** 用户角色表 **/
DROP TABLE IF EXISTS user_roles;
CREATE TABLE IF NOT EXISTS user_roles (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL DEFAULT '' COMMENT '管理员名称',
    remark VARCHAR(200) NOT NULL DEFAULT '' COMMENT '备注',
    UNIQUE KEY(name),
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI;
INSERT INTO user_roles (name, remark) VALUES
('VIP1', 'VIP1'),
('VIP2', 'VIP2');

/** 公告 **/
DROP TABLE IF EXISTS notices;
CREATE TABLE IF NOT EXISTS notices (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL DEFAULT '' COMMENT '标题',
    content text COMMENT '内容',
    sort INT NOT NULL DEFAULT 0 COMMENT 'sort',
    status TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态',
    created INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '添加时间',
    updated INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '修改时间',
    UNIQUE KEY(title),
	INDEX(sort),
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI;
INSERT INTO notices (title, created, updated, status) VALUES
('新用户注册即送千元大奖', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 1);

/** 活动 **/
DROP TABLE IF EXISTS activities;
CREATE TABLE IF NOT EXISTS activities (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL DEFAULT '' COMMENT '标题',
    content text COMMENT '内容',
    sort INT NOT NULL DEFAULT 0 COMMENT 'sort',
    status TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态',
	period_start INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '开始时间',
	period_end INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '结束时间',
    created INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '添加时间',
    updated INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '修改时间',
	INDEX(sort),
	INDEX(status),
    UNIQUE KEY(title),
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI;
INSERT INTO activities (title, created, updated, status) VALUES
('迎春节, 百万红包, 码上有礼活动', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 1);

/** 游戏分类 **/
DROP TABLE IF EXISTS game_categories;
CREATE TABLE IF NOT EXISTS game_categories (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL DEFAULT '' COMMENT '分类名称',
    remark VARCHAR(200) NOT NULL DEFAULT '' COMMENT '备注',
    UNIQUE KEY(name),
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI;
INSERT INTO game_categories (name, remark) VALUES
('彩票游戏', '彩票'),
('棋牌游戏', '棋牌');

/** 游戏 **/
DROP TABLE IF EXISTS games;
CREATE TABLE IF NOT EXISTS games (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	category_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '分类编号',
    name VARCHAR(50) NOT NULL DEFAULT '' COMMENT '分类名称',
    remark VARCHAR(200) NOT NULL DEFAULT '' COMMENT '备注',
	status TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态',
    created INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '添加时间',
    updated INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '修改时间',
	INDEX(status),
	INDEX(category_id),
    UNIQUE KEY(name),
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI;
INSERT INTO games (category_id, name, remark, created, updated, status) VALUES
(1, '彩票游戏', '彩票', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 1),
(2, '百人牛牛', '牛牛', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 1),
(2, '斗地主', '斗地主', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 1),
(2, '红黑大战', '扑克', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 1),
(2, '急速捕鱼', '捕鱼', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 1),
(2, '抢庄牛牛', '牛牛', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 1);

/** 充值记录 **/
DROP TABLE IF EXISTS user_charges;
CREATE TABLE IF NOT EXISTS user_charges (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	ymd INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '年月日',
	user_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户编号',
	user_name VARCHAR(20) NOT NULL DEFAULT '' COMMENT '用户名称',
	amount DECIMAL(12, 3) NOT NULL DEFAULT 0 COMMENT '充值金额',
	amount_real DECIMAL(12, 3) NOT NULL DEFAULT 0 COMMENT '实充金额',
	amount_activity DECIMAL(12, 3) NOT NULL DEFAULT 0 COMMENT '活动赠送',
	amount_gift DECIMAL(12, 3) NOT NULL DEFAULT 0 COMMENT '充值赔送',
	pay_type TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '支付方式',
	is_first TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否首充',
	status TINYINT UNSIGNED DEFAULT 0 COMMENT '状态',
	created INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '充值时间',
	updated INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '修改时间',
	finished INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '完成时间',
	reason VARCHAR(200) NOT NULL DEFAULT '' COMMENT '拒绝理由',
	INDEX(pay_type),
	INDEX(created),
	INDEX(user_id),
	INDEX(user_name),
	INDEX(is_first),
	PRIMARY KEY(id, ymd)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI 
PARTITION BY RANGE (ymd) (
	PARTITION p1911 VALUES LESS THAN (20191201),
	PARTITION p1912 VALUES LESS THAN (20200101),
	PARTITION p2001 VALUES LESS THAN (20200201),
	PARTITION p2002 VALUES LESS THAN (20200301),
	PARTITION p2003 VALUES LESS THAN (20200401),
	PARTITION p2004 VALUES LESS THAN (20200501),
	PARTITION p2005 VALUES LESS THAN (20200601),
	PARTITION p2006 VALUES LESS THAN (20200701),
	PARTITION p2007 VALUES LESS THAN (20200801),
	PARTITION p2008 VALUES LESS THAN (20200901),
	PARTITION p2009 VALUES LESS THAN (20201001),
	PARTITION p2010 VALUES LESS THAN (20201101),
	PARTITION p2011 VALUES LESS THAN (20201201),
	PARTITION p2012 VALUES LESS THAN (20210101),
	PARTITION p2101 VALUES LESS THAN MAXVALUE
);
INSERT INTO user_charges (user_id, user_name, amount, pay_type, created, updated, ymd) VALUES 
(1, 'tempname', 500, 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '20191122');

/** 提现记录 **/
DROP TABLE IF EXISTS user_withdraws;
CREATE TABLE IF NOT EXISTS user_withdraws (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	ymd INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '年月日',
	user_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户编号',
	user_name VARCHAR(20) NOT NULL DEFAULT '' COMMENT '用户名称',
	amount DECIMAL(12, 3) NOT NULL DEFAULT 0 COMMENT '充值金额',
	real_name VARCHAR(50) NOT NULL DEFAULT '' COMMENT '真实姓名',
	bank_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '银行编号',
	bank_name VARCHAR(20) NOT NULL DEFAULT '' COMMENT '银行名称',
	bank_sub_name VARCHAR(20) NOT NULL DEFAULT '' COMMENT '支行信息',
	bank_no VARCHAR(30) NOT NULL DEFAULT '' COMMENT '银行账号',
	status TINYINT UNSIGNED DEFAULT 0 COMMENT '状态',
	card_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '绑卡编号',
	created INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '提现时间',
	updated INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '修改时间',
	finished INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '完成时间',
	province_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '省份编号',
	city_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '城市编号',
	reason VARCHAR(200) NOT NULL DEFAULT '' COMMENT '拒绝理由',
	INDEX(user_id),
	INDEX(user_name),
	INDEX(created),
	INDEX(province_id),
	INDEX(city_id),
	PRIMARY KEY(id, ymd)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI
PARTITION BY RANGE (ymd) (
	PARTITION p1911 VALUES LESS THAN (20191201),
	PARTITION p1912 VALUES LESS THAN (20200101),
	PARTITION p2001 VALUES LESS THAN (20200201),
	PARTITION p2002 VALUES LESS THAN (20200301),
	PARTITION p2003 VALUES LESS THAN (20200401),
	PARTITION p2004 VALUES LESS THAN (20200501),
	PARTITION p2005 VALUES LESS THAN (20200601),
	PARTITION p2006 VALUES LESS THAN (20200701),
	PARTITION p2007 VALUES LESS THAN (20200801),
	PARTITION p2008 VALUES LESS THAN (20200901),
	PARTITION p2009 VALUES LESS THAN (20201001),
	PARTITION p2010 VALUES LESS THAN (20201101),
	PARTITION p2011 VALUES LESS THAN (20201201),
	PARTITION p2012 VALUES LESS THAN (20210101),
	PARTITION p2101 VALUES LESS THAN MAXVALUE
);
INSERT INTO user_withdraws (user_id, user_name, amount, created, updated, ymd) VALUES 
(1, 'tempname', 500, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '20191122');

/** 用户绑卡 **/
DROP TABLE IF EXISTS user_cards;
CREATE TABLE IF NOT EXISTS user_cards (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	user_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户编号',
	user_name VARCHAR(20) NOT NULL DEFAULT '' COMMENT '用户名称',
	bank_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '银行编号',
	bank_name VARCHAR(20) NOT NULL DEFAULT '' COMMENT '银行名称',
	bank_sub_name VARCHAR(20) NOT NULL DEFAULT '' COMMENT '支行名称',
	bank_no VARCHAR(30) NOT NULL DEFAULT '' COMMENT '银行账号',
	real_name VARCHAR(20) NOT NULL DEFAULT '' COMMENT '真实姓名',
    remark VARCHAR(200) NOT NULL DEFAULT '' COMMENT '备注',
	province_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '省份编号',
	city_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '城市编号',
	created INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '提现时间',
	updated INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '修改时间',
	INDEX(user_id),
	INDEX(bank_id),
	INDEX(user_name),
	UNIQUE KEY(bank_no),
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI;

/** 银行 **/
DROP TABLE IF EXISTS banks;
CREATE TABLE IF NOT EXISTS banks (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL DEFAULT '' COMMENT '名称',
	code CHAR(10) NOT NULL DEFAULT '' COMMENT '代码',
    remark VARCHAR(200) NOT NULL DEFAULT '' COMMENT '备注',
	sort INT NOT NULL DEFAULT 0 COMMENT '排序',
	status TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态',
    UNIQUE KEY(name),
	INDEX(sort),
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI;

/** 省 **/
DROP TABLE IF EXISTS provinces;
CREATE TABLE IF NOT EXISTS provinces (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL DEFAULT '' COMMENT '名称',
    remark VARCHAR(200) NOT NULL DEFAULT '' COMMENT '备注',
	code CHAR(12) NOT NULL DEFAULT '' COMMENT '代码',
    UNIQUE KEY(name),
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI;

/** 省 **/
DROP TABLE IF EXISTS cities;
CREATE TABLE IF NOT EXISTS cities (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	province_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '省份编号',
    name VARCHAR(50) NOT NULL DEFAULT '' COMMENT '名称',
    remark VARCHAR(200) NOT NULL DEFAULT '' COMMENT '备注',
	province_code CHAR(12) NOT NULL DEFAULT '' COMMENT '省份代码',
	code CHAR(12) NOT NULL DEFAULT '' COMMENT '代码',
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI;

/** 配置表 **/
DROP TABLE IF EXISTS parameters;
CREATE TABLE IF NOT EXISTS parameters (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL DEFAULT '' COMMENT '名称',
	value TEXT COMMENT '配置项值',
    remark VARCHAR(200) NOT NULL DEFAULT '' COMMENT '备注',
    status TINYINT NOT NULL DEFAULT 0 COMMENT '状态',
    sort INT NOT NULL DEFAULT 0 COMMENT '排序',
    created INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '添加时间',
    updated INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '修改时间',
	INDEX(sort),
	UNIQUE KEY(name),
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI;
INSERT INTO parameters (name, value, remark, created, updated) VALUES
('site_name', '网站名称', '网站名称', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),
('site_logo', '网站LOGO', '网站LOGO', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());

/** 配置表 **/
DROP TABLE IF EXISTS configs;
CREATE TABLE IF NOT EXISTS configs (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL DEFAULT '' COMMENT '名称',
	value TEXT COMMENT '配置项值',
    remark VARCHAR(200) NOT NULL DEFAULT '' COMMENT '备注',
    status TINYINT NOT NULL DEFAULT 0 COMMENT '状态',
    sort INT NOT NULL DEFAULT 0 COMMENT '排序',
    created INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '添加时间',
    updated INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '修改时间',
	INDEX(sort),
	INDEX(sort),
	UNIQUE KEY(name),
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI;
INSERT INTO configs (name, value, remark, created, updated) VALUES
('site_name', '网站名称', '网站名称', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),
('site_logo', '网站LOGO', '网站LOGO', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());

/** 帮助分类 **/
DROP TABLE IF EXISTS help_categories;
CREATE TABLE IF NOT EXISTS help_categories (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL DEFAULT '' COMMENT '分类名称',
    remark VARCHAR(200) NOT NULL DEFAULT '' COMMENT '备注',
    UNIQUE KEY(name),
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI;
INSERT INTO help_categories (name, remark) VALUES
('用户注册', '注册'),
('彩票投注', '投注'),
('用户充值', '充值'),
('用户提款', '提现'),
('其他问题', '其他');

/** 帮助 **/
DROP TABLE IF EXISTS helps;
CREATE TABLE IF NOT EXISTS helps (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	category_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '分类编号',
    title VARCHAR(100) NOT NULL DEFAULT '' COMMENT '标题',
    content text COMMENT '内容',
    sort INT NOT NULL DEFAULT 0 COMMENT 'sort',
    status TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态',
    created INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '添加时间',
    updated INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '修改时间',
    UNIQUE KEY(title),
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI;
INSERT INTO helps (title, created, updated, status, category_id) VALUES
('对于用户使用本站投注服务的约定', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 1, 1);

/** 玩法总类 **/
DROP TABLE IF EXISTS play_groups;
CREATE TABLE IF NOT EXISTS play_groups (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	category_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '彩种分类',
    name VARCHAR(50) NOT NULL DEFAULT '' COMMENT '总类名称',
    remark VARCHAR(200) NOT NULL DEFAULT '' COMMENT '备注',
	is_special TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '特殊玩法',
	UNIQUE KEY(category_id, name),
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI;
INSERT INTO play_groups (category_id, is_special, name) VALUES
(1, 0, '五星'),			/* 1 */
(1, 0, '四星'),			/* 2 */
(1, 0, '前三码'),		/* 3 */
(1, 0, '中三码'),		/* 4 */
(1, 0, '后三码'),		/* 5 */
(1, 0, '二码'),			/* 6 */
(1, 0, '定位胆'),		/* 7 */
(1, 0, '不定胆'),		/* 8 */
(1, 0, '大小单双'),		/* 9 */
(1, 0, '趣味'),			/* 10 */
(1, 1, '任选二'),		/* 11 */
(1, 1, '任选三'),		/* 12 */
(1, 1, '任选四'),		/* 13 */
(1, 1, '直选跨度'),		/* 14 */
(1, 1, '组选包胆'),		/* 15 */
(1, 1, '和值尾数'),		/* 16 */
(1, 1, '龙虎斗'),		/* 17 */
(1, 1, '全5中1'),		/* 18 */
(3, 0, '三码'),			/* 19 */
(3, 0, '二码'),			/* 20 */
(3, 0, '不定胆'),		/* 21 */
(3, 0, '定位胆'),		/* 22 */
(3, 0, '趣味型'),		/* 23 */
(3, 0, '任选复式'),		/* 24 */
(3, 0, '任选单式'),		/* 25 */
(2, 0, '冠军'),			/* 26 */
(2, 0, '冠亚军'),		/* 27 */
(2, 0, '前三名'),		/* 28 */
(2, 0, '前四名'),		/* 29 */
(2, 0, '前五名'),		/* 30 */
(2, 0, '前六名'),		/* 31 */
(2, 0, '定位胆'),		/* 32 */
(2, 0, '大小单双'),		/* 33 */
(2, 0, '龙虎'),			/* 34 */
(2, 0, '和值'),			/* 35 */
(2, 0, '竞速'),			/* 36 */
(10, 0, '三码'),		/* 37 */
(10, 0, '二码'),		/* 38 */
(10, 0, '定位胆'),		/* 39 */
(10, 0, '不定胆'),		/* 40 */
(11, 0, '三码'),		/* 41 */
(11, 0, '二码'),		/* 42 */
(11, 0, '定位胆'),		/* 43 */
(11, 0, '不定胆');		/* 44 */


/** 玩法子类 **/
DROP TABLE IF EXISTS play_types;
CREATE TABLE IF NOT EXISTS play_types (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	category_id INT UNSIGNED NOT NULL DEFAULt 0 COMMENT '彩种分类',
	group_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '总类编号',
    name VARCHAR(50) NOT NULL DEFAULT '' COMMENT '分类名称',
    remark VARCHAR(200) NOT NULL DEFAULT '' COMMENT '备注',
	INDEX(group_id),
	UNIQUE KEY(group_id, name),
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI;
INSERT INTO play_types (category_id, group_id, name) VALUES
(1, 1, '五星直选'),	/* 1 */
(1, 1, '五星组选'),	/* 2 */
(1, 2, '四星直选'),	/* 3 */
(1, 2, '四星组选'),	/* 4 */
(1, 3, '前三直选'),	/* 5 */
(1, 3, '前三组选'),	/* 6 */
(1, 4, '中三直选'),	/* 7 */
(1, 4,	'中三组选'),	/* 8 */
(1, 5, '后三直选'),	/* 9 */
(1, 5, '后三组选'),	/* 10 */
(1, 6, '二星直选'),	/* 11 */
(1, 6, '二星组选'),	/* 12 */
(1, 7, '定位胆'),		/* 13 */
(1, 8, '不定胆'),		/* 14 */
(1, 9, '大小单双'),	/* 15 */
(1, 10, '趣味'),		/* 16 */
(1, 11, '任二直选'),	/* 17 */
(1, 11, '任二组选'),	/* 18 */
(1, 12, '任三直选'),	/* 19 */
(1, 12, '任三组选'),	/* 20 */
(1, 13, '任四直选'),	/* 21 */
(1, 13, '任四组选'),	/* 22 */
(1, 14, '二码跨度'),	/* 23 */
(1, 14, '三码跨度'),	/* 24 */
(1, 15, '组选包胆'),	/* 25 */
(1, 16, '和值尾数'),	/* 26 */
(1, 17, '龙虎'),		/* 27 */
(1, 18, '全5中1'),		/* 28 */
(3, 19, '三码'),		/* 29 */
(3, 20, '二码'),		/* 30 */
(3, 21, '不定胆'),		/* 31 */
(3, 22, '定位胆'),		/* 32 */
(3, 23, '趣味型'),		/* 33 */
(3, 24, '任选复式'),	/* 34 */
(3, 25, '任选单式'),	/* 35 */
(2, 26, '冠军'),		/* 36 */
(2, 27, '冠亚军'),		/* 37 */
(2, 28, '前三名'),		/* 38 */
(2, 29, '前四名'),		/* 39 */
(2, 30, '前五名'),		/* 40 */
(2, 31, '前六名'),		/* 41 */
(2, 32, '定位胆'),		/* 42 */
(2, 33, '大小单双'),	/* 43 */
(2, 34, '龙虎'),		/* 44 */
(2, 35, '和值'),		/* 45 */
(2, 35, '三码'),		/* 46 */
(2, 36, '竞速'),		/* 47 */
(10, 37, '直选'),		/* 48 */
(10, 37, '组选'),		/* 49 */
(10, 38, '二星'),		/* 50 */
(10, 39, '定位胆'),		/* 51 */
(10, 40, '不定胆'),		/* 52 */
(11, 41, '直选'),		/* 53 */
(11, 41, '组选'),		/* 54 */
(11, 42, '二星'),		/* 55 */
(11, 43, '定位胆'),		/* 56 */
(11, 44, '不定胆');		/* 57 */



/** 玩法 **/
DROP TABLE IF EXISTS plays;
CREATE TABLE IF NOT EXISTS plays (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	category_id INT UNSIGNED NOT NULL DEFAULt 0 COMMENT '彩种分类',
	group_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '总类编号',
	type_id  INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '子类编号',
    name VARCHAR(50) NOT NULL DEFAULT '' COMMENT '玩法名称',
    remark VARCHAR(200) NOT NULL DEFAULT '' COMMENT '备注',
	odds DECIMAL(9, 2) NOT NULL DEFAULT 0 COMMENT '赔率',
	odds_details TEXT COMMENT '赔率详情',
	INDEX(group_id),
	INDEX(type_id),
	UNIQUE KEY(group_id, type_id, name),
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI;
INSERT INTO plays (category_id, group_id, type_id, name, odds) VALUES
(1, 1, 1, '复式', 194000),
(1, 1, 1, '单式', 194000),
(1, 1, 2, '组选120', 1616),
(1, 1, 2, '组选60', 3233),
(1, 1, 2, '组选30', 6466),
(1, 1, 2, '组选20', 9700),
(1, 1, 2, '组选10', 19400),
(1, 1, 2, '组选5', 38800),
(1, 2, 3, '复式', 19400),
(1, 2, 3, '单式', 19400),
(1, 2, 4, '组选24', 808),
(1, 2, 4, '组选12', 1616),
(1, 2, 4, '组选6', 3233),
(1, 2, 4, '组选4', 4850),
(1, 3, 5, '直选复式', 1940),
(1, 3, 5, '直选单式', 1940),
(1, 3, 5, '直选和值', 1940),
(1, 3, 6, '组三', 646),
(1, 3, 6, '组六', 323),
(1, 3, 6, '混合组选', 0),
(1, 3, 6, '组选和值', 0),
(1, 4, 7, '直选复式', 1940),
(1, 4, 7, '直选单式', 1940),
(1, 4, 7, '直选和值', 1940),
(1, 4, 8, '组三', 646),
(1, 4, 8, '组六', 323),
(1, 4, 8, '混合组选', 0),
(1, 4, 8, '组选和值', 0),
(1, 5, 9, '直选复式', 1940),
(1, 5, 9, '直选单式', 1940),
(1, 5, 9, '直选和值', 1940),
(1, 5, 10, '组三', 646),
(1, 5, 10, '组六', 323),
(1, 5, 10, '混合组选', 0),
(1, 5, 10, '组选和值', 0),
(1, 6, 11, '前二复式', 194),
(1, 6, 11, '前二单式', 194),
(1, 6, 11, '前二和值', 194),
(1, 6, 11, '后二复式', 194),
(1, 6, 11, '后二单式', 194),
(1, 6, 11, '后二和值', 194),
(1, 6, 12, '前二复式', 97),
(1, 6, 12, '前二单式', 97),
(1, 6, 12, '前二和值', 97),
(1, 6, 12, '后二复式', 97),
(1, 6, 12, '后二单式', 97),
(1, 6, 12, '后二和值', 97),
(1, 7, 13, '定位胆', 19.4),
(1, 8, 14, '前三一码不定胆', 7.15),
(1, 8, 14, '前三二码不定胆', 35.92),
(1, 8, 14, '后三一码不定胆', 7.15),
(1, 8, 14, '后三二码不定胆', 35.92),
(1, 9, 15, '前二大小单双', 7.7),
(1, 9, 15, '后二大小单双', 7.7),
(1, 9, 15, '总和大小单双', 3.88),
(1, 10, 16, '一帆风顺', 4.73),
(1, 10, 16, '双喜临门', 23.7),
(1, 10, 16, '三阳开泰', 226.63),
(1, 10, 16, '四季发财', 4203),
(1, 11, 17, '直选复式', 194),
(1, 11, 17, '直选单式', 194),
(1, 11, 17, '直选和值', 194),
(1, 11, 18, '组选复式', 97),
(1, 11, 18, '组选单式', 97),
(1, 11, 18, '组选和值', 97),
(1, 12, 19, '直选复式', 1940),
(1, 12, 19, '直选单式', 1940),
(1, 12, 19, '直选和值', 1940),
(1, 12, 20, '组三', 646),
(1, 12, 20, '组六', 323),
(1, 12, 20, '混合组选', 0),
(1, 12, 20, '组选和值', 0),
(1, 13, 21, '直选复式', 19400),
(1, 13, 21, '直选单式', 19400),
(1, 13, 22, '组选24', 808),
(1, 13, 22, '组选12', 1616),
(1, 13, 22, '组选6', 3233),
(1, 13, 22, '组选4', 4850),
(1, 14, 23, '前二跨度', 194),
(1, 14, 23, '后二跨度', 194),
(1, 14, 24, '前三跨度', 1940),
(1, 14, 24, '中三跨度', 1940),
(1, 14, 24, '后三跨度', 1940),
(1, 15, 25, '前三包胆', 0),
(1, 15, 25, '中三包胆', 0),
(1, 15, 25, '后三包胆', 0),
(1, 16, 26, '前三和值尾数', 19.4),
(1, 16, 26, '中三和值尾数', 19.4),
(1, 16, 26, '后三和值尾数', 19.4),
(1, 17, 27, '龙虎斗', 0),
(1, 17, 27, '玄麟斗', 0),
(1, 18, 28, '组选10', 1077.78),
(1, 18, 28, '组选20', 89.81),
(1, 18, 28, '组选30', 59.88),
(1, 18, 28, '组选60', 9.62),
(1, 18, 28, '组选120', 12.83),
(3, 19, 29, '前三直选复式', 1882.18),
(3, 19, 29, '前三直选单式', 1882.18),
(3, 19, 29, '后三组选复式', 313.69),
(3, 19, 29, '后三组选单式', 313.69),
(3, 20, 30, '前二直选复式', 212.3),
(3, 20, 30, '前二直选单式', 212.3),
(3, 20, 30, '后二组选复式', 106.15),
(3, 20, 30, '后二组选单式', 106.15),
(3, 21, 31, '前三位', 7.1),
(3, 22, 32, '定位胆', 21.23),
(3, 23, 33, '定单双', 0),
(3, 23, 33, '猜中位', 0),
(3, 24, 34, '一中一', 4.24),
(3, 24, 34, '二中二', 10.45),
(3, 24, 34, '三中三', 31.35),
(3, 24, 34, '四中四', 127.38),
(3, 24, 34, '五中五', 891.69),
(3, 24, 34, '六中六', 148.61),
(3, 24, 34, '七中七', 42.46),
(3, 24, 34, '八中八', 15.91),
(3, 25, 35, '一中一', 4.24),
(3, 25, 35, '二中二', 10.45),
(3, 25, 35, '三中三', 31.35),
(3, 25, 35, '四中四', 127.38),
(3, 25, 35, '五中五', 891.69),
(3, 25, 35, '六中六', 148.61),
(3, 25, 35, '七中七', 42.46),
(3, 25, 35, '八中八', 15.91),
(2, 26, 36, '冠军', 19.4),
(2, 27, 37, '复式', 174.6),
(2, 27, 37, '单式', 174.6),
(2, 28, 38, '复式', 1396.8),
(2, 28, 38, '单式', 1396.8),
(2, 29, 39, '复式', 9777.6),
(2, 29, 39, '单式', 9777.6),
(2, 30, 40, '复式', 58665.6),
(2, 30, 40, '单式', 58665.6),
(2, 31, 41, '复式', 293328),
(2, 31, 41, '单式', 293328),
(2, 32, 42, '1-5位定位胆', 19.4),
(2, 32, 42, '6-10位定位胆', 19.4),
(2, 33, 43, '冠军', 3.88),
(2, 33, 43, '亚军', 3.88),
(2, 33, 43, '季军', 3.88),
(2, 34, 44, '冠军龙虎', 3.88),
(2, 34, 44, '亚军龙虎', 3.88),
(2, 34, 44, '季军龙虎', 3.88),
(2, 34, 44, '第四名龙虎', 3.88),
(2, 34, 44, '第五名龙虎', 3.88),
(2, 35, 45, '冠亚和值', 0),
(2, 35, 45, '中二和值', 0),
(2, 35, 45, '后二和值', 0),
(2, 35, 46, '前三和值', 0),
(2, 35, 46, '后三和值', 0),
(2, 36, 47, '竞速', 3.88),
(10, 37, 48, '直选复式', 1910),
(10, 37, 48, '直选单式', 1910),
(10, 37, 48, '直选和值', 0),
(10, 37, 49, '组三', 636.66),
(10, 37, 49, '组六', 315),
(10, 37, 49, '混合组选', 0),
(10, 37, 49, '组选和值', 0),
(10, 38, 50, '前二直选复式', 191),
(10, 38, 50, '前二直选单式', 191),
(10, 38, 50, '前二组选复式', 95.5),
(10, 38, 50, '前二组选单式', 95.5),
(10, 38, 50, '后二直选复式', 191),
(10, 38, 50, '后二直选单式', 191),
(10, 38, 50, '后二组选复式', 95.5),
(10, 38, 50, '后二组选单式', 95.5),
(10, 39, 51, '定位胆', 19.1),
(10, 40, 52, '一码不定胆', 6.9),
(11, 41, 53, '直选复式', 1910),
(11, 41, 53, '直选单式', 1910),
(11, 41, 53, '直选和值', 0),
(11, 41, 54, '组三', 636.66),
(11, 41, 54, '组六', 315),
(11, 41, 54, '混合组选', 0),
(11, 41, 54, '组选和值', 0),
(11, 42, 55, '前二直选复式', 191),
(11, 42, 55, '前二直选单式', 191),
(11, 42, 55, '前二组选复式', 95.5),
(11, 42, 55, '前二组选单式', 95.5),
(11, 42, 55, '后二直选复式', 191),
(11, 42, 55, '后二直选单式', 191),
(11, 42, 55, '后二组选复式', 95.5),
(11, 42, 55, '后二组选单式', 95.5),
(11, 43, 56, '定位胆', 191),
(11, 44, 57, '一码不定胆', 6.9);


/** 玩法说明 **/
DROP TABLE IF EXISTS play_notes;
CREATE TABLE IF NOT EXISTS play_notes (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	lottery_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '彩种编号',
    title VARCHAR(100) NOT NULL DEFAULT '' COMMENT '标题',
    content text COMMENT '内容',
    sort INT NOT NULL DEFAULT 0 COMMENT 'sort',
    status TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态',
    created INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '添加时间',
    updated INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '修改时间',
	INDEX(sort),
	INDEX(status),
    UNIQUE KEY(title),
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI;
INSERT INTO play_notes (lottery_id, title, created, updated, status) VALUES
(1, '对于用户使用本站投注服务的约定', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 1);


/** 彩种标签 **/
DROP TABLE IF EXISTS lottery_tags;
CREATE TABLE IF NOT EXISTS lottery_tags (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL DEFAULT '' COMMENT '分类名称',
    remark VARCHAR(200) NOT NULL DEFAULT '' COMMENT '备注',
    UNIQUE KEY(name),
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI;
INSERT INTO lottery_tags (name, remark) VALUES
('高频彩', '高频'),
('低频彩', '低频');

/** 彩种分类 **/
DROP TABLE IF EXISTS lottery_categories;
CREATE TABLE IF NOT EXISTS lottery_categories (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL DEFAULT '' COMMENT '分类名称',
    remark VARCHAR(200) NOT NULL DEFAULT '' COMMENT '备注',
    UNIQUE KEY(name),
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI;
INSERT INTO lottery_categories (name, remark) VALUES
('时时彩', '时时彩'),			/* 1 */
('PK10', '参照北京PK10'),		/* 2 */
('11选5', '11选5系列'),			/* 3 */
('快3', '快3系列'),				/* 4 */
('六合彩', '香港六合彩系列'),	/* 5 */
('扑克', '类似幸运扑克'),		/* 6 */
('幸运28', '幸运28系列'),		/* 7 */
('快乐8', '北京快乐8系列'),		/* 8 */
('幸运农场', '幸运农场'),		/* 9 */
('福彩3D', '福彩3D'),			/* 10 */
('体彩P3', '体彩排列三'),		/* 11 */
('其他', '其他官方彩票');		/* 12 */

/** 彩种 **/
DROP TABLE IF EXISTS lotteries;
CREATE TABLE IF NOT EXISTS lotteries (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	category_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '彩种类型',
	tag_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '彩种标签',
    name VARCHAR(50) NOT NULL DEFAULT '' COMMENT '彩种名称',
    remark VARCHAR(200) NOT NULL DEFAULT '' COMMENT '备注',
	sort INT NOT NULL DEFAULT 0 COMMENT '排序',
    status TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态',
    created INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '添加时间',
    updated INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '修改时间',
	INDEX(sort),
    UNIQUE KEY(name),
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI;
INSERT INTO lotteries (category_id, tag_id, name, status, created, updated) VALUES 
(1, 1, '半分时时彩', 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),	/* 1 */
(1, 1, '一分时时彩', 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),	/* 2 */
(1, 1, '二分时时彩', 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()), 	/* 3 */
(1, 1, '五分时时彩', 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()), 	/* 4 */

(2, 1, '半分PK拾', 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),		/* 5 */ 
(2, 1, '一分PK拾', 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),		/* 6 */ 
(2, 1, '二分PK拾', 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),		/* 7 */
(2, 1, '五分PK拾', 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),   	/* 8 */

(3, 1, '半分11选5', 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),		/* 9 */
(3, 1, '一分11选5', 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),		/* 10 */
(3, 1, '二分11选5', 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),   	/* 11 */
(3, 1, '五分11选5', 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),   	/* 12 */

(4, 1, '半分快三', 0, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),		/* 13 */
(4, 1, '一分快三', 0, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),		/* 14 */
(4, 1, '二分快三', 0, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),		/* 15 */
(4, 1, '五分快三', 0, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),		/* 16 */

(5, 1, '半分六合彩', 0, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),	/* 17 */
(5, 1, '一分六合彩', 0, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),	/* 18 */
(5, 1, '二分六合彩', 0, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),	/* 19 */
(5, 1, '五分六合彩', 0, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),	/* 20 */

(5, 2, '香港六合彩', 0, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),	/* 21 */
(6, 1, '幸运扑克', 0, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),		/* 22 */
(7, 1, '幸运28', 0, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),		/* 23 */
(1, 1, '重庆时时彩', 0, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()), 	/* 24 */
(2, 1, '北京PK拾', 0, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),   	/* 25 */
(3, 1, '江西11选5', 0, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),   	/* 26 */
(3, 1, '山东11选5', 0, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),		/* 27 */
(3, 1, '广东11选5', 0, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),		/* 28 */
(4, 1, '江苏快三', 0, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),		/* 29 */
(4, 1, '安徽快三', 0, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),		/* 30 */
(4, 1, '广西快三', 0, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),		/* 31 */
(4, 1, '广东快三', 0, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),		/* 32 */
(1, 1, '新疆时时彩', 0, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),	/* 33 */
(3, 1, '江苏11选5', 0, UNIX_TIMESTAMP(), UNIX_TIMESTAMP());		/* 34 */

/** 开奖时间 **/
DROP TABLE IF EXISTS open_times;
CREATE TABLE IF NOT EXISTS open_times (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	lottery_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '彩种编号',
	period_number VARCHAR(10) NOT NULL DEFAULT '' COMMENT '期数',
	time_close CHAR(8) NOT NULL DEFAULT '00:00:00' COMMENT '封盘时间',
	time_open CHAR(8) NOT NULL DEFAULT '00:00:00' COMMENT '开奖时间',
	day_offset TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '天数偏移',
	is_begin TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否首期',
	is_end TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否末期',
	sort INT NOT NULL DEFAULT 0 COMMENT '排序',
	INDEX(sort),
	INDEX(lottery_id),
	INDEX(period_number),
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI;

/** 开奖奖期 **/
DROP TABLE IF EXISTS open_periods;
CREATE TABLE IF NOT EXISTS open_periods (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	ymd INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '年月日',
	lottery_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '彩种编号',
	period_number VARCHAR(20) NOT NULL DEFAULT '' COMMENT '奖期',
	time_close CHAR(20) NOT NULL DEFAULT '' COMMENT '封盘时间',
	time_open CHAR(20) NOT NULL DEFAULT '' COMMENT '开奖时间',
	day_offset TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '天数偏移',
	is_begin TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否首期',
	is_end TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否末期',
	is_opened TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否开过',
    created INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '添加时间',
    updated INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '修改时间',	
	sort INT NOT NULL DEFAULT 0 COMMENT '排序',
	INDEX(sort),
	INDEX(lottery_id),
	INDEX(period_number),
    PRIMARY KEY(id, ymd)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI
PARTITION BY RANGE (ymd) (
	PARTITION p1911 VALUES LESS THAN (20191201),
	PARTITION p1912 VALUES LESS THAN (20200101),
	PARTITION p2001 VALUES LESS THAN (20200201),
	PARTITION p2002 VALUES LESS THAN (20200301),
	PARTITION p2003 VALUES LESS THAN (20200401),
	PARTITION p2004 VALUES LESS THAN (20200501),
	PARTITION p2005 VALUES LESS THAN (20200601),
	PARTITION p2006 VALUES LESS THAN (20200701),
	PARTITION p2007 VALUES LESS THAN (20200801),
	PARTITION p2008 VALUES LESS THAN (20200901),
	PARTITION p2009 VALUES LESS THAN (20201001),
	PARTITION p2010 VALUES LESS THAN (20201101),
	PARTITION p2011 VALUES LESS THAN (20201201),
	PARTITION p2012 VALUES LESS THAN (20210101),
	PARTITION p2101 VALUES LESS THAN MAXVALUE
);

/** 开奖结果 **/
DROP TABLE IF EXISTS open_numbers;
CREATE TABLE IF NOT EXISTS open_numbers (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	ymd INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '年月日',
	lottery_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '彩种编号',
	period_number CHAR(20) NOT NULL DEFAULT '' COMMENT '奖期',
	numbers VARCHAR(20) NOT NULL DEFAULT '' COMMENT '开奖号码',
	open_time INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '开奖时间',
	is_finished TINYINT NOT NULL DEFAULT 0 COMMENT '是否开完',
    created INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '添加时间',
    updated INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '修改时间',
    remark VARCHAR(200) NOT NULL DEFAULT '' COMMENT '备注',
	sort INT NOT NULL DEFAULT 0 COMMENT '排序',
	INDEX(lottery_id),
	INDEX(period_number),
	INDEX(sort),
    PRIMARY KEY(id, ymd)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI
PARTITION BY RANGE (ymd) (
	PARTITION p1911 VALUES LESS THAN (20191201),
	PARTITION p1912 VALUES LESS THAN (20200101),
	PARTITION p2001 VALUES LESS THAN (20200201),
	PARTITION p2002 VALUES LESS THAN (20200301),
	PARTITION p2003 VALUES LESS THAN (20200401),
	PARTITION p2004 VALUES LESS THAN (20200501),
	PARTITION p2005 VALUES LESS THAN (20200601),
	PARTITION p2006 VALUES LESS THAN (20200701),
	PARTITION p2007 VALUES LESS THAN (20200801),
	PARTITION p2008 VALUES LESS THAN (20200901),
	PARTITION p2009 VALUES LESS THAN (20201001),
	PARTITION p2010 VALUES LESS THAN (20201101),
	PARTITION p2011 VALUES LESS THAN (20201201),
	PARTITION p2012 VALUES LESS THAN (20210101),
	PARTITION p2101 VALUES LESS THAN MAXVALUE
);
INSERT INTO open_numbers (lottery_id, period_number,numbers,  open_time, created, updated, ymd) VALUES
(1, '20191130001', '1,2,3,4,5', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '20191122'),
(1, '20191130002', '1,2,3,4,5', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '20191122'),
(1, '20191130003', '1,2,3,4,5', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '20191122'),
(1, '20191130004', '1,2,3,4,5', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '20191122'),
(1, '20191130005', '1,2,3,4,5', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '20191122'),
(1, '20191130006', '1,2,3,4,5', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '20191122'),
(1, '20191130007', '1,2,3,4,5', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '20191122'),
(1, '20191130008', '1,2,3,4,5', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '20191122');

DROP TABLE IF EXISTS orders;
CREATE TABLE IF NOT EXISTS orders (
	id INT UNSIGNED not null AUTO_INCREMENT,
	ymd INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '年月日',
	order_num char(20) NOT NULL DEFAULT '' COMMENT '订单编号',
	user_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户编号',
	user_name VARCHAR(20) NOT NULL DEFAULT '' COMMENT '用户名称',
	quantity INT UNSIGNED  NOT NULL DEFAULT 0 COMMENT '子订单数量',
	amount DECIMAL(12, 3) NOT NULL DEFAULT 0 COMMENT '订单金额',
	status TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态',
	created INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '添加时间',
	updated INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '修改时间',
	INDEX(user_id),
	INDEX(created),
	UNIQUE KEY(order_num, ymd),
	PRIMARY KEY(id, ymd)
) ENGINE=INNODB 
DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI
PARTITION BY RANGE (ymd) (
	PARTITION p1911 VALUES LESS THAN (20191201),
	PARTITION p1912 VALUES LESS THAN (20200101),
	PARTITION p2001 VALUES LESS THAN (20200201),
	PARTITION p2002 VALUES LESS THAN (20200301),
	PARTITION p2003 VALUES LESS THAN (20200401),
	PARTITION p2004 VALUES LESS THAN (20200501),
	PARTITION p2005 VALUES LESS THAN (20200601),
	PARTITION p2006 VALUES LESS THAN (20200701),
	PARTITION p2007 VALUES LESS THAN (20200801),
	PARTITION p2008 VALUES LESS THAN (20200901),
	PARTITION p2009 VALUES LESS THAN (20201001),
	PARTITION p2010 VALUES LESS THAN (20201101),
	PARTITION p2011 VALUES LESS THAN (20201201),
	PARTITION p2012 VALUES LESS THAN (20210101),
	PARTITION p2101 VALUES LESS THAN MAXVALUE
);
insert into orders (ymd, order_num, user_id, user_name, quantity, amount, created, updated) values 
('20191122', '20191122101010A3E9', 1, 'maomao123', 1, '100', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());

/** 投注表 **/
DROP TABLE IF EXISTS bets;
CREATE TABLE IF NOT EXISTS bets (
	id INT UNSIGNED not null AUTO_INCREMENT,
	ymd INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '年月日',
	order_num CHAR(20) NOT NULL DEFAULT '' COMMENT '订单编号',
	order_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '订单编号',
	user_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户编号',
	user_name VARCHAR(20) NOT NULL DEFAULT '' COMMENT '用户名称',
	category_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '彩种分类',
	tag_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '彩种标签',
	lottery_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '彩种编号',
	period VARCHAR(20) NOT NULL DEFAULT '' COMMENT '奖期',
	play_group_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '玩法总类',
	play_type_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '玩法子类',
	play_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '玩法编号',
	bet_numbers VARCHAR(200) NOT NULL DEFAULT '' COMMENT '投注号码',
	bet_amount DECIMAL(12, 3) NOT NULL DEFAULT 0 COMMENT '投注金额',
	bet_count INT UNSIGNED not null DEFAULT 0 COMMENT '投注数量',
	bet_time INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '投注时间',
	prize DECIMAL(12, 3) NOT NULL DEFAULT 0 COMMENT '中奖金额',
	open_number VARCHAR(30)  NOT NULL DEFAULT '' COMMENT '开奖号码',
	open_time INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '开奖时间',
	prized DECIMAL(12, 3) NOT NULL DEFAULT 0 COMMENT '已中金额',
	prized_count INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '已中注数',
	prized_time INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '中奖时间',
	status TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态',
	created INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '添加时间',
	updated INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '修改时间',
	INDEX(created),
	INDEX(order_id),
	INDEX(lottery_id),
	INDEX(category_id),
	INDEX(tag_id),
	INDEX(period),
	INDEX(play_group_id),
	INDEX(play_type_id),
	INDEX(play_id),
	INDEX(user_id),
	INDEX(user_name),
	INDEX(status),
	PRIMARY KEY(id, ymd)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI 
PARTITION BY RANGE (ymd) (
	PARTITION p1911 VALUES LESS THAN (20191201),
	PARTITION p1912 VALUES LESS THAN (20200101),
	PARTITION p2001 VALUES LESS THAN (20200201),
	PARTITION p2002 VALUES LESS THAN (20200301),
	PARTITION p2003 VALUES LESS THAN (20200401),
	PARTITION p2004 VALUES LESS THAN (20200501),
	PARTITION p2005 VALUES LESS THAN (20200601),
	PARTITION p2006 VALUES LESS THAN (20200701),
	PARTITION p2007 VALUES LESS THAN (20200801),
	PARTITION p2008 VALUES LESS THAN (20200901),
	PARTITION p2009 VALUES LESS THAN (20201001),
	PARTITION p2010 VALUES LESS THAN (20201101),
	PARTITION p2011 VALUES LESS THAN (20201201),
	PARTITION p2012 VALUES LESS THAN (20210101),
	PARTITION p2101 VALUES LESS THAN MAXVALUE
);
insert into bets (order_num, order_id, user_id, user_name, category_id, tag_id, lottery_id, period, play_group_id, play_type_id, play_id, bet_numbers, bet_amount, bet_count, bet_time, prize, created, updated, ymd) values 
('20191122101010A3E9', 1, 1, 'maomao123', 1, 1, 1, '20191122001', 
	1, 1, 1,
	'1,3,9', '100', '1', UNIX_TIMESTAMP(),
	'100', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
	'20191122'
);

/** 彩种-赔率 **/
DROP TABLE IF EXISTS lottery_plays;
CREATE TABLE IF NOT EXISTS lottery_plays (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	category_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '彩种分类',
	play_group_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '玩法总类',
	play_type_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '玩法子类',
	play_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '玩法编号',
	lottery_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '彩种编号',
	odds DECIMAL(12, 3) NOT NULL DEFAULT 0 COMMENT '赔率',
	remark VARCHAR(200) NOT NULL DEFAULT '' COMMENT '备注',
	INDEX(play_group_id),
	INDEX(play_type_id),
	INDEX(play_id),
	INDEX(lottery_id),
	PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_GENERAL_CI;

source ./banks.sql;
source ./province-cities.sql;
source ./open-times/lottery-1.sql;
source ./open-times/lottery-2.sql;
source ./open-times/lottery-3.sql;
source ./open-times/lottery-4.sql;
source ./open-times/lottery-5.sql;
source ./open-times/lottery-6.sql;
source ./open-times/lottery-7.sql;
source ./open-times/lottery-8.sql;
source ./open-times/lottery-9.sql;
source ./open-times/lottery-10.sql;
source ./open-times/lottery-11.sql;
source ./open-times/lottery-12.sql;
/* source ./open-times/lottery-13.sql;*/
/* source ./open-times/lottery-14.sql;*/
/* source ./open-times/lottery-15.sql;*/
/* source ./open-times/lottery-16.sql;*/
/* source ./open-times/lottery-17.sql;*/
/* source ./open-times/lottery-18.sql;*/
/* source ./open-times/lottery-19.sql;*/
/* source ./open-times/lottery-20.sql;*/
