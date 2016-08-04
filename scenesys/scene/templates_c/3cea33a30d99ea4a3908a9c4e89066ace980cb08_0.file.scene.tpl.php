<?php
/* Smarty version 3.1.29, created on 2016-06-15 04:37:17
  from "/var/www/srwmush.com/scene/scene.tpl" */

if ($_smarty_tpl->smarty->ext->_validateCompiled->decodeProperties($_smarty_tpl, array (
  'has_nocache_code' => false,
  'version' => '3.1.29',
  'unifunc' => 'content_576113bd04dee4_11169115',
  'file_dependency' => 
  array (
    '3cea33a30d99ea4a3908a9c4e89066ace980cb08' => 
    array (
      0 => '/var/www/srwmush.com/scene/scene.tpl',
      1 => 1465965334,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
    'file:base.tpl' => 1,
  ),
),false)) {
function content_576113bd04dee4_11169115 ($_smarty_tpl) {
$_smarty_tpl->ext->_inheritance->init($_smarty_tpl, true);
?>

<?php 
$_smarty_tpl->ext->_inheritance->processBlock($_smarty_tpl, 0, 'title', array (
  0 => 'block_54178201576113bcda2a78_77076896',
  1 => false,
  3 => 0,
  2 => 0,
));
?>


<?php 
$_smarty_tpl->ext->_inheritance->processBlock($_smarty_tpl, 0, 'contents', array (
  0 => 'block_141531693576113bcde1a73_81915764',
  1 => false,
  3 => 0,
  2 => 0,
));
?>


<?php 
$_smarty_tpl->ext->_inheritance->processBlock($_smarty_tpl, 0, 'footer', array (
  0 => 'block_1453010202576113bce732a0_51261760',
  1 => false,
  3 => 0,
  2 => 0,
));
$_smarty_tpl->ext->_inheritance->endChild($_smarty_tpl);
$_smarty_tpl->smarty->ext->_subtemplate->render($_smarty_tpl, "file:base.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array(), 2, false);
}
/* {block 'title'}  file:scene.tpl */
function block_54178201576113bcda2a78_77076896($_smarty_tpl, $_blockParentStack) {
?>
Scene #<?php echo $_smarty_tpl->tpl_vars['scene']->value['id'];?>
: <?php echo $_smarty_tpl->tpl_vars['scene']->value['title'];
}
/* {/block 'title'} */
/* {block 'contents'}  file:scene.tpl */
function block_141531693576113bcde1a73_81915764($_smarty_tpl, $_blockParentStack) {
?>

<table id="posetable" class="table table-bordered">
	<thead>
	<tr>
		<th class="scene_poser_row">Owner</th>
		<th class="scene_pose_row">Pose</th>
	</tr>
	</thead>
	<tbody>
	<?php
$_from = $_smarty_tpl->tpl_vars['poses']->value;
if (!is_array($_from) && !is_object($_from)) {
settype($_from, 'array');
}
$__foreach_pose_0_saved_item = isset($_smarty_tpl->tpl_vars['pose']) ? $_smarty_tpl->tpl_vars['pose'] : false;
$_smarty_tpl->tpl_vars['pose'] = new Smarty_Variable();
$_smarty_tpl->tpl_vars['pose']->_loop = false;
foreach ($_from as $_smarty_tpl->tpl_vars['pose']->value) {
$_smarty_tpl->tpl_vars['pose']->_loop = true;
$__foreach_pose_0_saved_local_item = $_smarty_tpl->tpl_vars['pose'];
?>
	<tr class='pose'>
		<td><a href="owner.php?id=<?php echo $_smarty_tpl->tpl_vars['pose']->value['owner'];?>
"><?php echo $_smarty_tpl->tpl_vars['pose']->value['owner_name'];?>
</a></td>
		<td><?php echo $_smarty_tpl->tpl_vars['pose']->value['text'];?>
</td>
	</tr>
	<?php
$_smarty_tpl->tpl_vars['pose'] = $__foreach_pose_0_saved_local_item;
}
if ($__foreach_pose_0_saved_item) {
$_smarty_tpl->tpl_vars['pose'] = $__foreach_pose_0_saved_item;
}
?>
	</table>
<?php
}
/* {/block 'contents'} */
/* {block 'footer'}  file:scene.tpl */
function block_1453010202576113bce732a0_51261760($_smarty_tpl, $_blockParentStack) {
?>

<form action="<?php echo $_smarty_tpl->tpl_vars['scene']->value['url'];
echo $_smarty_tpl->tpl_vars['scene']->value['id'];?>
/<?php echo $_smarty_tpl->tpl_vars['scene']->value['title'];?>
" method="POST">
<input type="hidden" name="target" value="<?php echo $_smarty_tpl->tpl_vars['scene']->value['title'];?>
">
<input type="hidden" name="form" value="Roleplaying Log">
<input type="hidden" name="Log Header[pretty]" value="yes">
<input type="hidden" name="Log Header[Date of Scene]" value="<?php echo $_smarty_tpl->tpl_vars['scene']->value['creation_date'];?>
">
<input type="hidden" name="Log Header[Location]" value="<?php echo $_smarty_tpl->tpl_vars['scene']->value['location'];?>
">
<input type="hidden" name="Log Header[Cast of Characters]" value="<?php echo $_smarty_tpl->tpl_vars['scene']->value['poser_ids'];?>
">
<input type="hidden" name="Log Header[Synopsis]" value="<?php echo $_smarty_tpl->tpl_vars['scene']->value['description'];?>
">
<input type="hidden" name="Poses[Poses]" value="<?php echo $_smarty_tpl->tpl_vars['scene']->value['formatted_poses'];?>
">
<?php if ($_smarty_tpl->tpl_vars['scene']->value['title']) {?>
	<input id='logsubmit' type='submit' value='Submit Log to Wiki'>
<?php } else { ?>
	<input id='logsubmit' type='submit' value='No Scene Title' disabled>
<?php }?>
</form>
<?php
}
/* {/block 'footer'} */
}
