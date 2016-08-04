<?php
/* Smarty version 3.1.29, created on 2016-05-06 01:32:21
  from "/var/www/srwmush.com/scene2/debug.tpl" */

if ($_smarty_tpl->smarty->ext->_validateCompiled->decodeProperties($_smarty_tpl, array (
  'has_nocache_code' => false,
  'version' => '3.1.29',
  'unifunc' => 'content_572c2c65a36ed3_65552098',
  'file_dependency' => 
  array (
    '96884a339eaf7f59745511a10a5ed2f0c3105846' => 
    array (
      0 => '/var/www/srwmush.com/scene2/debug.tpl',
      1 => 1450663026,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_572c2c65a36ed3_65552098 ($_smarty_tpl) {
if (!is_callable('smarty_modifier_debug_print_var')) require_once '/var/www/srwmush.com/scene2/plugins/modifier.debug_print_var.php';
$_smarty_tpl->_cache['capture_stack'][] = array('_smarty_debug', 'debug_output', null); ob_start(); ?>
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
    <head>
        <title>Smarty Debug Console</title>
        <style type="text/css">
            
            body, h1, h2, h3, td, th, p {
                font-family: sans-serif;
                font-weight: normal;
                font-size: 0.9em;
                margin: 1px;
                padding: 0;
            }

            h1 {
                margin: 0;
                text-align: left;
                padding: 2px;
                background-color: #f0c040;
                color: black;
                font-weight: bold;
                font-size: 1.2em;
            }

            h2 {
                background-color: #9B410E;
                color: white;
                text-align: left;
                font-weight: bold;
                padding: 2px;
                border-top: 1px solid black;
            }
            h3 {
                text-align: left;
                font-weight: bold;
                color: black;
                font-size: 0.7em;
                padding: 2px;
            }

            body {
                background: black;
            }

            p, table, div {
                background: #f0ead8;
            }

            p {
                margin: 0;
                font-style: italic;
                text-align: center;
            }

            table {
                width: 100%;
            }

            th, td {
                font-family: monospace;
                vertical-align: top;
                text-align: left;
            }

            td {
                color: green;
            }

            .odd {
                background-color: #eeeeee;
            }

            .even {
                background-color: #fafafa;
            }

            .exectime {
                font-size: 0.8em;
                font-style: italic;
            }

            #bold div {
                color: black;
                font-weight: bold;
            }
            #blue h3 {
                color: blue;
            }
            #normal div {
                color: black;
                font-weight: normal;
            }
            #table_assigned_vars th {
                color: blue;
                font-weight: bold;
            }

            #table_config_vars th {
                color: maroon;
            }

            
        </style>
    </head>
    <body>

    <h1>Smarty <?php echo htmlspecialchars(Smarty::SMARTY_VERSION, ENT_QUOTES, 'UTF-8');?>
 Debug Console
        -  <?php if (isset($_smarty_tpl->tpl_vars['template_name']->value)) {
echo smarty_modifier_debug_print_var($_smarty_tpl->tpl_vars['template_name']->value);?>
 <?php }
if (!empty($_smarty_tpl->tpl_vars['template_data']->value)) {?>Total Time <?php echo htmlspecialchars(sprintf("%.5f",$_smarty_tpl->tpl_vars['execution_time']->value), ENT_QUOTES, 'UTF-8');
}?></h1>

    <?php if (!empty($_smarty_tpl->tpl_vars['template_data']->value)) {?>
        <h2>included templates &amp; config files (load time in seconds)</h2>
        <div>
            <?php
$_from = $_smarty_tpl->tpl_vars['template_data']->value;
if (!is_array($_from) && !is_object($_from)) {
settype($_from, 'array');
}
$__foreach_template_0_saved_item = isset($_smarty_tpl->tpl_vars['template']) ? $_smarty_tpl->tpl_vars['template'] : false;
$_smarty_tpl->tpl_vars['template'] = new Smarty_Variable();
$_smarty_tpl->tpl_vars['template']->_loop = false;
foreach ($_from as $_smarty_tpl->tpl_vars['template']->value) {
$_smarty_tpl->tpl_vars['template']->_loop = true;
$__foreach_template_0_saved_local_item = $_smarty_tpl->tpl_vars['template'];
?>
                <font color=brown><?php echo htmlspecialchars($_smarty_tpl->tpl_vars['template']->value['name'], ENT_QUOTES, 'UTF-8');?>
</font>
                <br>&nbsp;&nbsp;<span class="exectime">
                (compile <?php echo htmlspecialchars(sprintf("%.5f",$_smarty_tpl->tpl_vars['template']->value['compile_time']), ENT_QUOTES, 'UTF-8');?>
) (render <?php echo htmlspecialchars(sprintf("%.5f",$_smarty_tpl->tpl_vars['template']->value['render_time']), ENT_QUOTES, 'UTF-8');?>
) (cache <?php echo htmlspecialchars(sprintf("%.5f",$_smarty_tpl->tpl_vars['template']->value['cache_time']), ENT_QUOTES, 'UTF-8');?>
)
                 </span>
                <br>
            <?php
$_smarty_tpl->tpl_vars['template'] = $__foreach_template_0_saved_local_item;
}
if ($__foreach_template_0_saved_item) {
$_smarty_tpl->tpl_vars['template'] = $__foreach_template_0_saved_item;
}
?>
        </div>
    <?php }?>

    <h2>assigned template variables</h2>

    <table id="table_assigned_vars">
        <?php
$_from = $_smarty_tpl->tpl_vars['assigned_vars']->value;
if (!is_array($_from) && !is_object($_from)) {
settype($_from, 'array');
}
$__foreach_vars_1_saved_item = isset($_smarty_tpl->tpl_vars['vars']) ? $_smarty_tpl->tpl_vars['vars'] : false;
$_smarty_tpl->tpl_vars['vars'] = new Smarty_Variable();
$_smarty_tpl->tpl_vars['vars']->iteration=0;
$_smarty_tpl->tpl_vars['vars']->_loop = false;
foreach ($_from as $_smarty_tpl->tpl_vars['vars']->key => $_smarty_tpl->tpl_vars['vars']->value) {
$_smarty_tpl->tpl_vars['vars']->_loop = true;
$_smarty_tpl->tpl_vars['vars']->iteration++;
$__foreach_vars_1_saved_local_item = $_smarty_tpl->tpl_vars['vars'];
?>
            <tr class="<?php if ($_smarty_tpl->tpl_vars['vars']->iteration%2 == 0) {?>odd<?php } else { ?>even<?php }?>">
                <td><h3><font color=blue>$<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['vars']->key, ENT_QUOTES, 'UTF-8');?>
</font></h3>
                    <?php if (isset($_smarty_tpl->tpl_vars['vars']->value['nocache'])) {?><b>Nocache</b></br><?php }?>
                    <?php if (isset($_smarty_tpl->tpl_vars['vars']->value['scope'])) {?><b>Origin:</b> <?php echo smarty_modifier_debug_print_var($_smarty_tpl->tpl_vars['vars']->value['scope']);
}?>
                </td>
                <td><h3>Value</h3><?php echo smarty_modifier_debug_print_var($_smarty_tpl->tpl_vars['vars']->value['value'],10,80);?>
</td>
                <td><?php if (isset($_smarty_tpl->tpl_vars['vars']->value['attributes'])) {?><h3>Attributes</h3><?php echo smarty_modifier_debug_print_var($_smarty_tpl->tpl_vars['vars']->value['attributes']);?>
 <?php }?></td>
         <?php
$_smarty_tpl->tpl_vars['vars'] = $__foreach_vars_1_saved_local_item;
}
if ($__foreach_vars_1_saved_item) {
$_smarty_tpl->tpl_vars['vars'] = $__foreach_vars_1_saved_item;
}
?>
    </table>

    <h2>assigned config file variables</h2>

    <table id="table_config_vars">
        <?php
$_from = $_smarty_tpl->tpl_vars['config_vars']->value;
if (!is_array($_from) && !is_object($_from)) {
settype($_from, 'array');
}
$__foreach_vars_2_saved_item = isset($_smarty_tpl->tpl_vars['vars']) ? $_smarty_tpl->tpl_vars['vars'] : false;
$_smarty_tpl->tpl_vars['vars'] = new Smarty_Variable();
$_smarty_tpl->tpl_vars['vars']->iteration=0;
$_smarty_tpl->tpl_vars['vars']->_loop = false;
foreach ($_from as $_smarty_tpl->tpl_vars['vars']->key => $_smarty_tpl->tpl_vars['vars']->value) {
$_smarty_tpl->tpl_vars['vars']->_loop = true;
$_smarty_tpl->tpl_vars['vars']->iteration++;
$__foreach_vars_2_saved_local_item = $_smarty_tpl->tpl_vars['vars'];
?>
            <tr class="<?php if ($_smarty_tpl->tpl_vars['vars']->iteration%2 == 0) {?>odd<?php } else { ?>even<?php }?>">
                <td><h3><font color=blue>#<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['vars']->key, ENT_QUOTES, 'UTF-8');?>
#</font></h3>
                    <?php if (isset($_smarty_tpl->tpl_vars['vars']->value['scope'])) {?><b>Origin:</b> <?php echo smarty_modifier_debug_print_var($_smarty_tpl->tpl_vars['vars']->value['scope']);
}?>
                </td>
                <td><?php echo smarty_modifier_debug_print_var($_smarty_tpl->tpl_vars['vars']->value['value'],10,80);?>
</td>
            </tr>
        <?php
$_smarty_tpl->tpl_vars['vars'] = $__foreach_vars_2_saved_local_item;
}
if ($__foreach_vars_2_saved_item) {
$_smarty_tpl->tpl_vars['vars'] = $__foreach_vars_2_saved_item;
}
?>

    </table>
    </body>
    </html>
<?php list($_capture_buffer, $_capture_assign, $_capture_append) = array_pop($_smarty_tpl->_cache['capture_stack']);
if (!empty($_capture_buffer)) {
 if (isset($_capture_assign)) $_smarty_tpl->assign($_capture_assign, ob_get_contents());
 if (isset( $_capture_append)) $_smarty_tpl->append( $_capture_append, ob_get_contents());
$_smarty_tpl->_cache['__smarty_capture'][$_capture_buffer]=ob_get_clean();
} else $_smarty_tpl->capture_error();
echo '<script'; ?>
 type="text/javascript">
    <?php $_smarty_tpl->tpl_vars['id'] = new Smarty_Variable('__Smarty__', null);
$_smarty_tpl->ext->_updateScope->updateScope($_smarty_tpl, 'id', 0);?>
    <?php if ($_smarty_tpl->tpl_vars['display_mode']->value) {
$_smarty_tpl->tpl_vars['id'] = new Smarty_Variable(md5(((string)$_smarty_tpl->tpl_vars['offset']->value).((string)$_smarty_tpl->tpl_vars['template_name']->value)), null);
$_smarty_tpl->ext->_updateScope->updateScope($_smarty_tpl, 'id', 0);
}?>
    _smarty_console = window.open("", "console<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['id']->value, ENT_QUOTES, 'UTF-8');?>
", "width=1024,height=600,left=<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['offset']->value, ENT_QUOTES, 'UTF-8');?>
,top=<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['offset']->value, ENT_QUOTES, 'UTF-8');?>
,resizable,scrollbars=yes");
    _smarty_console.document.write("<?php echo strtr($_smarty_tpl->tpl_vars['debug_output']->value, array("\\" => "\\\\", "'" => "\\'", "\"" => "\\\"", "\r" => "\\r", "\n" => "\\n", "</" => "<\/" ));?>
");
    _smarty_console.document.close();
<?php echo '</script'; ?>
>
<?php }
}
