<?php
	require 'base.php';
	$smarty = new Smarty;
	$num = ($_REQUEST['id']  ? $_REQUEST['id'] : $num );

	if (!$scenedb->count('scenes', ['player_id'=>$num]))
	{
		$smarty->assign('message', "The entered ID was not found.");
		$smarty->display('error.tpl');
	}
	else
	{
	$scene_list = $scenedb->select('scenes', ["[>]players" => "player_id"], ["scene_id", "player_id", "player_name", "scene_title", "scene_desc", "scene_state"], ['player_id'=>$num, "ORDER"=>"scene_id DESC"]);
	
	$state_array = ["0"=>"Active", "1"=>"Paused", "2"=>"Unfinished", "3"=>"Finished"];
	$scene_data = array();
	foreach ($scene_list as $indiv)
	{
		$indiv_data = ["id"=>$indiv['scene_id'], "owner_name"=>$indiv['player_name'], "owner"=>$indiv['player_id'], 'title'=>$indiv['scene_title'], "description"=>$indiv['scene_desc'], "state"=>$state_array[$indiv['scene_state']]];
		$scene_data[] = $indiv_data;
	}

	$smarty->assign('scenes', $scene_data);
	$smarty->display('listing.tpl');
	}
	

?>