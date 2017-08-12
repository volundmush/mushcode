<?php
	require 'base.php';
	$smarty = new Smarty;
	$scene_list = $scenedb->query(sprintf("SELECT s.scene_id,t.object_name,t.thing_id,s.title,s.outcome,s.scene_status FROM mush_scene AS s LEFT JOIN mush_actor AS a ON s.scene_id=a.scene_id AND a.actor_type=2 LEFT JOIN mush_thing AS t ON t.thing_id=a.player_id WHERE t.thing_id=%s ORDER BY s.scene_id DESC",$num))->fetchAll();
	
	if (!$scene_list)
	{
		$smarty->assign('message', "The entered ID was not found.");
		$smarty->display('error.tpl');
	}
	else
	{
	
	$state_array = ["0"=>"Active", "1"=>"Paused", "2"=>"Unfinished", "3"=>"Finished"];
	$scene_data = array();
	foreach ($scene_list as $indiv)
	{
		$indiv_data = ["id"=>$indiv['scene_id'], "owner_name"=>$indiv['object_name'], "owner"=>$indiv['thing_id'], 'title'=>$indiv['title'], "description"=>$indiv['outcome'], "state"=>$state_array[$indiv['scene_status']]];
		$scene_data[] = $indiv_data;
	}

	$smarty->assign('scenes', $scene_data);
	$smarty->display('listing.tpl');
	}
	

?>
