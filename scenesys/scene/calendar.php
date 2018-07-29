<?php 
	require 'libraries/base.php';

	function convert_scenes($today)
	{
		$format_scenes = array();
		foreach ($today as $scene)
		
				{
					$timesplit = explode(" ",$scene['scene_date_scheduled']);
					$timesplit = explode(":",$timesplit[1]);
					$starting_time = $timesplit[0].":".$timesplit[1];
					$format_scenes[] = ['id'=>$scene['scene_id'],'date'=>$starting_time,'owner'=>$scene['runner_name'],'title'=>$scene['scene_title']];
				}
		return $format_scenes;
	}

	function draw_calendar($month,$year)
	{
	  global $scenedb;

	  $running_day = date('w',mktime(0,0,0,$month,1,$year));
	  $days_in_month = date('t',mktime(0,0,0,$month,1,$year));
	  $days_in_this_week = 1;
	  $day_counter = 1;
	  $dates_array = array();
	  $calendar = array();

	  
	  for ($x = 1; $x < 36; $x++):
		if($x < $running_day+1 || $x > $days_in_month)
		{
			$calendar[$x] = ['num'=>False, 'scenes'=>False];
		}
		else
		{
			$today = $scenedb->select('volv_scene', ['runner_name', 'scene_date_scheduled', 'scene_title', 'scene_id'], ['scene_date_scheduled[<>]'=>[date("Y-m-d",mktime(0,0,0,$month,$day_counter,$year)),date("Y-m-d",mktime(0,0,0,$month,$day_counter+1,$year))], 'ORDER'=>['scene_date_scheduled']]);
			if($today)
			{
				$format_scenes = convert_scenes($today);
				$calendar[$x] = ['num'=>$day_counter,'scenes'=>$format_scenes];
			}
			else
			{
				$calendar[$x] = ['num'=>$day_counter,'scenes'=>False];
			}
			$day_counter++;
		}
	  endfor;
	  return $calendar;
	}
	
	$months = $scenedb->query("SELECT DISTINCT MONTH(scene_date_scheduled) AS mn,YEAR(scene_date_scheduled) AS yr FROM vol_scene where scene_date_scheduled>NOW() ORDER BY yr asc,mn asc")->fetchAll();
	
	$draw_months = array();
	
	foreach($months as $scenemonths) {
		$monthdata = DateTime::createFromFormat('!m', $scenemonths['mn']);
		$draw_months[] = ['header'=>[$monthdata->format('F'), $scenemonths['yr']], 'data'=>draw_calendar($scenemonths['mn'],$scenemonths['yr'])];
	}	
		
	$header = ['1'=>date('F, Y',mktime(0, 0, 0, date("m")+1, date("d"),   date("Y"))), '2'=>date('F, Y',mktime(0, 0, 0, date("m")+1, date("d"),   date("Y")))];
	
	$smarty->assign('header',$header);
	$smarty->assign('calendar',$draw_months);
	$smarty->display('templates/calendar.tpl');
?>
