<?php 
	require 'base.php';
	$smarty = new Smarty;
	
	if (!$scenedb->count('mush_scene', ['scene_id'=>$num]))
	{
		$smarty->assign('message', "The entered ID was not found.");
		$smarty->display('error.tpl');
	}
	else
	{
		
		$schedule_data = $scenedb->query(sprintf("SELECT t.object_name,t.thing_id,s.title,s.pitch,s.date_scheduled FROM mush_scene AS s LEFT JOIN mush_actor AS act ON act.scene_id=s.scene_id AND act.actor_type=2 LEFT JOIN mush_thing AS t ON t.thing_id=act.player_id WHERE s.scene_id=%s",$num))->fetch();

		$truetime = explode(" ",$schedule_data['date_scheduled']);
		$hourminute = explode(":",$truetime[1]);
		$scene_time = $hourminute[0].":".$hourminute[1];
		
		$schedule = ['object_name'=>$schedule_data['object_name'],'date'=>$truetime[0],'id'=>$num,'title'=>$schedule_data['title'],'desc'=>$schedule_data['pitch'],'time'=>$scene_time];
		
		$smarty->assign('schedule',$schedule);
		$smarty->display('schedule.tpl');
	}
	
?>
