<?php
	require 'db.php';
	require 'ansi.php';
	$num = ($_REQUEST['id']  ? $_REQUEST['id'] : $num );
	include('Smarty.class.php');
?>