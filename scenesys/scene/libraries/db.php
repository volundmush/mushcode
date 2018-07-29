<?php
	require 'libraries/Medoo.php';
	
	$db_type = 'mysql';
	$db_username="username";  // We highly suggest the use of a SELECT PERMISSIONS only account.
	$db_password="password"; // This way, there is no security risk. SceneSys doesn't require more at this moment.
	$db_database="database";
	$db_site="localhost";
	$db_prefix="";
	$posecount = 0;
	$gamename = "SceneSys";
	$gamedesc = "Game desc here!";
	$gameurl = "https://github.com/volundmush/mushcode";
	$gameconnect = "<connect data here>";
	
	$url = "../index.php/Special:FormEdit/Roleplaying Log/";
	
	$scenedb = new Medoo\Medoo(['database_type'=>$db_type, 'database_name'=>$db_database, 'server'=>$db_site, 'username'=>$db_username, 'password'=>$db_password, 'charset'=>'utf8', 'prefix'=>$db_prefix]);
	
?>
