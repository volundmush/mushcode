<?php
	require 'db.php';
	require 'ansi.php';

	if (isset($_REQUEST['id']))
	{
		$num = intval($_REQUEST['id']);
	}
	else
	{
	$num = -1;
	}
	include('Smarty.class.php');
?>
