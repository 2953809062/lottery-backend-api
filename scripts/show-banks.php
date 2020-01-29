#!/usr/bin/php -f 
<?php

$banks = json_decode(file_get_contents('./banks.json'));

$sql = "INSERT INTO banks (name, code, remark) VALUES \n";
$sArr = [];

foreach ($banks as $b) { 
	$sArr[] = "('{$b->text}', '{$b->value}', '{$b->text}')";
}

$sql .= implode(",\n", $sArr). ";";

$line = '/* ----------------------------------------------------------------------------------------------- */';
echo "/* 导入银行列表: */\n$line\n$sql\n$line\n";
