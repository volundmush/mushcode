<!DOCTYPE html>

<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<title>{block name=title}Default Title{/block}</title>
		<link rel="StyleSheet" href="styles/ansi.css" type="text/css" />
		<link rel="StyleSheet" href="styles/scene.css" type="text/css" />
		{block name=head}{/block}
	</head>

	<body>
		{block name=navBar}
		<nav id="navbar">
			<ul id="navlist">
				<li class="nav-item">
					<a class="nav-link" href="{$info.site}" title={$info.name}/>{$info.name}</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="index.php" title="Scenes"/>Scenes</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="calendar.php" title="Schedule"/>Schedule</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="about.php"title="About"/>About</a>
				</li>
			</ul>
		</nav>
		{/block}
		<main>
		{block name=contents}blah here{/block}
		</main>
		<footer>
		{block name=footer}footer here{/block}
		</footer>
	</body>
</html>