<?php 
	require 'base.php';
	$smarty = new Smarty;

	function convert_scenes($today)
	{
		$format_scenes = array();
		foreach ($today as $scene)
		
				{
					$timesplit = explode(" ",$scene['date_scheduled']);
					$timesplit = explode(":",$timesplit[1]);
					$starting_time = $timesplit[0].":".$timesplit[1];
					$format_scenes[] = ['id'=>$scene['scene_id'],'date'=>$starting_time,'owner'=>$scene['object_name'],'title'=>$scene['title']];
				}
		return $format_scenes;
	}

	function draw_calendar($month,$year)
	{
	  global $scenedb;

	  $running_day = date('w',mktime(0,0,0,$month,1,$year));
	  $days_in_month = date('t',mktime(0,0,0,$month,1,$year));
	  $day_counter = 1;
	  $calendar = array();

	  
	  for ($x = 1; $x < 36; $x++):
		if($x < $running_day+1 || $day_counter > $days_in_month)
		{
			$calendar[$x] = ['num'=>False, 'scenes'=>False];
		}
		else
		{
			$curday = sprintf('%s-%s-%s',$year,$month,$day_counter);
			$today = $scenedb->query(sprintf("SELECT t.object_name,s.date_scheduled,s.title,s.scene_id FROM mush_scene AS s LEFT JOIN mush_actor AS act ON act.scene_id=s.scene_id AND act.actor_type=2 LEFT JOIN mush_thing AS t ON t.thing_id=act.player_id WHERE DATE(s.date_scheduled)='%s'",$curday))->fetchAll();

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

	$cal1 = draw_calendar(date('m'),date('Y'));
	$cal2 = draw_calendar(date('m')+1,date('Y'));
		
	$header = ['1'=>date('F, Y',mktime(0, 0, 0, date("m"), date("d"),   date("Y"))), '2'=>date('F, Y',mktime(0, 0, 0, date("m")+1, date("d"),   date("Y")))];
	
	$smarty->assign('header',$header);
	$smarty->assign('cal1', $cal1);
	$smarty->assign('cal2', $cal2);
	$smarty->display('calendar.tpl');
?>
