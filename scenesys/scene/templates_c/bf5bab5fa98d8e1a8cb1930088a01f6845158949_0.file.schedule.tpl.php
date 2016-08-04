<?php
/* Smarty version 3.1.29, created on 2016-06-15 18:33:39
  from "/var/www/srwmush.com/scene/schedule.tpl" */

if ($_smarty_tpl->smarty->ext->_validateCompiled->decodeProperties($_smarty_tpl, array (
  'has_nocache_code' => false,
  'version' => '3.1.29',
  'unifunc' => 'content_5761d7c3aa8181_63250147',
  'file_dependency' => 
  array (
    'bf5bab5fa98d8e1a8cb1930088a01f6845158949' => 
    array (
      0 => '/var/www/srwmush.com/scene/schedule.tpl',
      1 => 1465970683,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
    'file:base.tpl' => 1,
  ),
),false)) {
function content_5761d7c3aa8181_63250147 ($_smarty_tpl) {
$_smarty_tpl->ext->_inheritance->init($_smarty_tpl, true);
?>

<?php 
$_smarty_tpl->ext->_inheritance->processBlock($_smarty_tpl, 0, 'title', array (
  0 => 'block_10856453285761d7c39ae698_80687289',
  1 => false,
  3 => 0,
  2 => 0,
));
?>

<?php 
$_smarty_tpl->ext->_inheritance->processBlock($_smarty_tpl, 0, 'head', array (
  0 => 'block_7296381945761d7c3a1c3b3_14081803',
  1 => false,
  3 => 0,
  2 => 0,
));
?>


<?php 
$_smarty_tpl->ext->_inheritance->processBlock($_smarty_tpl, 0, 'contents', array (
  0 => 'block_19526092235761d7c3a1dbb7_16295050',
  1 => false,
  3 => 0,
  2 => 0,
));
$_smarty_tpl->ext->_inheritance->endChild($_smarty_tpl);
$_smarty_tpl->smarty->ext->_subtemplate->render($_smarty_tpl, "file:base.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array(), 2, false);
}
/* {block 'title'}  file:schedule.tpl */
function block_10856453285761d7c39ae698_80687289($_smarty_tpl, $_blockParentStack) {
?>
Schedule #<?php echo $_smarty_tpl->tpl_vars['schedule']->value['id'];?>
: <?php echo $_smarty_tpl->tpl_vars['schedule']->value['title'];
}
/* {/block 'title'} */
/* {block 'head'}  file:schedule.tpl */
function block_7296381945761d7c3a1c3b3_14081803($_smarty_tpl, $_blockParentStack) {
?>
<link rel="StyleSheet" href="calendar.css" type="text/css" /><?php
}
/* {/block 'head'} */
/* {block 'contents'}  file:schedule.tpl */
function block_19526092235761d7c3a1dbb7_16295050($_smarty_tpl, $_blockParentStack) {
?>

<table border="0" cellpadding="1" align="center" id="scheduleheader">
	<tr>
		<th><?php echo $_smarty_tpl->tpl_vars['schedule']->value['player_name'];?>
 scheduled, <br>On <?php echo $_smarty_tpl->tpl_vars['schedule']->value['date'];?>
 at <?php echo $_smarty_tpl->tpl_vars['schedule']->value['time'];?>
<br/>
			 <font size="5">
			 <?php if ($_smarty_tpl->tpl_vars['schedule']->value['title']) {?>
				<?php echo $_smarty_tpl->tpl_vars['schedule']->value['title'];?>

			<?php } else { ?>
				No Title.
			<?php }?>
			</font>
		</th>
	</tr>
	<tr>
		<td width="400">
		<hr>
		<?php if ($_smarty_tpl->tpl_vars['schedule']->value['desc']) {?>
			<?php echo $_smarty_tpl->tpl_vars['schedule']->value['desc'];?>

		<?php } else { ?>
			No description.
		<?php }?>
		</td>
	</tr>
</table>
<?php
}
/* {/block 'contents'} */
}
