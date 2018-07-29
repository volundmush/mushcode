<?php
	$errorquery = $scenedb->query("SELECT `scene_id` FROM `$db_prefix$db_scenes` WHERE scene_id='$num'");
	$errortest = $errorquery->num_rows;

	if(!$errortest && $num)
	{
		/* In case we are coming here with an invalid scene number */
		?>
	        <div style="align:center; text-align:center; width:100%; background-color:red; opacity:0.5; border:2px solid black; border-radius:5px;">
        		Sorry, we could not find scene <?php echo $num ?>.
	        </div>
	        <?php
	}

	/* Function for showing the scene listing */
	function sceneview($scene,$ownername)
	{
		switch( $scene['scene_state'] )
		{
			case 0:
				$state='Active';
				break;
			case 1:
				$state='Paused';
				break;
			case 2:
				$state='Unfinished';
				break;
			case 3:
				$state='Finished';
				break;
		}
		echo '<tr class="'.$scene['scene_id'].'">';
		echo '<td class="sceneid">'.$scene['scene_id'].'</td>';
		echo '<td class="scenestate state_'.$state.'">'.$state.'</td>';
		echo '<td class="sceneowner"><a href="view.php?owner='.$scene['player_id'].'">'.str_replace(' ','&nbsp;',$ownername).'</a></td>';
		echo '<td class="scenetitle"><a href="view.php?id='.$scene['scene_id'].'">'.($scene['scene_title'] ? $scene['scene_title'] : 'No Title Set').'</a></td>';
		echo '<td class="scenedesc">'.ansi2html( ( $scene['scene_desc'] ? $scene['scene_desc'] : 'No Description Set' )).'</td>';
		echo '</tr>';
	}

	/* The actual Query */
	$q = $scenedb->query("SELECT * FROM `$db_prefix$db_scenes` ". ( $ownerscenes ? 'WHERE `player_id`="'.$ownerscenes.'"' : '' ). " ORDER BY `scene_id` DESC") or die($scenedb->error);
	if(!$q)
		echo "Something went wrong!";

	echo "\n<table border=\"0\" cellpadding=\"2\" cellspacing=\"3\" class=\"scenetable\" id=\"scenetable\" align=\"left\">";
	echo '<td class="sceneid">ID</td><td class="scenestate">State</td><td class="sceneowner">Owner</td><td class="scenetitle">Title</td><td class="scenedesc">Description</td>';

	while($scene = $q->fetch_array())
	{
		$ownername = $scenedb->query("SELECT `player_name` FROM `$db_prefix$db_players` WHERE `player_id`=\"".$scene['player_id']."\"");
		$getowner = $ownername->fetch_assoc();
		sceneview($scene,$getowner['player_name']);
	}

	echo "</table>"
?>
<br />
<br />
&nbsp;
