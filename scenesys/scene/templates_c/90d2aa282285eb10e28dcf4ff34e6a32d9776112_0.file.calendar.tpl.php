<?php
/* Smarty version 3.1.29, created on 2016-06-15 14:28:58
  from "/var/www/srwmush.com/scene/calendar.tpl" */

if ($_smarty_tpl->smarty->ext->_validateCompiled->decodeProperties($_smarty_tpl, array (
  'has_nocache_code' => false,
  'version' => '3.1.29',
  'unifunc' => 'content_57619e6ad9cf51_38319789',
  'file_dependency' => 
  array (
    '90d2aa282285eb10e28dcf4ff34e6a32d9776112' => 
    array (
      0 => '/var/www/srwmush.com/scene/calendar.tpl',
      1 => 1465979309,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
    'file:base.tpl' => 1,
  ),
),false)) {
function content_57619e6ad9cf51_38319789 ($_smarty_tpl) {
$_smarty_tpl->ext->_inheritance->init($_smarty_tpl, true);
?>

<?php 
$_smarty_tpl->ext->_inheritance->processBlock($_smarty_tpl, 0, 'title', array (
  0 => 'block_103722105457619e6acc8c71_28525432',
  1 => false,
  3 => 0,
  2 => 0,
));
?>

<?php 
$_smarty_tpl->ext->_inheritance->processBlock($_smarty_tpl, 0, 'head', array (
  0 => 'block_131695570257619e6acd43a8_93357489',
  1 => false,
  3 => 0,
  2 => 0,
));
?>


<?php 
$_smarty_tpl->ext->_inheritance->processBlock($_smarty_tpl, 0, 'contents', array (
  0 => 'block_23114505457619e6acd5fe7_00768612',
  1 => false,
  3 => 0,
  2 => 0,
));
?>

<?php $_smarty_tpl->ext->_inheritance->endChild($_smarty_tpl);
$_smarty_tpl->smarty->ext->_subtemplate->render($_smarty_tpl, "file:base.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array(), 2, false);
}
/* {block 'title'}  file:calendar.tpl */
function block_103722105457619e6acc8c71_28525432($_smarty_tpl, $_blockParentStack) {
?>
Scene Calendar<?php
}
/* {/block 'title'} */
/* {block 'head'}  file:calendar.tpl */
function block_131695570257619e6acd43a8_93357489($_smarty_tpl, $_blockParentStack) {
?>
<link rel="StyleSheet" href="calendar.css" type="text/css" /><?php
}
/* {/block 'head'} */
/* {block 'contents'}  file:calendar.tpl */
function block_23114505457619e6acd5fe7_00768612($_smarty_tpl, $_blockParentStack) {
?>

<h1><center><?php echo $_smarty_tpl->tpl_vars['header']->value[1];?>
</center></h1>
<table cellpadding="0" cellspacing="0" class="calendar">
	<tr class="calendar-row">
		<td class="calendar-day-head">Sunday</td>
		<td class="calendar-day-head">Monday</td>
		<td class="calendar-day-head">Tuesday</td>
		<td class="calendar-day-head">Wednesday</td>
		<td class="calendar-day-head">Thursday</td>
		<td class="calendar-day-head">Friday</td>
		<td class="calendar-day-head">Saturday</td>
	</tr>
	<?php
$_from = $_smarty_tpl->tpl_vars['cal1']->value;
if (!is_array($_from) && !is_object($_from)) {
settype($_from, 'array');
}
$__foreach_schedule_0_saved_item = isset($_smarty_tpl->tpl_vars['schedule']) ? $_smarty_tpl->tpl_vars['schedule'] : false;
$__foreach_schedule_0_saved_key = isset($_smarty_tpl->tpl_vars['day']) ? $_smarty_tpl->tpl_vars['day'] : false;
$_smarty_tpl->tpl_vars['schedule'] = new Smarty_Variable();
$_smarty_tpl->tpl_vars['day'] = new Smarty_Variable();
$_smarty_tpl->tpl_vars['schedule']->_loop = false;
foreach ($_from as $_smarty_tpl->tpl_vars['day']->value => $_smarty_tpl->tpl_vars['schedule']->value) {
$_smarty_tpl->tpl_vars['schedule']->_loop = true;
$__foreach_schedule_0_saved_local_item = $_smarty_tpl->tpl_vars['schedule'];
?>
		<?php if ($_smarty_tpl->tpl_vars['day']->value == 1 || $_smarty_tpl->tpl_vars['day']->value == 8 || $_smarty_tpl->tpl_vars['day']->value == 15 || $_smarty_tpl->tpl_vars['day']->value == 22 || $_smarty_tpl->tpl_vars['day']->value == 29) {?>
			<tr class="calendar-row">
		<?php }?>
		<?php if ($_smarty_tpl->tpl_vars['schedule']->value) {?>
			<td class="calendar-day">
			<div class="day-number"><?php echo $_smarty_tpl->tpl_vars['schedule']->value['num'];?>
</div>
			<?php if ($_smarty_tpl->tpl_vars['schedule']->value['scenes']) {?>
				<table class=CalendarItems>
				<?php
$_from = $_smarty_tpl->tpl_vars['schedule']->value['scenes'];
if (!is_array($_from) && !is_object($_from)) {
settype($_from, 'array');
}
$__foreach_scene_1_saved_item = isset($_smarty_tpl->tpl_vars['scene']) ? $_smarty_tpl->tpl_vars['scene'] : false;
$_smarty_tpl->tpl_vars['scene'] = new Smarty_Variable();
$_smarty_tpl->tpl_vars['scene']->_loop = false;
foreach ($_from as $_smarty_tpl->tpl_vars['scene']->value) {
$_smarty_tpl->tpl_vars['scene']->_loop = true;
$__foreach_scene_1_saved_local_item = $_smarty_tpl->tpl_vars['scene'];
?>
					<tr><td><?php echo $_smarty_tpl->tpl_vars['scene']->value['date'];?>
 - <?php echo $_smarty_tpl->tpl_vars['scene']->value['owner'];?>
<br/>
					<a href="schedule.php?id=<?php echo $_smarty_tpl->tpl_vars['scene']->value['id'];?>
"><?php echo $_smarty_tpl->tpl_vars['scene']->value['title'];?>
</a>
					</td></tr>
				<?php
$_smarty_tpl->tpl_vars['scene'] = $__foreach_scene_1_saved_local_item;
}
if ($__foreach_scene_1_saved_item) {
$_smarty_tpl->tpl_vars['scene'] = $__foreach_scene_1_saved_item;
}
?>
				</table>
			<?php } else { ?>
				<p>&nbsp;</p><p>&nbsp;</p>
			<?php }?>
		<?php } else { ?>
			<td class="calendar-day-np">&nbsp;</td>
		<?php }?>
		<?php if ($_smarty_tpl->tpl_vars['day']->value%7 == 0) {?>
			</tr>
		<?php }?>
	<?php
$_smarty_tpl->tpl_vars['schedule'] = $__foreach_schedule_0_saved_local_item;
}
if ($__foreach_schedule_0_saved_item) {
$_smarty_tpl->tpl_vars['schedule'] = $__foreach_schedule_0_saved_item;
}
if ($__foreach_schedule_0_saved_key) {
$_smarty_tpl->tpl_vars['day'] = $__foreach_schedule_0_saved_key;
}
?>
</table>

<h1><center><?php echo $_smarty_tpl->tpl_vars['header']->value[2];?>
</center></h1>
<table cellpadding="0" cellspacing="0" class="calendar">
	<tr class="calendar-row">
		<td class="calendar-day-head">Sunday</td>
		<td class="calendar-day-head">Monday</td>
		<td class="calendar-day-head">Tuesday</td>
		<td class="calendar-day-head">Wednesday</td>
		<td class="calendar-day-head">Thursday</td>
		<td class="calendar-day-head">Friday</td>
		<td class="calendar-day-head">Saturday</td>
	</tr>
	<?php
$_from = $_smarty_tpl->tpl_vars['cal2']->value;
if (!is_array($_from) && !is_object($_from)) {
settype($_from, 'array');
}
$__foreach_schedule_2_saved_item = isset($_smarty_tpl->tpl_vars['schedule']) ? $_smarty_tpl->tpl_vars['schedule'] : false;
$__foreach_schedule_2_saved_key = isset($_smarty_tpl->tpl_vars['day']) ? $_smarty_tpl->tpl_vars['day'] : false;
$_smarty_tpl->tpl_vars['schedule'] = new Smarty_Variable();
$_smarty_tpl->tpl_vars['day'] = new Smarty_Variable();
$_smarty_tpl->tpl_vars['schedule']->_loop = false;
foreach ($_from as $_smarty_tpl->tpl_vars['day']->value => $_smarty_tpl->tpl_vars['schedule']->value) {
$_smarty_tpl->tpl_vars['schedule']->_loop = true;
$__foreach_schedule_2_saved_local_item = $_smarty_tpl->tpl_vars['schedule'];
?>
		<?php if ($_smarty_tpl->tpl_vars['day']->value == 1 || $_smarty_tpl->tpl_vars['day']->value == 8 || $_smarty_tpl->tpl_vars['day']->value == 15 || $_smarty_tpl->tpl_vars['day']->value == 22 || $_smarty_tpl->tpl_vars['day']->value == 29) {?>
			<tr class="calendar-row">
		<?php }?>
		<?php if ($_smarty_tpl->tpl_vars['schedule']->value) {?>
			<td class="calendar-day">
			<div class="day-number"><?php echo $_smarty_tpl->tpl_vars['schedule']->value['num'];?>
</div>
			<?php if ($_smarty_tpl->tpl_vars['schedule']->value['scenes']) {?>
				<table class=CalendarItems>
				<?php
$_from = $_smarty_tpl->tpl_vars['schedule']->value['scenes'];
if (!is_array($_from) && !is_object($_from)) {
settype($_from, 'array');
}
$__foreach_scene_3_saved_item = isset($_smarty_tpl->tpl_vars['scene']) ? $_smarty_tpl->tpl_vars['scene'] : false;
$_smarty_tpl->tpl_vars['scene'] = new Smarty_Variable();
$_smarty_tpl->tpl_vars['scene']->_loop = false;
foreach ($_from as $_smarty_tpl->tpl_vars['scene']->value) {
$_smarty_tpl->tpl_vars['scene']->_loop = true;
$__foreach_scene_3_saved_local_item = $_smarty_tpl->tpl_vars['scene'];
?>
					<tr><td><?php echo $_smarty_tpl->tpl_vars['scene']->value['date'];?>
 - <?php echo $_smarty_tpl->tpl_vars['scene']->value['owner'];?>
<br/>
					<a href="schedule.php?id=<?php echo $_smarty_tpl->tpl_vars['scene']->value['id'];?>
"><?php echo $_smarty_tpl->tpl_vars['scene']->value['title'];?>
</a>
					</td></tr>
				<?php
$_smarty_tpl->tpl_vars['scene'] = $__foreach_scene_3_saved_local_item;
}
if ($__foreach_scene_3_saved_item) {
$_smarty_tpl->tpl_vars['scene'] = $__foreach_scene_3_saved_item;
}
?>
				</table>
			<?php } else { ?>
				<p>&nbsp;</p><p>&nbsp;</p>
			<?php }?>
		<?php } else { ?>
			<td class="calendar-day-np">&nbsp;</td>
		<?php }?>
		<?php if ($_smarty_tpl->tpl_vars['day']->value%7 == 0) {?>
			</tr>
		<?php }?>
	<?php
$_smarty_tpl->tpl_vars['schedule'] = $__foreach_schedule_2_saved_local_item;
}
if ($__foreach_schedule_2_saved_item) {
$_smarty_tpl->tpl_vars['schedule'] = $__foreach_schedule_2_saved_item;
}
if ($__foreach_schedule_2_saved_key) {
$_smarty_tpl->tpl_vars['day'] = $__foreach_schedule_2_saved_key;
}
?>
</table>
<?php
}
/* {/block 'contents'} */
}
