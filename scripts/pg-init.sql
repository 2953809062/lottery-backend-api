/** 平台表 **/
DROP TABLE IF EXISTS platforms;
CREATE SEQUENCE platforms_seq;

CREATE TABLE IF NOT EXISTS platforms (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('platforms_seq'),
    name VARCHAR(20) NOT NULL DEFAULT "" ,
    remark VARCHAR(100) NOT NULL DEFAULT "" ,
    sort int NOT NULL DEFAULT 0 ,
    status smallint NOT NULL DEFAULT 1 ,
    created INT CHECK (created > 0) NOT NULL DEFAULT 0 ,
    updated INT CHECK (updated > 0) NOT NULL DEFAULT 0 ,
    UNIQUE (name)
    ,
    PRIMARY KEY(id)
)  ;

CREATE INDEX(sort);
INSERT INTO platforms (name, remark, created, updated) VALUES ('亿万游戏', '棋牌平台', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());

/** 盘口表 **/
DROP TABLE IF EXISTS sites;
CREATE SEQUENCE sites_seq;

CREATE TABLE IF NOT EXISTS sites (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('sites_seq'),
    platform_id INT CHECK (platform_id > 0) NOT NULL DEFAULT 0 ,
    name VARCHAR(20) NOT NULL DEFAULT "" ,
    remark VARCHAR(100) NOT NULL DEFAULT "" ,
    status smallint NOT NULL DEFAULT 1 ,
    sort int NOT NULL DEFAULT 0 ,
    urls TEXT ,
    api VARCHAR(200) NOT NULL DEFAULT "" ,
    admin_url VARCHAR(200) NOT NULL DEFAULT "" ,
    admin_api VARCHAR(200) NOT NULL DEFAULT "" ,
    created INT CHECK (created > 0) NOT NULL DEFAULT 0 ,
    updated INT CHECK (updated > 0) NOT NULL DEFAULT 0
    ,
    UNIQUE (name)
    ,
    PRIMARY KEY(id)
)  ;

CREATE INDEX(platform_id);
CREATE INDEX(name);
CREATE INDEX(sort);
INSERT INTO sites (platform_id, name, urls, remark, created, updated) VALUES
(1, '亿万棋牌', '127.0.0.1:8801,a.game.my', '', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());

/** 盘口配置表 **/
DROP TABLE IF EXISTS site_configs;
CREATE SEQUENCE site_configs_seq;

CREATE TABLE IF NOT EXISTS site_configs (
    id INT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('site_configs_seq'),
    platform_id INT CHECK (platform_id > 0) NOT NULL DEFAULT 0 ,
    site_id INT CHECK (site_id > 0) NOT NULL DEFAULT 0 ,
    name VARCHAR(50) NOT NULL DEFAULT "" ,
    status smallint NOT NULL DEFAULT 1 ,
    value TEXT ,
    remark VARCHAR(200) NOT NULL DEFAULT "" ,
    sort int NOT NULL DEFAULT 0 ,
    created INT CHECK (created > 0) NOT NULL DEFAULT 0 ,
    updated INT CHECK (updated > 0) NOT NULL DEFAULT 0
    ,
    UNIQUE (name)
    ,
    PRIMARY KEY(id)
)  ;

CREATE INDEX(platform_id);
CREATE INDEX(site_id);
CREATE INDEX(sort);
INSERT INTO site_configs (platform_id, site_id, name, value, created, updated) VALUES
(1, 1, 'site_name', '网站名称', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),
(1, 1, 'platform', 'game001', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),
(1, 1, 'db_type', 'mysql', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),
(1, 1, 'conn_strings', 'game001:game001-x-lsl@/game001?charset=utf8', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());

