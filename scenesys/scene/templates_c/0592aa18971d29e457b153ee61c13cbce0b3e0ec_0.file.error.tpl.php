<?php
/* Smarty version 3.1.29, created on 2016-06-15 14:28:52
  from "/var/www/srwmush.com/scene/error.tpl" */

if ($_smarty_tpl->smarty->ext->_validateCompiled->decodeProperties($_smarty_tpl, array (
  'has_nocache_code' => false,
  'version' => '3.1.29',
  'unifunc' => 'content_57619e64a79441_43237563',
  'file_dependency' => 
  array (
    '0592aa18971d29e457b153ee61c13cbce0b3e0ec' => 
    array (
      0 => '/var/www/srwmush.com/scene/error.tpl',
      1 => 1462515528,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
    'file:base.tpl' => 1,
  ),
),false)) {
function content_57619e64a79441_43237563 ($_smarty_tpl) {
$_smarty_tpl->ext->_inheritance->init($_smarty_tpl, true);
?>

<?php 
$_smarty_tpl->ext->_inheritance->processBlock($_smarty_tpl, 0, 'title', array (
  0 => 'block_22102144857619e64a31184_73397377',
  1 => false,
  3 => 0,
  2 => 0,
));
?>


<?php 
$_smarty_tpl->ext->_inheritance->processBlock($_smarty_tpl, 0, 'contents', array (
  0 => 'block_101668392557619e64a34029_62760796',
  1 => false,
  3 => 0,
  2 => 0,
));
$_smarty_tpl->ext->_inheritance->endChild($_smarty_tpl);
$_smarty_tpl->smarty->ext->_subtemplate->render($_smarty_tpl, "file:base.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array(), 2, false);
}
/* {block 'title'}  file:error.tpl */
function block_22102144857619e64a31184_73397377($_smarty_tpl, $_blockParentStack) {
?>
SceneSys: Error<?php
}
/* {/block 'title'} */
/* {block 'contents'}  file:error.tpl */
function block_101668392557619e64a34029_62760796($_smarty_tpl, $_blockParentStack) {
?>
 An error occured: <?php echo $_smarty_tpl->tpl_vars['message']->value;
}
/* {/block 'contents'} */
}
