<?php
/* Smarty version 3.1.29, created on 2016-06-15 04:37:17
  from "/var/www/srwmush.com/scene/base.tpl" */

if ($_smarty_tpl->smarty->ext->_validateCompiled->decodeProperties($_smarty_tpl, array (
  'has_nocache_code' => false,
  'version' => '3.1.29',
  'unifunc' => 'content_576113bd110a74_99746160',
  'file_dependency' => 
  array (
    'e46ec88e65a78207295f426f1b33e986ec9935d9' => 
    array (
      0 => '/var/www/srwmush.com/scene/base.tpl',
      1 => 1465979366,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_576113bd110a74_99746160 ($_smarty_tpl) {
$_smarty_tpl->ext->_inheritance->init($_smarty_tpl, false);
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html lang="en">
	<head>
		<meta charset="utf-8">
		<title><?php 
$_smarty_tpl->ext->_inheritance->processBlock($_smarty_tpl, 0, 'title', array (
  0 => 'block_397212705576113bd109c58_55903615',
  1 => false,
  3 => 0,
  2 => 0,
));
?>
</title>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
		<link rel="StyleSheet" href="ansi.css" type="text/css" />
		<link rel="StyleSheet" href="scene.css" type="text/css" />
		<link rel="alternate" href="scheduleRSS.php" title="Scene System Schedule Feed" type="application/rss+xml" />
		<?php 
$_smarty_tpl->ext->_inheritance->processBlock($_smarty_tpl, 0, 'head', array (
  0 => 'block_910894076576113bd10b748_60422901',
  1 => false,
  3 => 0,
  2 => 0,
));
?>

	</head>

	<body>
		<?php 
$_smarty_tpl->ext->_inheritance->processBlock($_smarty_tpl, 0, 'header', array (
  0 => 'block_1177726352576113bd10cba8_78449610',
  1 => false,
  3 => 0,
  2 => 0,
));
?>

		<?php 
$_smarty_tpl->ext->_inheritance->processBlock($_smarty_tpl, 0, 'contents', array (
  0 => 'block_1824075198576113bd10e265_57840573',
  1 => false,
  3 => 0,
  2 => 0,
));
?>

		<?php 
$_smarty_tpl->ext->_inheritance->processBlock($_smarty_tpl, 0, 'footer', array (
  0 => 'block_1260453619576113bd10f892_76030356',
  1 => false,
  3 => 0,
  2 => 0,
));
?>

	</body>
</html><?php }
/* {block 'title'}  file:base.tpl */
function block_397212705576113bd109c58_55903615($_smarty_tpl, $_blockParentStack) {
?>
Default Title<?php
}
/* {/block 'title'} */
/* {block 'head'}  file:base.tpl */
function block_910894076576113bd10b748_60422901($_smarty_tpl, $_blockParentStack) {
}
/* {/block 'head'} */
/* {block 'header'}  file:base.tpl */
function block_1177726352576113bd10cba8_78449610($_smarty_tpl, $_blockParentStack) {
?>

		<table id="sceneheader" align="center" cellspacing="3" cellpadding="3" >
			<tr>
				<td><a href="index.php"title="Scene Listing"/>Scene Listing</a></td>
				<td>||</td>
				<td><a href="calendar.php"title="Scene System Schedule"/>Scene Schedule</a></td>
				<td>||</td>
				<td><a rel="alternate" href="scheduleRSS.php" title="Scene System Schedule Feed" type="application/rss+xml" />Scene Schedule RSS</a></td>
			</tr>
		</table>
		<?php
}
/* {/block 'header'} */
/* {block 'contents'}  file:base.tpl */
function block_1824075198576113bd10e265_57840573($_smarty_tpl, $_blockParentStack) {
?>
blah here<?php
}
/* {/block 'contents'} */
/* {block 'footer'}  file:base.tpl */
function block_1260453619576113bd10f892_76030356($_smarty_tpl, $_blockParentStack) {
?>
footer here<?php
}
/* {/block 'footer'} */
}
