<?php 
	require 'libraries/base.php';
	$num = ($_REQUEST['id']  ? $_REQUEST['id'] : $num );
	
	if (!$scenedb->count('volv_scene', ['scene_id'=>$num]))
	{
		$smarty->assign('message', "The entered ID was not found.");
		$smarty->display('templates/error.tpl');
	}
	else
	{
		
		$schedule_data = $scenedb->get('volv_scene', ['runner_name', 'runner_id', 'scene_title', 'scene_pitch', 'scene_date_scheduled'], ['scene_id'=>$num]);
		
		$truetime = explode(" ",$schedule_data['scene_date_scheduled']);
		$hourminute = explode(":",$truetime[1]);
		$scene_time = $truetime[0].":".$truetime[1];
		
		$schedule = ['player_name'=>$schedule_data['runner_name'],'date'=>$truetime[0],'id'=>$num,'title'=>$schedule_data['scene_title'],'desc'=>$schedule_data['scene_pitch'],'time'=>$scene_time];
		
		$smarty->assign('schedule',$schedule);
		$smarty->display('templates/schedule.tpl');
	}
	
?>
