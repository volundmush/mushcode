<?php
	require 'base.php';
	$smarty = new Smarty;
	$num = ($_REQUEST['id']  ? $_REQUEST['id'] : $num );

	if (!$scenedb->count('scenes', ['scene_id'=>$num]))
	{
		$smarty->assign('message', "The entered ID was not found.");
		$smarty->display('error.tpl');
	}
	else
	{
		$scene_data = $scenedb->get('scenes', ["[>]players" => "player_id"], ['player_name', 'player_id', 'scene_title', 'scene_desc', 'scene_state', 'creation_date', 'room_name'], ['scene_id'=>$num]);

		$pose_list = $scenedb->select('poses', ["[>]players" => "player_id"], ['player_name', 'player_id', 'pose'], ['AND'=>['pose_ignore'=>0, 'scene_id'=>$num]]);
		$pose_data = array();
		$log_data = "";
		$poser_ids = array();
		foreach ($pose_list as $indiv)
		{
			$scene_text = ansi2html($indiv['pose']);
			$pose_data[] = ["owner"=>$indiv['player_id'], "owner_name"=>$indiv['player_name'], "text"=>$scene_text];
			$poser_ids[] = $indiv['player_id'];
			$scene_text2 = str_replace("&","&amp;",$scene_text);
			$scene_text2 = preg_replace("/<(.+?)>/","&lt;\\1&gt;",$scene_text2);
			$scene_text2 = str_replace('"',"&quot;",$scene_text2);
			$log_data .= ":'''{{#var:".$indiv['player_id']."|".$indiv['player_name']." (".$indiv['player_id'].")}} has posed:'''&lt;br&gt;".$scene_text2."<br> <br>\n\n";
		}
		
		$poser_ids = array_unique($poser_ids);
		$poser_list = implode(", ",$poser_ids);
		$scene_date = substr($scene_data['creation_date'],0,10);
		
		$scene = ["title"=>$scene_data['scene_title'], 'id'=>$num, 'location'=>$scene_data['room_name'], 'description'=>$scene_data['scene_desc'], 'formatted_poses'=>$log_data, 'url'=>$url, 'poser_ids'=>$poser_list, 'creation_date'=>$scene_date];
		
		$smarty->assign('poses', $pose_data);
		$smarty->assign('scene', $scene);
		$smarty->display('scene.tpl');
	}

?>