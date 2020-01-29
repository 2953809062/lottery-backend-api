/*** 库名: sys_platform ***/
/*** 用户: platform_sys ***/
/*** 密码: platform-x-147 ***/
/** create new db **/
/* CREATE DATABASE IF NOT EXISTS sys_platform DEFAULT CHARSET=UTF8; */
/* GRANT ALL PRIVILEGES ON sys_platform.* TO 'platform_sys'@'%' IDENTIFIED BY 'platform-x-147'; */
/* FLUSH PRIVILEGES ; */
/* USE sys_platform; */

/** 平台表 **/
DROP TABLE IF EXISTS platforms;
CREATE TABLE IF NOT EXISTS platforms (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL DEFAULT "" COMMENT "平台名称",
    remark VARCHAR(100) NOT NULL DEFAULT "" COMMENT "备注",
    sort int NOT NULL DEFAULT 0 COMMENT "排序",
    status tinyint NOT NULL DEFAULT 1 COMMENT "状态",
    created INT UNSIGNED NOT NULL DEFAULT 0 COMMENT "添加时间",
    updated INT UNSIGNED NOT NULL DEFAULT 0 COMMENT "修改时间",
    UNIQUE KEY(name),
    INDEX(sort),
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 collate=UTF8_GENERAL_CI;
INSERT INTO platforms (name, remark, created, updated) VALUES ('亿万游戏', '棋牌平台', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());

/** 盘口表 **/
DROP TABLE IF EXISTS sites;
CREATE TABLE IF NOT EXISTS sites (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    platform_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT "平台编号",
    name VARCHAR(20) NOT NULL DEFAULT "" COMMENT "名称",
    remark VARCHAR(100) NOT NULL DEFAULT "" COMMENT "备注",
    status tinyint NOT NULL DEFAULT 1 COMMENT "状态",
    sort int NOT NULL DEFAULT 0 COMMENT "排序",
    urls TEXT COMMENT "域名",
    api VARCHAR(200) NOT NULL DEFAULT "" COMMENT "API地址",
    admin_url VARCHAR(200) NOT NULL DEFAULT "" COMMENT "后台地址",
    admin_api VARCHAR(200) NOT NULL DEFAULT "" COMMENT "后台API",
    created INT UNSIGNED NOT NULL DEFAULT 0 COMMENT "添加时间",
    updated INT UNSIGNED NOT NULL DEFAULT 0 COMMENT "修改时间",
    INDEX(platform_id),
    UNIQUE KEY(name),
    INDEX(name),
    INDEX(sort),
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 collate=UTF8_GENERAL_CI;
INSERT INTO sites (platform_id, name, urls, remark, created, updated) VALUES
(1, '亿万棋牌', '127.0.0.1:8801,a.game.my', '', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());

/** 盘口配置表 **/
DROP TABLE IF EXISTS site_configs;
CREATE TABLE IF NOT EXISTS site_configs (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    platform_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT "平台编号",
    site_id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT "盘口编号",
    name VARCHAR(50) NOT NULL DEFAULT "" COMMENT "配置名称",
    status tinyint NOT NULL DEFAULT 1 COMMENT "状态",
    value TEXT COMMENT "配置项值",
    remark VARCHAR(200) NOT NULL DEFAULT "" COMMENT "备注",
    sort int NOT NULL DEFAULT 0 COMMENT "排序",
    created INT UNSIGNED NOT NULL DEFAULT 0 COMMENT "添加时间",
    updated INT UNSIGNED NOT NULL DEFAULT 0 COMMENT "修改时间",
    INDEX(platform_id),
    INDEX(site_id),
    UNIQUE KEY(name),
    INDEX(sort),
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 collate=UTF8_GENERAL_CI;
INSERT INTO site_configs (platform_id, site_id, name, value, created, updated) VALUES
(1, 1, 'site_name', '网站名称', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),
(1, 1, 'platform', 'game001', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),
(1, 1, 'db_type', 'mysql', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),
(1, 1, 'conn_strings', 'game001:game001-x-lsl@/game001?charset=utf8', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());


