<?php
/* Smarty version 3.1.29, created on 2016-06-15 02:12:03
  from "/var/www/srwmush.com/scene2/schedule.tpl" */

if ($_smarty_tpl->smarty->ext->_validateCompiled->decodeProperties($_smarty_tpl, array (
  'has_nocache_code' => false,
  'version' => '3.1.29',
  'unifunc' => 'content_5760f1b3ddef16_97054120',
  'file_dependency' => 
  array (
    '9873fb7064cd5dba624bc7c049161cdb91fedac7' => 
    array (
      0 => '/var/www/srwmush.com/scene2/schedule.tpl',
      1 => 1465970683,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
    'file:base.tpl' => 1,
  ),
),false)) {
function content_5760f1b3ddef16_97054120 ($_smarty_tpl) {
$_smarty_tpl->ext->_inheritance->init($_smarty_tpl, true);
?>

<?php 
$_smarty_tpl->ext->_inheritance->processBlock($_smarty_tpl, 0, 'title', array (
  0 => 'block_4679062855760f1b3d87273_16064671',
  1 => false,
  3 => 0,
  2 => 0,
));
?>

<?php 
$_smarty_tpl->ext->_inheritance->processBlock($_smarty_tpl, 0, 'head', array (
  0 => 'block_10741389545760f1b3dcd4b2_97995778',
  1 => false,
  3 => 0,
  2 => 0,
));
?>


<?php 
$_smarty_tpl->ext->_inheritance->processBlock($_smarty_tpl, 0, 'contents', array (
  0 => 'block_1542718435760f1b3dcec59_74792208',
  1 => false,
  3 => 0,
  2 => 0,
));
$_smarty_tpl->ext->_inheritance->endChild($_smarty_tpl);
$_smarty_tpl->smarty->ext->_subtemplate->render($_smarty_tpl, "file:base.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array(), 2, false);
}
/* {block 'title'}  file:schedule.tpl */
function block_4679062855760f1b3d87273_16064671($_smarty_tpl, $_blockParentStack) {
?>
Schedule #<?php echo $_smarty_tpl->tpl_vars['schedule']->value['id'];?>
: <?php echo $_smarty_tpl->tpl_vars['schedule']->value['title'];
}
/* {/block 'title'} */
/* {block 'head'}  file:schedule.tpl */
function block_10741389545760f1b3dcd4b2_97995778($_smarty_tpl, $_blockParentStack) {
?>
<link rel="StyleSheet" href="calendar.css" type="text/css" /><?php
}
/* {/block 'head'} */
/* {block 'contents'}  file:schedule.tpl */
function block_1542718435760f1b3dcec59_74792208($_smarty_tpl, $_blockParentStack) {
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
