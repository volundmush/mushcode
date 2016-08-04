<?php
/* Smarty version 3.1.29, created on 2016-05-06 02:21:14
  from "/var/www/srwmush.com/scene2/error.tpl" */

if ($_smarty_tpl->smarty->ext->_validateCompiled->decodeProperties($_smarty_tpl, array (
  'has_nocache_code' => false,
  'version' => '3.1.29',
  'unifunc' => 'content_572c37dad11125_21193978',
  'file_dependency' => 
  array (
    '7647efecc8893a8b7f28e3d8e46ed3731eb55c2b' => 
    array (
      0 => '/var/www/srwmush.com/scene2/error.tpl',
      1 => 1462515528,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
    'file:base.tpl' => 1,
  ),
),false)) {
function content_572c37dad11125_21193978 ($_smarty_tpl) {
$_smarty_tpl->ext->_inheritance->init($_smarty_tpl, true);
?>

<?php 
$_smarty_tpl->ext->_inheritance->processBlock($_smarty_tpl, 0, 'title', array (
  0 => 'block_1927259399572c37dacf9843_16655157',
  1 => false,
  3 => 0,
  2 => 0,
));
?>


<?php 
$_smarty_tpl->ext->_inheritance->processBlock($_smarty_tpl, 0, 'contents', array (
  0 => 'block_1240596138572c37dacfbfa4_16221962',
  1 => false,
  3 => 0,
  2 => 0,
));
$_smarty_tpl->ext->_inheritance->endChild($_smarty_tpl);
$_smarty_tpl->smarty->ext->_subtemplate->render($_smarty_tpl, "file:base.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array(), 2, false);
}
/* {block 'title'}  file:error.tpl */
function block_1927259399572c37dacf9843_16655157($_smarty_tpl, $_blockParentStack) {
?>
SceneSys: Error<?php
}
/* {/block 'title'} */
/* {block 'contents'}  file:error.tpl */
function block_1240596138572c37dacfbfa4_16221962($_smarty_tpl, $_blockParentStack) {
?>
 An error occured: <?php echo $_smarty_tpl->tpl_vars['message']->value;
}
/* {/block 'contents'} */
}
