<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html lang="en">
	<head>
		<meta charset="utf-8">
		<title>{block name=title}Default Title{/block}</title>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
		<link rel="StyleSheet" href="ansi.css" type="text/css" />
		<link rel="StyleSheet" href="scene.css" type="text/css" />
		<link rel="alternate" href="scheduleRSS.php" title="Scene System Schedule Feed" type="application/rss+xml" />
		{block name=head}{/block}
	</head>

	<body>
		{block name=header}
		<table id="sceneheader" align="center" cellspacing="3" cellpadding="3" >
			<tr>
				<td><a href="index.php"title="Scene Listing"/>Scene Listing</a></td>
				<td>||</td>
				<td><a href="calendar.php"title="Scene System Schedule"/>Scene Schedule</a></td>
				<td>||</td>
				<td><a rel="alternate" href="scheduleRSS.php" title="Scene System Schedule Feed" type="application/rss+xml" />Scene Schedule RSS</a></td>
			</tr>
		</table>
		{/block}
		{block name=contents}blah here{/block}
		{block name=footer}footer here{/block}
	</body>
</html>