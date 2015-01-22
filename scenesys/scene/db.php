<?
	$username="your_username";  // We highly suggest the use of a SELECT PERMISSIONS only account.
	$password="some_password"; // This way, there is no security risk. SceneSys doesn't require more at this moment.
	$database="your_database";
	$site="example.com";
	$posecount = 0;

	$db_prefix = "scene_";
	$db_players = "players";
	$db_scenes = "scenes";
	$db_poses = "poses";
	$db_schedule = "schedule";
	
	$scenedb = new mysqli($site,$username,$password,$database);
	if ($scenedb->connect_errno)
	{
		echo "Failed to connect to MySQL: (" . $scenedb->connect_errno . ") " . $scenedb->connect_error;
	}
	
?>
