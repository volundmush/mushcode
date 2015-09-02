<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ascii-bin" />

<!-- Include all the global CSS files -->
<link rel="StyleSheet" href="ansi.css" type="text/css" />
<link rel="StyleSheet" href="scene.css" type="text/css" />
<link rel="alternate" href="scheduleRSS.php" title="Scene System Schedule Feed" type="application/rss+xml" />

<title><?php
	require 'ansi.php';
	require 'db.php';

	$num = ($_REQUEST['id']  ? $_REQUEST['id'] : $num );
	$ownerscenes = ( $_REQUEST['owner'] ? $_REQUEST['owner'] : $ownerscenes );

	function poseview($scene)
	{
		global $rownum, $posecount;
		echo "\n<tr class=\"$rownum\" id=\"".$scene['pose_id']." pose".($scene['pose_ignore']? ' ignore':'')."\">";
		$views = array(	 'order_id'   => $_REQUEST['showid']
						,'player_name' => '1'
						,'pose_time'  => $_REQUEST['showtime']
						,'pose'  => '1');
		foreach ($views as $view => $value)
		{
			if($value != false && $value != "false")
			echo "\n\t<td class=\"$view pose\">".ansi2html($scene[$view])."</td>";
		}
		echo "\n</tr>";
		$rownum = ($rownum == "even" ? "odd" : "even");
		$posecount++;
	}

	$errorquery = $scenedb->query("SELECT `scene_id` FROM `$db_prefix$db_scenes` WHERE scene_id='$num'");
	$errortest = $errorquery->num_rows;

	if(!$errortest)
	{
		$error = true;
		echo "SceneSys: Listing";
	}
	else
	{
		$error = false;
		echo "SceneSys: Scene #$num";
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
		/* The header */
		// echo '<center><img src="header-city.png" style="opacity:0.9;filter:alpha(opacity=90)"/></center>';

                $location = mysqli_fetch_array($scenedb->query("SELECT room_name FROM `$db_prefix$db_scenes` WHERE `scene_id`='$num'")) or die($scenedb->error);
                $location = $location[0];

		$title = mysqli_fetch_assoc($scenedb->query("SELECT * FROM `$db_prefix$db_scenes` WHERE scene_id='$num'")) or die($scenedb->error);
		echo '<table border="0" cellpadding="1" align="center" id="sceneheader">';
		echo '<tr><td><font size="5">'.( $title["scene_title"] ? "$title[scene_title]" : "No title.")."</font></td></tr>";
		echo '<tr><td>'." (".substr($title["creation_date"],0,10)." - ";
	    echo ( $title["finish_date"] && $title["finish_date"] !== "0000-00-00 00:00:00" ? 
			   substr($title["finish_date"],0,10).")":"Now)");
		echo '</td></tr>';
		echo '<tr><td width="400">'.( $title["scene_desc"] ? "$title[scene_desc]" : "No description.")."</td></tr>";
		echo "</table>";

		/* Scene pose views follow below */
		echo "\n<table border=\"0\" cellpadding=\"2\" cellspacing=\"3\" class=\"posetable\" id=\"posetable\" align=\"left\">";
		$rownum = even;
		$posecount = 0;
		$q = $scenedb->query("SELECT * FROM `$db_prefix$db_poses` NATURAL LEFT JOIN `$db_prefix$db_players` WHERE scene_id='$num' AND `pose_ignore`='0' ORDER BY `pose_id`") or die($scenedb->error);
		if(!$q)
			echo "Something went wrong!";
		while($scene = mysqli_fetch_array($q))
		{
			poseview($scene);
		}
		echo "\n</table>\n<!-- footer -->\n";
		echo "<div id=\"scene_info\">";
		/* Footer */
		echo "<br/>&nbsp;<br/>This scene contained $posecount poses.";
		$present = $scenedb->query("SELECT DISTINCT $db_prefix$db_players.player_id,$db_prefix$db_players.player_name FROM $db_prefix$db_players NATURAL LEFT JOIN $db_prefix$db_poses WHERE scene_id='$num' ORDER BY $db_prefix$db_players.player_id") or die($scenedb->error);
		$lastpresent = '';
		$open = false;
		$total = '';
		$poserids = '';
		$first = true;
		while($number = mysqli_fetch_array($present) )
		{
			$poserids .= "$number[player_id], ";
			if($number["player_id"]!=$lastpresent)
			{
				if($open)
					$total .= ')';
				if($first)
				{
					$first = false;
					$total = "$number[player_name]";;
				}
				else 
					$total .= ", $number[player_name]";
				$open = false;
			}
			else if(!$open)
			{
				$total .= " (Aka: $number[player_name]";
				$open = true;
			}
			else
				$total .= " &amp; $number[player_name]";
			$lastpresent = $number["player_id"];
		}
		$total = preg_replace('/,([^,]+)\./',", \\1",$total.($open?").":"."));
		$poserids = trim(trim($poserids),",");
		echo "&nbsp;The players who were present were: ".ansi2html($total)."<br>";
//		echo 'Click this link to go to the wiki-ready version of this log: <a target="_blank" href="view_wiki.php?id='.$num.'">link</a>.';

		$fullformat = "";

                $q = $scenedb->query("SELECT pose_id,$db_prefix$db_players.player_id,$db_prefix$db_players.player_name,pose FROM `$db_prefix$db_poses` LEFT JOIN `$db_prefix$db_players` ON $db_prefix$db_poses.player_id=$db_prefix$db_players.player_id WHERE scene_id='$num' AND `pose_ignore`='0' ORDER BY `pose_id`") or die($scenedb->error);
                if(!$q)
                     echo "Something went wrong!";
                while($scene = mysqli_fetch_array($q))
                {
			$scene_text = ansi2html($scene['pose']);
			$scene_text = preg_replace("/&/","&amp;", $scene_text);
			$scene_text = preg_replace("/<(.+?)>/","&lt;\\1&gt;",$scene_text);
                        $fullformat .= ":'''{{#var:".$scene['player_id']."|".$scene['player_name']." (".$scene['player_id'].")}} has posed:'''&lt;br&gt;".$scene_text."<br> <br>\n\n";
                }
                $fullformat = str_replace("\n\r","%0D%0A",$fullformat);
                $fullformat = str_replace('"','&quot;',$fullformat);

                ?>

		<form action="../mw/index.php/Special:FormEdit/Roleplaying Log/<?php echo $num.'/'.$title['scene_title'] ?>" method="POST">
		<input type="hidden" name="target" value="<?php echo $title['scene_title']?>">
		<input type="hidden" name="form" value="Roleplaying Log">
		<input type="hidden" name="Log Header[pretty]" value="yes">
		<input type="hidden" name="Log Header[Date of Scene]" value="<?php echo substr($title["creation_date"],0,10); ?>">
		<input type="hidden" name="Log Header[Location]" value="<?php echo $location; ?>">
		<input type="hidden" name="Log Header[Cast of Characters]" value="<?php echo $poserids; ?>">
		<input type="hidden" name="Log Header[Synopsis]" value="<?php echo preg_replace('/&/','&amp;',$title['scene_desc']); ?>">
		<input type="hidden" name="Poses[Poses]" value="<?php echo $fullformat; ?>">
		<?php
		if($title['scene_title']) {
            echo "<input id='logsubmit' type='submit' value='Submit Log to Wiki'>";
        }
	    else {
            echo "<input id='logsubmit' type='submit' value='No Scene Title' disabled>";
        }
		?>		
		</form>
		<?php
	}
	else
	{
		/*  THIS IS THE FULL SCENE LISTING  */
		include 'pagelisting.php';
	}
	echo "</div>";
?>
</body>
</html>