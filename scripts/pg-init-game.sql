DROP TABLE IF EXISTS admins;
CREATE SEQUENCE admins_seq;

CREATE TABLE IF NOT EXISTS admins (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('admins_seq'),
    name VARCHAR(50) NOT NULL DEFAULT "" ,
    password VARCHAR(32) NOT NULL DEFAULT "" ,
    secret VARCHAR(32) NOT NULL DEFAULT "" ,
    role_id INT CHECK (role_id > 0) NOT NULL DEFAULT 0 ,
    login_count INT CHECK (login_count > 0) NOT NULL DEFAULT 0 ,
    last_login INT CHECK (last_login > 0) NOT NULL DEFAULT 0 ,
    last_ip VARCHAR(50) NOT NULL DEFAULT "" ,
    last_region VARCHAR(50) NOT NULL DEFAULT "" ,
    ips VARCHAR(200) NOT NULL DEFAULT "" ,
    status smallint NOT NULL DEFAULT 0 ,
    sort int NOT NULL DEFAULT 0 ,
    created INT CHECK (created > 0) NOT NULL DEFAULT 0 ,
    updated INT CHECK (updated > 0) NOT NULL DEFAULT 0 ,
    remark VARCHAR(200) NOT NULL DEFAULT "" ,
    PRIMARY KEY(id)
    ,
    UNIQUE (name)
)  ;

CREATE INDEX(sort);
INSERT INTO admins(name, role_id, last_login, last_ip, last_region, ips, status, created, updated) VALUES
('admin', 1, UNIX_TIMESTAMP(), '127.0.0.1', '美国', '127.0.0.1', 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP());

/** 管理员角色表 **/
DROP TABLE IF EXISTS admin_roles;
CREATE SEQUENCE admin_roles_seq;

CREATE TABLE IF NOT EXISTS admin_roles (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('admin_roles_seq'),
    name VARCHAR(50) NOT NULL DEFAULT "" ,
    remark VARCHAR(200) NOT NULL DEFAULT "" ,
    menus TEXT ,
    UNIQUE (name),
    PRIMARY KEY(id)
)  ;
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
CREATE SEQUENCE menus_seq;

CREATE TABLE IF NOT EXISTS menus (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('menus_seq'),
    name VARCHAR(50) NOT NULL DEFAULT "" ,
    type INT CHECK (type > 0) NOT NULL DEFAULT 0 ,
    level INT CHECK (level > 0) NOT NULL DEFAULT 0 ,
    status SMALLINT CHECK (status > 0) NOT NULL DEFAULT 0 ,
    sort int NOT NULL DEFAULT 0 ,
    url VARCHAR(100) NOT NULL DEFAULT "" ,
    created INT CHECK (created > 0) NOT NULL DEFAULT 0 ,
    updated INT CHECK (updated > 0) NOT NULL DEFAULT 0 ,
    UNIQUE (name),
    PRIMARY KEY(id)
)  ;
INSERT INTO menus (name, type, level, status, url, created, updated) VALUES
('默认菜单', 1, 1, 1, '/v1/admins', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());

/** 管理员日志表 **/
/* 日志级别: 0:普通 1:重要 2:警告, 3:致命 4:错误 5:特殊 9:其他 */
/* 日志类型: 0:普通操作 1:登录退出 2:权限相关 3:财务相关 4:内容相关 9:其他类型 */
DROP TABLE IF EXISTS admin_logs;
CREATE SEQUENCE admin_logs_seq;

CREATE TABLE IF NOT EXISTS admin_logs (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('admin_logs_seq'),
    admin_id VARCHAR(50) NOT NULL DEFAULT "" ,
    admin_name VARCHAR(50) NOT NULL DEFAULT "" ,
    level SMALLINT CHECK (level > 0) NOT NULL DEFAULT 0 ,
    type SMALLINT CHECK (type > 0) NOT NULL DEFAULT 0 ,
    url VARCHAR(100) NOT NULL DEFAULT "" ,
    remark VARCHAR(200) NOT NULL DEFAULT "" ,
    created INT CHECK (created > 0) NOT NULL DEFAULT 0
    ,
    PRIMARY KEY(id)
)  ;

CREATE INDEX(type);
CREATE INDEX(level);
CREATE INDEX(admin_id);
INSERT INTO admin_logs(admin_id, admin_name, level, type, url, created) VALUES
(1, 'admin', 1, 1, '/v1/admins', UNIX_TIMESTAMP());

/** 管理员登录日志表 **/
DROP TABLE IF EXISTS admin_login_logs;
CREATE SEQUENCE admin_login_logs_seq;

CREATE TABLE IF NOT EXISTS admin_login_logs (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('admin_login_logs_seq'),
    admin_id VARCHAR(50) NOT NULL DEFAULT "" ,
    admin_name VARCHAR(50) NOT NULL DEFAULT "" ,
    url VARCHAR(100) NOT NULL DEFAULT "" ,
	ip VARCHAR(50) NOT NULL DEFAULT "" ,
	region VARCHAR(50) NOT NULL DEFAULT "" ,
    remark VARCHAR(200) NOT NULL DEFAULT "" ,
    created INT CHECK (created > 0) NOT NULL DEFAULT 0
    ,
    PRIMARY KEY(id)
)  ;

CREATE INDEX(admin_id);
INSERT INTO admin_login_logs(admin_id, admin_name, url, ip, region, created) VALUES
(1, 'admin', '/v1/admins', '127.0.0.1', '局域网', UNIX_TIMESTAMP());

/** 用户表 **/
/* 状态: 0:待审核 1:可用 2:冻结 3:停用 */
DROP TABLE IF EXISTS users;
CREATE SEQUENCE users_seq;

CREATE TABLE IF NOT EXISTS users (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('users_seq'),
    name VARCHAR(20) NOT NULL DEFAULT "" ,
    nickname VARCHAR(20) NOT NULL DEFAULT "" ,
    password VARCHAR(32) NOT NULL DEFAULT "" ,
    role_id INT CHECK (role_id > 0) NOT NULL DEFAULT 0 ,
    level_id INT CHECK (level_id > 0) NOT NULL DEFAULT 0 ,
    last_login INT CHECK (last_login > 0) NOT NULL DEFAULT 0 ,
    last_ip VARCHAR(50) NOT NULL DEFAULT "" ,
    register_ip VARCHAR(50) NOT NULL DEFAULT "" ,
    last_region VARCHAR(50) NOT NULL DEFAULT "" ,
    login_count INT CHECK (login_count > 0) NOT NULL DEFAULT 0 ,
    status SMALLINT CHECK (status > 0) NOT NULL DEFAULT 0 ,
    sort int NOT NULL DEFAULT 0 ,
    created INT CHECK (created > 0) NOT NULL DEFAULT 0 ,
    updated INT CHECK (updated > 0) NOT NULL DEFAULT 0 ,
    PRIMARY KEY(id)
)  ;
INSERT INTO users (name, nickname, role_id, level_id, last_login, last_ip, last_region, status, created, updated, register_ip) VALUES
('tempname', 'TEMPNAME', 1, 1, UNIX_TIMESTAMP(), '127.0.0.1', 'U.S.A', 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '127.0.0.1');

/** 用户财务表 **/
DROP TABLE IF EXISTS user_accounts;
CREATE SEQUENCE user_accounts_seq;

CREATE TABLE IF NOT EXISTS user_accounts (
     id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('user_accounts_seq'),
     user_id INT CHECK (user_id > 0) NOT NULL DEFAULT 0 ,
     user_name VARCHAR(20) NOT NULL DEFAULT "" ,
     remain DECIMAL(12, 3) NOT NULL DEFAULT 0 ,
     frozen DECIMAL(12, 3) NOT NULL DEFAULT 0 ,
     total DECIMAL(12, 3) NOT NULL DEFAULT 0 ,
     charged DECIMAL(12, 3) NOT NULL DEFAULT 0 ,
     activity DECIMAL(12, 3) NOT NULL DEFAULT 0 ,
     withdraw DECIMAL(12, 3) NOT NULL DEFAULT 0 ,
     total_in DECIMAL(12, 3) NOT NULL DEFAULT 0 ,
     total_out DECIMAL(12, 3) NOT NULL DEFAULT 0 ,
     is_locked smallint NOT NULL DEFAULT 0 ,
     updated INT CHECK (updated > 0) NOT NULL DEFAULT 0 ,
     UNIQUE (user_id),
     PRIMARY KEY(id)
)  ;
INSERT INTO user_accounts(user_id, user_name, updated) VALUES
(1, 'tempname', UNIX_TIMESTAMP());

/** 用户层级表 **/
DROP TABLE IF EXISTS user_levels;
CREATE SEQUENCE user_levels_seq;

CREATE TABLE IF NOT EXISTS user_levels (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('user_levels_seq'),
    name VARCHAR(50) NOT NULL DEFAULT "" ,
    remark VARCHAR(200) NOT NULL DEFAULT "" ,
    UNIQUE (name),
    PRIMARY KEY(id)
)  ;
INSERT INTO user_levels (name, remark) VALUES
('大客户', '优先级最高');

/** 用户角色表 **/
DROP TABLE IF EXISTS user_roles;
CREATE SEQUENCE user_roles_seq;

CREATE TABLE IF NOT EXISTS user_roles (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('user_roles_seq'),
    name VARCHAR(50) NOT NULL DEFAULT "" ,
    remark VARCHAR(200) NOT NULL DEFAULT "" ,
    UNIQUE (name),
    PRIMARY KEY(id)
)  ;
INSERT INTO user_roles (name, remark) VALUES
('VIP1', 'VIP1'),
('VIP2', 'VIP2');

/** 公告 **/
DROP TABLE IF EXISTS notices;
CREATE SEQUENCE notices_seq;

CREATE TABLE IF NOT EXISTS notices (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('notices_seq'),
    title VARCHAR(100) NOT NULL DEFAULT "" ,
    content text ,
    sort INT NOT NULL DEFAULT 0 ,
    status SMALLINT CHECK (status > 0) NOT NULL DEFAULT 0 ,
    created INT CHECK (created > 0) NOT NULL DEFAULT 0 ,
    updated INT CHECK (updated > 0) NOT NULL DEFAULT 0 ,
    UNIQUE (title),
    PRIMARY KEY(id)
)  ;
INSERT INTO notices (title, created, updated, status) VALUES
('新用户注册即送千元大奖', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 1);

/** 活动 **/
DROP TABLE IF EXISTS activities;
CREATE SEQUENCE activities_seq;

CREATE TABLE IF NOT EXISTS activities (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('activities_seq'),
    title VARCHAR(100) NOT NULL DEFAULT "" ,
    content text ,
    sort INT NOT NULL DEFAULT 0 ,
    status SMALLINT CHECK (status > 0) NOT NULL DEFAULT 0 ,
	period_start INT CHECK (period_start > 0) NOT NULL DEFAULT 0 ,
	period_end INT CHECK (period_end > 0) NOT NULL DEFAULT 0 ,
    created INT CHECK (created > 0) NOT NULL DEFAULT 0 ,
    updated INT CHECK (updated > 0) NOT NULL DEFAULT 0 ,
    UNIQUE (title),
    PRIMARY KEY(id)
)  ;
INSERT INTO activities (title, created, updated, status) VALUES
('迎春节, 百万红包, 码上有礼活动', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 1);

/** 游戏分类 **/
DROP TABLE IF EXISTS game_categories;
CREATE SEQUENCE game_categories_seq;

CREATE TABLE IF NOT EXISTS game_categories (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('game_categories_seq'),
    name VARCHAR(50) NOT NULL DEFAULT "" ,
    remark VARCHAR(200) NOT NULL DEFAULT "" ,
    UNIQUE (name),
    PRIMARY KEY(id)
)  ;
INSERT INTO game_categories (name, remark) VALUES
('彩票游戏', '彩票'),
('棋牌游戏', '棋牌');

/** 游戏 **/
DROP TABLE IF EXISTS games;
CREATE SEQUENCE games_seq;

CREATE TABLE IF NOT EXISTS games (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('games_seq'),
	category_id INT CHECK (category_id > 0) NOT NULL DEFAULT 0 ,
    name VARCHAR(50) NOT NULL DEFAULT "" ,
    remark VARCHAR(200) NOT NULL DEFAULT "" ,
	status SMALLINT CHECK (status > 0) NOT NULL DEFAULT 0 ,
    created INT CHECK (created > 0) NOT NULL DEFAULT 0 ,
    updated INT CHECK (updated > 0) NOT NULL DEFAULT 0
	,
    UNIQUE (name),
    PRIMARY KEY(id)
)  ;

CREATE INDEX(category_id);
INSERT INTO games (category_id, name, remark, created, updated, status) VALUES
(1, '彩票游戏', '彩票', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 1),
(2, '百人牛牛', '牛牛', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 1),
(2, '斗地主', '斗地主', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 1),
(2, '红黑大战', '扑克', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 1),
(2, '急速捕鱼', '捕鱼', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 1),
(2, '抢庄牛牛', '牛牛', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 1);

/** 充值记录 **/
DROP TABLE IF EXISTS user_charges;
CREATE SEQUENCE user_charges_seq;

CREATE TABLE IF NOT EXISTS user_charges (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('user_charges_seq'),
	user_id INT CHECK (user_id > 0) NOT NULL DEFAULT 0 ,
	user_name VARCHAR(50) NOT NULL DEFAULT "" ,
	amount DECIMAL(12, 3) NOT NULL DEFAULT 0 ,
	amount_real DECIMAL(12, 3) NOT NULL DEFAULT 0 ,
	amount_activity DECIMAL(12, 3) NOT NULL DEFAULT 0 ,
	amount_gift DECIMAL(12, 3) NOT NULL DEFAULT 0 ,
	pay_type SMALLINT CHECK (pay_type > 0) NOT NULL DEFAULT 0 ,
	is_first SMALLINT CHECK (is_first > 0) NOT NULL DEFAULT 0 ,
	status SMALLINT CHECK (status > 0) DEFAULT 0 ,
	created INT CHECK (created > 0) NOT NULL DEFAULT 0 ,
	updated INT CHECK (updated > 0) NOT NULL DEFAULT 0 ,
	finished INT CHECK (finished > 0) NOT NULL DEFAULT 0 ,
	reason VARCHAR(200) NOT NULL DEFAULT "" ,
	PRIMARY KEY(id)
)  ;
INSERT INTO user_charges (user_id, user_name, amount, pay_type, created, updated) VALUES
(1, 'tempname', 500, 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP());

/** 提现记录 **/
DROP TABLE IF EXISTS user_withdraws;
CREATE SEQUENCE user_withdraws_seq;

CREATE TABLE IF NOT EXISTS user_withdraws (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('user_withdraws_seq'),
	user_id INT CHECK (user_id > 0) NOT NULL DEFAULT 0 ,
	user_name VARCHAR(50) NOT NULL DEFAULT "" ,
	amount DECIMAL(12, 3) NOT NULL DEFAULT 0 ,
	real_name VARCHAR(50) NOT NULL DEFAULT "" ,
	bank_id INT CHECK (bank_id > 0) NOT NULL DEFAULT 0 ,
	bank_name VARCHAR(20) NOT NULL DEFAULT "" ,
	bank_sub_name VARCHAR(20) NOT NULL DEFAULT "" ,
	bank_no VARCHAR(30) NOT NULL DEFAULT "" ,
	status SMALLINT CHECK (status > 0) DEFAULT 0 ,
	card_id INT CHECK (card_id > 0) NOT NULL DEFAULT 0 ,
	created INT CHECK (created > 0) NOT NULL DEFAULT 0 ,
	updated INT CHECK (updated > 0) NOT NULL DEFAULT 0 ,
	finished INT CHECK (finished > 0) NOT NULL DEFAULT 0 ,
	province_id INT CHECK (province_id > 0) NOT NULL DEFAULT 0 ,
	city_id INT CHECK (city_id > 0) NOT NULL DEFAULT 0 ,
	reason VARCHAR(200) NOT NULL DEFAULT "" ,
	PRIMARY KEY(id)
)  ;
INSERT INTO user_withdraws (user_id, user_name, amount, created, updated) VALUES
(1, 'tempname', 500, UNIX_TIMESTAMP(), UNIX_TIMESTAMP());

/** 用户绑卡 **/
DROP TABLE IF EXISTS user_cards;
CREATE SEQUENCE user_cards_seq;

CREATE TABLE IF NOT EXISTS user_cards (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('user_cards_seq'),
	user_id INT CHECK (user_id > 0) NOT NULL DEFAULT 0 ,
	user_name VARCHAR(50) NOT NULL DEFAULT "" ,
	bank_id INT CHECK (bank_id > 0) NOT NULL DEFAULT 0 ,
	bank_name VARCHAR(20) NOT NULL DEFAULT "" ,
	bank_sub_name VARCHAR(20) NOT NULL DEFAULT "" ,
	bank_no VARCHAR(30) NOT NULL DEFAULT "" ,
	real_name VARCHAR(20) NOT NULL DEFAULT "" ,
    remark VARCHAR(200) NOT NULL DEFAULT "" ,
	province_id INT CHECK (province_id > 0) NOT NULL DEFAULT 0 ,
	city_id INT CHECK (city_id > 0) NOT NULL DEFAULT 0 ,
	created INT CHECK (created > 0) NOT NULL DEFAULT 0 ,
	updated INT CHECK (updated > 0) NOT NULL DEFAULT 0 ,
	UNIQUE (bank_no),
    PRIMARY KEY(id)
)  ;

/** 银行 **/
DROP TABLE IF EXISTS banks;
CREATE SEQUENCE banks_seq;

CREATE TABLE IF NOT EXISTS banks (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('banks_seq'),
    name VARCHAR(50) NOT NULL DEFAULT "" ,
	code CHAR(10) NOT NULL DEFAULT "" ,
    remark VARCHAR(200) NOT NULL DEFAULT "" ,
	sort INT NOT NULL DEFAULT 0 ,
	status SMALLINT CHECK (status > 0) NOT NULL DEFAULT 0 ,
    UNIQUE (name)
	,
    PRIMARY KEY(id)
)  ;

CREATE INDEX(sort);

/** 省 **/
DROP TABLE IF EXISTS provinces;
CREATE SEQUENCE provinces_seq;

CREATE TABLE IF NOT EXISTS provinces (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('provinces_seq'),
    name VARCHAR(50) NOT NULL DEFAULT "" ,
    remark VARCHAR(200) NOT NULL DEFAULT "" ,
	code CHAR(12) NOT NULL DEFAULT "" ,
    UNIQUE (name),
    PRIMARY KEY(id)
)  ;

/** 省 **/
DROP TABLE IF EXISTS cities;
CREATE SEQUENCE cities_seq;

CREATE TABLE IF NOT EXISTS cities (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('cities_seq'),
	province_id INT CHECK (province_id > 0) NOT NULL DEFAULT 0 ,
    name VARCHAR(50) NOT NULL DEFAULT "" ,
    remark VARCHAR(200) NOT NULL DEFAULT "" ,
	province_code CHAR(12) NOT NULL DEFAULT "" ,
	code CHAR(12) NOT NULL DEFAULT "" ,
    PRIMARY KEY(id)
)  ;

/** 配置表 **/
DROP TABLE IF EXISTS parameters;
CREATE SEQUENCE parameters_seq;

CREATE TABLE IF NOT EXISTS parameters (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('parameters_seq'),
    name VARCHAR(50) NOT NULL DEFAULT "" ,
	value TEXT ,
    remark VARCHAR(200) NOT NULL DEFAULT "" ,
    status smallint NOT NULL DEFAULT 0 ,
    sort int NOT NULL DEFAULT 0 ,
    created INT CHECK (created > 0) NOT NULL DEFAULT 0 ,
    updated INT CHECK (updated > 0) NOT NULL DEFAULT 0
	,
	UNIQUE (name),
    PRIMARY KEY(id)
)  ;

CREATE INDEX(sort);
INSERT INTO parameters (name, value, remark, created, updated) VALUES
('site_name', '网站名称', '网站名称', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),
('site_logo', '网站LOGO', '网站LOGO', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());

/** 配置表 **/
DROP TABLE IF EXISTS configs;
CREATE SEQUENCE configs_seq;

CREATE TABLE IF NOT EXISTS configs (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('configs_seq'),
    name VARCHAR(50) NOT NULL DEFAULT "" ,
	value TEXT ,
    remark VARCHAR(200) NOT NULL DEFAULT "" ,
    status smallint NOT NULL DEFAULT 0 ,
    sort int NOT NULL DEFAULT 0 ,
    created INT CHECK (created > 0) NOT NULL DEFAULT 0 ,
    updated INT CHECK (updated > 0) NOT NULL DEFAULT 0
	,
	UNIQUE (name),
    PRIMARY KEY(id)
)  ;

CREATE INDEX(sort);
INSERT INTO configs (name, value, remark, created, updated) VALUES
('site_name', '网站名称', '网站名称', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),
('site_logo', '网站LOGO', '网站LOGO', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());

/** 帮助分类 **/
DROP TABLE IF EXISTS help_categories;
CREATE SEQUENCE help_categories_seq;

CREATE TABLE IF NOT EXISTS help_categories (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('help_categories_seq'),
    name VARCHAR(50) NOT NULL DEFAULT "" ,
    remark VARCHAR(200) NOT NULL DEFAULT "" ,
    UNIQUE (name),
    PRIMARY KEY(id)
)  ;
INSERT INTO help_categories (name, remark) VALUES
('用户注册', '注册'),
('彩票投注', '投注'),
('用户充值', '充值'),
('用户提款', '提现'),
('其他问题', '其他');

/** 帮助 **/
DROP TABLE IF EXISTS helps;
CREATE SEQUENCE helps_seq;

CREATE TABLE IF NOT EXISTS helps (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('helps_seq'),
	category_id INT CHECK (category_id > 0) NOT NULL DEFAULT 0 ,
    title VARCHAR(100) NOT NULL DEFAULT "" ,
    content text ,
    sort INT NOT NULL DEFAULT 0 ,
    status SMALLINT CHECK (status > 0) NOT NULL DEFAULT 0 ,
    created INT CHECK (created > 0) NOT NULL DEFAULT 0 ,
    updated INT CHECK (updated > 0) NOT NULL DEFAULT 0 ,
    UNIQUE (title),
    PRIMARY KEY(id)
)  ;
INSERT INTO helps (title, created, updated, status, category_id) VALUES
('对于用户使用本站投注服务的约定', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 1, 1);

/** 彩种标签 **/
DROP TABLE IF EXISTS lottery_tags;
CREATE SEQUENCE lottery_tags_seq;

CREATE TABLE IF NOT EXISTS lottery_tags (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('lottery_tags_seq'),
    name VARCHAR(50) NOT NULL DEFAULT "" ,
    remark VARCHAR(200) NOT NULL DEFAULT "" ,
    UNIQUE (name),
    PRIMARY KEY(id)
)  ;
INSERT INTO lottery_tags (name, remark) VALUES
('高频彩', '高频'),
('低频彩', '低频'),
('趣味', '趣味');

/** 玩法总类 **/
DROP TABLE IF EXISTS play_groups;
CREATE SEQUENCE play_groups_seq;

CREATE TABLE IF NOT EXISTS play_groups (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('play_groups_seq'),
    name VARCHAR(50) NOT NULL DEFAULT "" ,
    remark VARCHAR(200) NOT NULL DEFAULT "" ,
    UNIQUE (name),
    PRIMARY KEY(id)
)  ;
INSERT INTO play_groups (name, remark) VALUES
('三星', '三星'),
('趣味', '趣味');

/** 玩法子类 **/
DROP TABLE IF EXISTS play_types;
CREATE SEQUENCE play_types_seq;

CREATE TABLE IF NOT EXISTS play_types (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('play_types_seq'),
	group_id INT CHECK (group_id > 0) NOT NULL DEFAULT 0 ,
    name VARCHAR(50) NOT NULL DEFAULT "" ,
    remark VARCHAR(200) NOT NULL DEFAULT ""
	,
    UNIQUE (name),
    PRIMARY KEY(id)
)  ;

CREATE INDEX(group_id);
INSERT INTO play_types (group_id, name, remark) VALUES
(1, '前三', '前三'),
(1, '中三', '中三');

/** 玩法 **/
DROP TABLE IF EXISTS plays;
CREATE SEQUENCE plays_seq;

CREATE TABLE IF NOT EXISTS plays (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('plays_seq'),
	group_id INT CHECK (group_id > 0) NOT NULL DEFAULT 0 ,
	type_id  INT CHECK (type_id > 0) NOT NULL DEFAULT 0 ,
    name VARCHAR(50) NOT NULL DEFAULT "" ,
    remark VARCHAR(200) NOT NULL DEFAULT ""
	,
    UNIQUE (name),
    PRIMARY KEY(id)
)  ;

CREATE INDEX(group_id);
CREATE INDEX(type_id);
INSERT INTO plays (group_id, type_id, name, remark) VALUES
(1, 1, '前三直选', '直选'),
(1, 1, '前三组选', '组选'),
(1, 2, '中三组选', '中三组选');

/** 玩法说明 **/
DROP TABLE IF EXISTS play_notes;
CREATE SEQUENCE play_notes_seq;

CREATE TABLE IF NOT EXISTS play_notes (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('play_notes_seq'),
	lottery_id INT CHECK (lottery_id > 0) NOT NULL DEFAULT 0 ,
    title VARCHAR(100) NOT NULL DEFAULT "" ,
    content text ,
    sort INT NOT NULL DEFAULT 0 ,
    status SMALLINT CHECK (status > 0) NOT NULL DEFAULT 0 ,
    created INT CHECK (created > 0) NOT NULL DEFAULT 0 ,
    updated INT CHECK (updated > 0) NOT NULL DEFAULT 0 ,
    UNIQUE (title),
    PRIMARY KEY(id)
)  ;
INSERT INTO play_notes (lottery_id, title, created, updated, status) VALUES
(1, '对于用户使用本站投注服务的约定', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 1);

/** 彩种分类 **/
DROP TABLE IF EXISTS lottery_categories;
CREATE SEQUENCE lottery_categories_seq;

CREATE TABLE IF NOT EXISTS lottery_categories (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('lottery_categories_seq'),
    name VARCHAR(50) NOT NULL DEFAULT "" ,
    remark VARCHAR(200) NOT NULL DEFAULT "" ,
    UNIQUE (name),
    PRIMARY KEY(id)
)  ;
INSERT INTO lottery_categories (name, remark) VALUES
('时时彩', '时时彩'),
('PK10', '参照北京PK10'),
('11选5', '11选5系列'),
('快3', '快3系列'),
('六合彩', '香港六合彩系列');

/** 彩种 **/
DROP TABLE IF EXISTS lotteries;
CREATE SEQUENCE lotteries_seq;

CREATE TABLE IF NOT EXISTS lotteries (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('lotteries_seq'),
	category_id INT CHECK (category_id > 0) NOT NULL DEFAULT 0 ,
	tag_id INT CHECK (tag_id > 0) NOT NULL DEFAULT 0 ,
    name VARCHAR(50) NOT NULL DEFAULT "" ,
    remark VARCHAR(200) NOT NULL DEFAULT "" ,
	sort INT NOT NULL DEFAULT 0 ,
    status SMALLINT CHECK (status > 0) NOT NULL DEFAULT 0 ,
    created INT CHECK (created > 0) NOT NULL DEFAULT 0 ,
    updated INT CHECK (updated > 0) NOT NULL DEFAULT 0
	,
    UNIQUE (name),
    PRIMARY KEY(id)
)  ;

CREATE INDEX(sort);
INSERT INTO lotteries (category_id, tag_id, name, status, created, updated) VALUES
(1, 1, '重庆时时彩', 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP());

/** 开奖时间 **/
DROP TABLE IF EXISTS open_times;
CREATE SEQUENCE open_times_seq;

CREATE TABLE IF NOT EXISTS open_times (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('open_times_seq'),
	lottery_id INT CHECK (lottery_id > 0) NOT NULL DEFAULT 0 ,
	period_number VARCHAR(10) NOT NULL DEFAULT "" ,
	time_close CHAR(8) NOT NULL DEFAULT "00:00:00" ,
	time_open CHAR(8) NOT NULL DEFAULT "00:00:00" ,
	day_offset SMALLINT CHECK (day_offset > 0) NOT NULL DEFAULT 0 ,
	is_begin SMALLINT CHECK (is_begin > 0) NOT NULL DEFAULT 0 ,
	is_end SMALLINT CHECK (is_end > 0) NOT NULL DEFAULT 0 ,
	sort INT NOT NULL DEFAULT 0
	,
    PRIMARY KEY(id)
)  ;

CREATE INDEX(sort);
CREATE INDEX(lottery_id);
CREATE INDEX(period_number);
INSERT INTO open_times (lottery_id, period_number, time_close, time_open) VALUES
(1, '001', '00:29:30', '00:30:00'),
(1, '002', '01:29:30', '01:30:00'),
(1, '003', '02:29:30', '02:30:00'),
(1, '004', '03:29:30', '03:30:00'),
(1, '005', '04:29:30', '04:30:00'),
(1, '006', '05:29:30', '05:30:00'),
(1, '007', '06:29:30', '06:30:00'),
(1, '008', '07:29:30', '07:30:00');

/** 开奖奖期 **/
DROP TABLE IF EXISTS open_periods;
CREATE SEQUENCE open_periods_seq;

CREATE TABLE IF NOT EXISTS open_periods (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('open_periods_seq'),
	lottery_id INT CHECK (lottery_id > 0) NOT NULL DEFAULT 0 ,
	period_number VARCHAR(20) NOT NULL DEFAULT "" ,
	time_close CHAR(20) NOT NULL DEFAULT "" ,
	time_open CHAR(20) NOT NULL DEFAULT "" ,
	day_offset SMALLINT CHECK (day_offset > 0) NOT NULL DEFAULT 0 ,
	is_begin SMALLINT CHECK (is_begin > 0) NOT NULL DEFAULT 0 ,
	is_end SMALLINT CHECK (is_end > 0) NOT NULL DEFAULT 0 ,
	is_opened SMALLINT CHECK (is_opened > 0) NOT NULL DEFAULT 0 ,
    created INT CHECK (created > 0) NOT NULL DEFAULT 0 ,
    updated INT CHECK (updated > 0) NOT NULL DEFAULT 0 ,
	sort INT NOT NULL DEFAULT 0
	,
    PRIMARY KEY(id)
)  ;

CREATE INDEX(sort);
CREATE INDEX(lottery_id);
CREATE INDEX(period_number);
INSERT INTO open_periods (lottery_id, period_number, time_close, time_open) VALUES
(1, '20191130001', '2019-11-30 00:29:30', '2019-10-30 00:30:00'),
(1, '20191130002', '2019-11-30 01:29:30', '2019-10-30 01:30:00'),
(1, '20191130003', '2019-11-30 02:29:30', '2019-10-30 02:30:00'),
(1, '20191130004', '2019-11-30 03:29:30', '2019-10-30 03:30:00'),
(1, '20191130005', '2019-11-30 04:29:30', '2019-10-30 04:30:00'),
(1, '20191130006', '2019-11-30 05:29:30', '2019-10-30 05:30:00'),
(1, '20191130007', '2019-11-30 06:29:30', '2019-10-30 06:30:00'),
(1, '20191130008', '2019-11-30 07:29:30', '2019-10-30 07:30:00');

/** 开奖结果 **/
DROP TABLE IF EXISTS open_numbers;
CREATE SEQUENCE open_numbers_seq;

CREATE TABLE IF NOT EXISTS open_numbers (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('open_numbers_seq'),
	lottery_id INT CHECK (lottery_id > 0) NOT NULL DEFAULT 0 ,
	period_number CHAR(20) NOT NULL DEFAULT "" ,
	numbers VARCHAR(20) NOT NULL DEFAULT "" ,
	open_time INT CHECK (open_time > 0) NOT NULL DEFAULT 0 ,
	is_finished SMALLINT NOT NULL DEFAULT 0 ,
    created INT CHECK (created > 0) NOT NULL DEFAULT 0 ,
    updated INT CHECK (updated > 0) NOT NULL DEFAULT 0 ,
    remark VARCHAR(200) NOT NULL DEFAULT "" ,
	sort INT NOT NULL DEFAULT 0 ,
    PRIMARY KEY(id)
)  ;

CREATE INDEX(lottery_id);
CREATE INDEX(period_number);
CREATE INDEX(sort);
INSERT INTO open_numbers (lottery_id, period_number,numbers,  open_time, created, updated) VALUES
(1, '20191130001', '1,2,3,4,5', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),
(1, '20191130002', '1,2,3,4,5', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),
(1, '20191130003', '1,2,3,4,5', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),
(1, '20191130004', '1,2,3,4,5', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),
(1, '20191130005', '1,2,3,4,5', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),
(1, '20191130006', '1,2,3,4,5', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),
(1, '20191130007', '1,2,3,4,5', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),
(1, '20191130008', '1,2,3,4,5', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), UNIX_TIMESTAMP());