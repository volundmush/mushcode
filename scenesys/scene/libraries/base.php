<?php
	require 'libraries/db.php';
	require 'libraries/ansi.php';
	$num = ($_REQUEST['id']  ? $_REQUEST['id'] : $num );
	include('libraries/smarty/Smarty.class.php');
	$smarty = new Smarty;
	$gameinfo = ["name"=>$gamename,"desc"=>$gamedesc,"site"=>$gameurl,"connect"=>$gameconnect];
	$smarty->assign('info',$gameinfo);
?>