<?php
function ansispan($matches)
{
	$string = $matches['codes'];
	if( preg_match("/(#[0-f][0-f][0-f][0-f][0-f][0-f]|[+][a-z0-9]+)(\/(#[0-f][0-f][0-f][0-f][0-f][0-f]|[+][a-z0-9]+))?/",$string) ) {
		$temp = preg_replace("/((#[0-f][0-f][0-f][0-f][0-f][0-f])|[+]([a-z0-9]+))/","\\2\\3",$string);
		return "<span style=\"color:$temp\">";
	}
	$fg = 'n';
 	$bg = 'n';
	$bold = 0;
	$invert = 0;
	$result = "";
	$result_array = str_split($string);
	foreach($result_array as $char)
	{
		if(preg_match("/[A-Z]/",$char))
			$bg = strtolower($char);
		elseif($char=='i')
			$invert=1;
		elseif($char=='h')
			$bold = 1;
		elseif($char=='f')
			$result .= "flash ";
		elseif($char=='u')
			$result .= "underline ";
		else 
			$fg = $char;
	}
	$fg = ($invert ? "bg_" : "fg_") . $fg;
	$bg = ($invert ? "fg_" : "bg_") . $bg;
	$fg = ($bold ? "bold_".$fg : $fg);
	$result = trim($result);
	$classes = trim("$result $fg $bg ++ $string");
	return "<span class=\"$classes\">";
}

function ansi2html($line)
{
	$line = str_replace('&','&amp;',$line);
	$line = str_replace('<','&lt;',$line);
	$line = str_replace('>','&gt;',$line);
	$line = preg_replace("#\\002c\/\\003#","</span>",$line);
	$line = preg_replace("#\\002p\/\\003#","",$line);
	$line = preg_replace("#\\002p(.+?)\\003#","",$line);
	$line = preg_replace_callback("#\\002c(?P<codes>.+?)\\003#","ansispan",$line);
	$line = str_replace('|','&#124;',$line);
	$line = str_replace('{','&#123;',$line);
	$line = str_replace('}','&#125;',$line);
	$line = str_replace('  ','&nbsp;&nbsp;',$line);
	$line = str_ireplace('%t','&nbsp;&nbsp;&nbsp;&nbsp;',$line);
	$line = str_ireplace('%r','<br>',$line);
	$line = str_ireplace("\n",'<br>',$line);
	$line = str_ireplace("\t",'&nbsp;&nbsp;&nbsp;&nbsp;',$line);
	return $line;
}
?>
