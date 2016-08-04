<?php 
	require 'base.php';
	$smarty = new Smarty;
	$num = ($_REQUEST['id']  ? $_REQUEST['id'] : $num );
	
	if (!$scenedb->count('schedule', ['schedule_id'=>$num]))
	{
		$smarty->assign('message', "The entered ID was not found.");
		$smarty->display('error.tpl');
	}
	else
	{
		
		$schedule_data = $scenedb->get('schedule', ["[>]players" => "player_id"], ['player_name', 'player_id', 'schedule_title', 'schedule_desc', 'schedule_date'], ['schedule_id'=>$num]);
		
		$truetime = explode(" ",$schedule_data['schedule_date']);
		$hourminute = explode(":",$truetime[1]);
		$scene_time = $truetime[0].":".$truetime[1];
		
		$schedule = ['player_name'=>$schedule_data['player_name'],'date'=>$truetime[0],'id'=>$num,'title'=>$schedule_data['schedule_title'],'desc'=>$schedule_data['schedule_desc'],'time'=>$scene_time];
		
		$smarty->assign('schedule',$schedule);
		$smarty->display('schedule.tpl');
	}
	
?>