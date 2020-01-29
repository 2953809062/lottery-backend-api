#!/usr/bin/php -f
<?php

$host = 'localhost';
$db_name = 'game001';
$user = 'game001';
$password = 'game001-x-lsl';

$conn = new PDO("mysql:host=$host;dbname=$db_name;", $user, $password);
//$conn->exec('set names utf8');

$lottery_cats = [
	'1' => [1, 2, 3, 4],
	'2' => [5, 6, 7, 8],
	'3' => [9, 10, 11, 12],
];

$content = "INSERT INTO lottery_plays (category_id, play_group_id, play_type_id, play_id, lottery_id, odds) VALUES \n";
foreach ($lottery_cats as $cat_id => $ids) { 
	foreach ($ids as $id) { 
		$sql = "SELECT * from plays WHERE category_id = '$cat_id' ORDER BY id ASC";
		$stmt = $conn->prepare($sql);
		$rs = $stmt->execute([]);
		if ($rs) { 
			while ($r = $stmt->fetch(PDO::FETCH_OBJ)) { 
				$insert_sql = sprintf("(%d, %d, %d, %d, %d, %.3f),\n", 
					$r->category_id, 
					$r->group_id,
					$r->type_id, 
					$r->id,
					$id,
					$r->odds
				);
				$content .= $insert_sql;
			}
		}
	}
}

$sql = trim(trim($content),','). ";\n";
echo $sql;

file_put_contents('./lottery-plays.sql', $sql);
