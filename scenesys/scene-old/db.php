<?php
	require 'medoo.php';
	
	$db_type = 'mysql';
	$db_username="username";  // We highly suggest the use of a SELECT PERMISSIONS only account.
	$db_password="password"; // This way, there is no security risk. SceneSys doesn't require more at this moment.
	$db_database="database";
	$db_site="localhost";
	$posecount = 0;
	
	$url = "../index.php/Special:FormEdit/Roleplaying Log/";
	
	$scenedb = new medoo(['database_type'=>$db_type, 'database_name'=>$db_database, 'server'=>$db_site, 'username'=>$db_username, 'password'=>$db_password, 'charset'=>'utf8']);
	
?>
