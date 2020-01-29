#!/usr/bin/php -f
<?php
$provinces_file = './provinces.json';
$cities_file = './cities.json';

$pArr = json_decode(file_get_contents($provinces_file));
$cArr = json_decode(file_get_contents($cities_file));

$pSql = "INSERT INTO provinces (name, remark, code) VALUES \n";
$psArr = [];
$cSql = "INSERT INTO cities (name, remark, code, province_code) VALUES \n";
$csArr = [];

foreach ($pArr as $p) { 
	$psArr[] = "('{$p->name}', '{$p->name}', '{$p->id}')";

	$code = $p->id;
	$cities = $cArr->$code;
	foreach ($cities as $c) { 
		$csArr[] = "('{$c->name}', '{$c->province}','{$c->id}', '$code')";
	}
}

$pSql .= implode(",\n", $psArr). ";";
$cSql .= implode(",\n", $csArr). ";";
$uSql = "UPDATE cities, provinces SET province_id = provinces.id WHERE cities.province_code = provinces.code;";

$line = '/* ----------------------------------------------------------------------------------------------- */';
echo "/* 导入省份的SQL: */\n$line\n$pSql\n$line\n";
echo "/* 导入城市的SQL: */\n$line\n$cSql\n$line\n";
echo "/* 更新province_id 字段: */\n$line\n$uSql\n$line\n";
