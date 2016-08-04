<?php
/* Smarty version 3.1.29, created on 2016-05-06 02:05:07
  from "/var/www/srwmush.com/scene2/listing.tpl" */

if ($_smarty_tpl->smarty->ext->_validateCompiled->decodeProperties($_smarty_tpl, array (
  'has_nocache_code' => false,
  'version' => '3.1.29',
  'unifunc' => 'content_572c3413106bd8_04073827',
  'file_dependency' => 
  array (
    '97b2f86f7f6b7a562395c2af0d8f4a36a006d6b9' => 
    array (
      0 => '/var/www/srwmush.com/scene2/listing.tpl',
      1 => 1462514694,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
    'file:base.tpl' => 1,
  ),
),false)) {
function content_572c3413106bd8_04073827 ($_smarty_tpl) {
$_smarty_tpl->ext->_inheritance->init($_smarty_tpl, true);
?>

<?php 
$_smarty_tpl->ext->_inheritance->processBlock($_smarty_tpl, 0, 'title', array (
  0 => 'block_1401433203572c34130d7538_39404612',
  1 => false,
  3 => 0,
  2 => 0,
));
?>


<?php 
$_smarty_tpl->ext->_inheritance->processBlock($_smarty_tpl, 0, 'contents', array (
  0 => 'block_715145450572c34130e3e62_55104016',
  1 => false,
  3 => 0,
  2 => 0,
));
$_smarty_tpl->ext->_inheritance->endChild($_smarty_tpl);
$_smarty_tpl->smarty->ext->_subtemplate->render($_smarty_tpl, "file:base.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array(), 2, false);
}
/* {block 'title'}  file:listing.tpl */
function block_1401433203572c34130d7538_39404612($_smarty_tpl, $_blockParentStack) {
?>
SceneSys: Listing<?php
}
/* {/block 'title'} */
/* {block 'contents'}  file:listing.tpl */
function block_715145450572c34130e3e62_55104016($_smarty_tpl, $_blockParentStack) {
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
