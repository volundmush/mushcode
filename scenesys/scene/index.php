<?php
	require 'base.php';
	$smarty = new Smarty;
	
	$scene_list = $scenedb->select('scenes', ["[>]players" => "player_id"], ["scene_id", "player_id", "player_name", "scene_title", "scene_desc", "scene_state"], ["ORDER"=>"scene_id DESC"]);
	
	$state_array = ["0"=>"Active", "1"=>"Paused", "2"=>"Unfinished", "3"=>"Finished"];
	$scene_data = array();
	foreach ($scene_list as $indiv)
	{
		$indiv_data = ["id"=>$indiv['scene_id'], "owner_name"=>$indiv['player_name'], "owner"=>$indiv['player_id'], 'title'=>$indiv['scene_title'], "description"=>$indiv['scene_desc'], "state"=>$state_array[$indiv['scene_state']]];
		$scene_data[] = $indiv_data;
	}

	$smarty->assign('scenes', $scene_data);
	$smarty->display('listing.tpl');

?>