<?php
/* Smarty version 3.1.29, created on 2016-06-15 04:37:34
  from "/var/www/srwmush.com/scene/listing.tpl" */

if ($_smarty_tpl->smarty->ext->_validateCompiled->decodeProperties($_smarty_tpl, array (
  'has_nocache_code' => false,
  'version' => '3.1.29',
  'unifunc' => 'content_576113cec59b39_28336674',
  'file_dependency' => 
  array (
    'e8b817b878095076393dc9837a45e460f34ed3d7' => 
    array (
      0 => '/var/www/srwmush.com/scene/listing.tpl',
      1 => 1462514694,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
    'file:base.tpl' => 1,
  ),
),false)) {
function content_576113cec59b39_28336674 ($_smarty_tpl) {
$_smarty_tpl->ext->_inheritance->init($_smarty_tpl, true);
?>

<?php 
$_smarty_tpl->ext->_inheritance->processBlock($_smarty_tpl, 0, 'title', array (
  0 => 'block_1788905649576113cec2be49_11886746',
  1 => false,
  3 => 0,
  2 => 0,
));
?>


<?php 
$_smarty_tpl->ext->_inheritance->processBlock($_smarty_tpl, 0, 'contents', array (
  0 => 'block_1291070762576113cec2e8c2_16419091',
  1 => false,
  3 => 0,
  2 => 0,
));
$_smarty_tpl->ext->_inheritance->endChild($_smarty_tpl);
$_smarty_tpl->smarty->ext->_subtemplate->render($_smarty_tpl, "file:base.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array(), 2, false);
}
/* {block 'title'}  file:listing.tpl */
function block_1788905649576113cec2be49_11886746($_smarty_tpl, $_blockParentStack) {
?>
SceneSys: Listing<?php
}
/* {/block 'title'} */
/* {block 'contents'}  file:listing.tpl */
function block_1291070762576113cec2e8c2_16419091($_smarty_tpl, $_blockParentStack) {
?>

<table id="scenetable" class="table table-bordered">
	<thead>
	<tr>
		<th class="scene_id_row">ID</th>
		<th class="scene_state_row">State</th>
		<th class="scene_owner_row">Owner</th>
		<th class="scene_title_row">Title</th>
		<th>Description</th>
	</tr>
	</thead>
	<tbody>
	<?php
$_from = $_smarty_tpl->tpl_vars['scenes']->value;
if (!is_array($_from) && !is_object($_from)) {
settype($_from, 'array');
}
$__foreach_scene_0_saved_item = isset($_smarty_tpl->tpl_vars['scene']) ? $_smarty_tpl->tpl_vars['scene'] : false;
$_smarty_tpl->tpl_vars['scene'] = new Smarty_Variable();
$_smarty_tpl->tpl_vars['scene']->_loop = false;
foreach ($_from as $_smarty_tpl->tpl_vars['scene']->value) {
$_smarty_tpl->tpl_vars['scene']->_loop = true;
$__foreach_scene_0_saved_local_item = $_smarty_tpl->tpl_vars['scene'];
?>
	<tr>
		<td><a href="scene.php?id=<?php echo $_smarty_tpl->tpl_vars['scene']->value['id'];?>
"><?php echo $_smarty_tpl->tpl_vars['scene']->value['id'];?>
</a></td>
		<td><?php echo $_smarty_tpl->tpl_vars['scene']->value['state'];?>
</td>
		<td><a href="owner.php?id=<?php echo $_smarty_tpl->tpl_vars['scene']->value['owner'];?>
"><?php echo $_smarty_tpl->tpl_vars['scene']->value['owner_name'];?>
</a></td>
		<td><a href="scene.php?id=<?php echo $_smarty_tpl->tpl_vars['scene']->value['id'];?>
"><?php echo $_smarty_tpl->tpl_vars['scene']->value['title'];?>
</a></td>
		<td><?php echo $_smarty_tpl->tpl_vars['scene']->value['description'];?>
</td>
	</tr>
	<?php
$_smarty_tpl->tpl_vars['scene'] = $__foreach_scene_0_saved_local_item;
}
if ($__foreach_scene_0_saved_item) {
$_smarty_tpl->tpl_vars['scene'] = $__foreach_scene_0_saved_item;
}
?>
	</table>
<?php
}
/* {/block 'contents'} */
}
