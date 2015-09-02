<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<!-- Include all the global CSS files -->
<link rel="StyleSheet" href="ansi.css" type="text/css" />
<link rel="StyleSheet" href="calendar.css" type="text/css" />
<link rel="StyleSheet" href="scene.css" type="text/css" />
<link rel="alternate" href="scheduleRSS.php" title="Scene System Schedule Feed" type="application/rss+xml" />
<title><?php 
	require 'ansi.php';
	require 'db.php';

	$num = ($_REQUEST['id']  ? $_REQUEST['id'] : $num );

	function scheduleview($schedule)
	{
		$truetime = explode(" ",$schedule['schedule_date']);
		$hourminute = explode(":",$truetime[1]);

		echo '<table border="0" cellpadding="1" align="center" id="scheduleheader">'."\n";
		echo '<tr><th>'.$schedule['player_name']." scheduled, <br>".
			 "On ".$truetime[0].
		         " at ". $hourminute[0].":".$hourminute[1]."<br/>".
			 '<font size="5">'.( $schedule["schedule_title"] ? "$schedule[schedule_title]" : "No title.")."</font></th></tr>";
		echo '<tr><td width="400"><hr>'.( $schedule["schedule_desc"] ? ansi2html($schedule['schedule_desc']) : "No description.")."</td></tr>\n";
		echo "</table>";
	}
	/* draws a calendar */
	function draw_calendar($month,$year){
	  global $scenedb;
	  global $db_prefix;
	  global $db_schedule;
	  global $db_players;
	  /* draw table */
	  $calendar = '<table cellpadding="0" cellspacing="0" class="calendar">';

	  /* table headings */
	  $headings = array('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday');
	  $calendar.= '<tr class="calendar-row"><td class="calendar-day-head">'.implode('</td><td class="calendar-day-head">',$headings).'</td></tr>';

	  /* days and weeks vars now ... */
	  $running_day = date('w',mktime(0,0,0,$month,1,$year));
	  $days_in_month = date('t',mktime(0,0,0,$month,1,$year));
	  $days_in_this_week = 1;
	  $day_counter = 0;
	  $dates_array = array();
	  
	  /* row for week one */
	  $calendar.= '<tr class="calendar-row">';
	
	  /* print "blank" days until the first of the current week */
	  for($x = 0; $x < $running_day; $x++):
		$calendar.= '<td class="calendar-day-np">&nbsp;</td>';
		$days_in_this_week++;
	  endfor;

	  /* keep going with days.... */
	  for($list_day = 1; $list_day <= $days_in_month; $list_day++):
		$calendar.= '<td class="calendar-day'.(($list_day == date('d') && $month == date('m') && $year == date('Y'))?' current-day':'').'">';
		  /* add in the day number */
		  $calendar.= '<div class="day-number">'.$list_day.'</div>';

		  /** QUERY THE DATABASE FOR AN ENTRY FOR THIS DAY !!  IF MATCHES FOUND, PRINT THEM !! **/
		  $q = $scenedb->query("SELECT * FROM `$db_prefix$db_schedule` WHERE DATE(`schedule_date`)='$year-$month-$list_day'") or die($scenedb->error);
		  if(!$q)
			echo "Something went wrong!";
		  if($q->num_rows)
		  {
			
			$calendar.= "<table class=CalendarItems>";
			$q = $scenedb->query("SELECT * FROM `$db_prefix$db_schedule` NATURAL LEFT JOIN `$db_prefix$db_players` WHERE DATE(`schedule_date`)='$year-$month-$list_day' ORDER BY `schedule_date` ASC") or die($scenedb->error);
			while($scheduleitem = mysqli_fetch_array($q))
			{
				$truetime = explode(" ",$scheduleitem['schedule_date']);
				$hourminute = explode(":",$truetime[1]);
				$calendar.= "<tr><td>".$hourminute[0].":".$hourminute[1]." - ".$scheduleitem['player_name']."<br/>";
				$calendar.= "<a href=\"http://".$_SERVER['HTTP_HOST']."/scene/schedule.php?id=".$scheduleitem['schedule_id']."\">".$scheduleitem['schedule_title']."</a></td></tr>";
			}
			$calendar.= "</table>";
		  }
		  else
		  {
			 $calendar.='<p>&nbsp;</p><p>&nbsp;</p>';
		  }

		$calendar.= '</td>';
		if($running_day == 6):
		  $calendar.= '</tr>';
		  if(($day_counter+1) != $days_in_month):
			$calendar.= '<tr class="calendar-row">';
		  endif;
		  $running_day = -1;
		  $days_in_this_week = 0;
		endif;
		$days_in_this_week++; $running_day++; $day_counter++;
	  endfor;

	  /* finish the rest of the days in the week */
	  if($days_in_this_week < 8):
		for($x = 1; $x <= (8 - $days_in_this_week); $x++):
		  $calendar.= '<td class="calendar-day-np">&nbsp;</td>';
		endfor;
	  endif;

	  /* final row */
	  $calendar.= '</tr>';

	  /* end the table */
	  $calendar.= '</table>';

	  /* all done, return result */
	  return $calendar;
	}
	$errorquery = $scenedb->query("SELECT `schedule_title` FROM `$db_prefix$db_schedule` WHERE schedule_id='$num'") or die($scenedb->error);
	$errortest = $errorquery->fetch_row();
	if(!$errortest)
	{
		$error = true;	
		echo "Schedule List";
	}
	else
	{
		$error = false;
		echo "[#$num]: $errortest[0]";
	}
?>
</title>
</head>
<!-- Main body starts here -->
<body>
	<table id="sceneheader" align="center" cellspacing="3" cellpadding="3" >
    	<tr>
        	<td><a href="view.php"title="Scene Listing"/>Scene Listing</a></td>
            <td>||</td>
        	<td><a href="schedule.php"title="Scene System Schedule"/>Scene Schedule</a></td>
            <td>||</td>
            <td><a rel="alternate" href="scheduleRSS.php" title="Scene System Schedule Feed" type="application/rss+xml" />Scene Schedule RSS</a></td>
        </tr>
    </table>
    <?php

	if(!$error)
	{
		$q = $scenedb->query("SELECT * FROM `$db_prefix$db_schedule` NATURAL LEFT JOIN `$db_prefix$db_players` WHERE schedule_id='$num'") or die($scenedb->error);
		if(!$q)
			echo "Something went wrong!";
		while($schedule = mysqli_fetch_array($q))
		{
			scheduleview($schedule);
		}
	}
	else
	{
		/* $q = mysql_query("SELECT * FROM `scene_schedule` WHERE `time` >= DATE_SUB(NOW(),INTERVAL 1 DAY)") or die(mysql_error());
		if(!$q)
			echo "Something went wrong!";
		while($schedule = mysql_fetch_array($q))
		{
			scheduleview($schedule);
			echo "<br>";
		} */
	echo "<h1><center>".date('F, Y')."</center></h1>";
	echo draw_calendar(date('m'),date('Y'));

	echo "<h1><center>".date('F, Y',mktime(0, 0, 0, date("m")+1, date("d"),   date("Y")))."</center></h1>";
	echo draw_calendar(date('m')+1,date('Y'));
	}

    ?>
</body>
</html>
