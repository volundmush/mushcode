<?php
	require 'base.php';
	$smarty = new Smarty;
	$check = $scenedb->count('mush_scene', ['scene_id'=>$num]);
	if (!$check)
	{
		$smarty->assign('message', "The entered ID was not found.");
		$smarty->display('error.tpl');
	}
	else
	{
		$scene_data = $scenedb->query(sprintf("SELECT t.object_name,t.thing_id,s.title,s.outcome,s.scene_status,s.date_finished FROM mush_scene AS s LEFT JOIN mush_actor AS a ON s.scene_id=a.scene_id AND a.actor_type=2 LEFT JOIN mush_thing AS t ON t.thing_id=a.player_id WHERE s.scene_id=%s", $num))->fetch();
		$pose_list = $scenedb->query(sprintf("SELECT t.thing_id,t.object_name,act.action_text FROM mush_action AS act LEFT JOIN mush_actor AS a ON act.actor_id=a.actor_id LEFT JOIN mush_thing AS t ON t.thing_id=a.player_id LEFT JOIN mush_action_source AS src ON act.source_id=src.source_id WHERE act.is_deleted=0 AND src.scene_id=%s",$num))->fetchAll();
		
		$pose_data = array();
		$log_data = "";
		$poser_ids = array();
		foreach ($pose_list as $indiv)
		{
			$scene_text = ansi2html($indiv['action_text']);
			$pose_data[] = ["owner"=>$indiv['thing_id'], "owner_name"=>$indiv['object_name'], "text"=>$scene_text];
			$poser_ids[] = $indiv['thing_id'];
			$scene_text2 = str_replace("&","&amp;",$scene_text);
			$scene_text2 = preg_replace("/<(.+?)>/","&lt;\\1&gt;",$scene_text2);
			$scene_text2 = str_replace('"',"&quot;",$scene_text2);
			$log_data .= ":'''{{#var:".$indiv['thing_id']."|".$indiv['object_name']." (".$indiv['thing_id'].")}} has posed:'''&lt;br&gt;".$scene_text2."<br> <br>\n\n";
		}
		
		$poser_ids = array_unique($poser_ids);
		$poser_list = implode(", ",$poser_ids);
		$scene_date = substr($scene_data['date_finished'],0,10);
		
		$scene = ["title"=>$scene_data['title'], 'id'=>$num, 'description'=>$scene_data['outcome'], 'formatted_poses'=>$log_data, 'url'=>$url, 'poser_ids'=>$poser_list, 'date_created'=>$scene_date];

		$smarty->assign('poses', $pose_data);
		$smarty->assign('scene', $scene);
		$smarty->display('scene.tpl');
	}

?>
