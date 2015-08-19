<?php
function ansispan($string)
{
	if( preg_match("/(#[0-f][0-f][0-f][0-f][0-f][0-f]|[+][a-z0-9]+)(\/(#[0-f][0-f][0-f][0-f][0-f][0-f]|[+][a-z0-9]+))?/",$string[1]) ) {
		$temp = preg_replace("/((#[0-f][0-f][0-f][0-f][0-f][0-f])|[+]([a-z0-9]+))/","\\2\\3",$string[1]);
		return "<span style=\"color:$temp\">";
	}
	$fg = 'n';
 	$bg = 'n';
	$bold = 0;
	$invert = 0;
	$result = "";
	$result_array = str_split($string[1]);
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
	$result = chop($result);
	return "$inverta<span class=\"$result $fg $bg ++ $string[1]\">";
}

function pueblospan($line)
{
	$result = "";
	$result_array = explode('p',$line);
	foreach($result_array as $part)
	{
		$result .= "$part";
	}
	return $result;
}

function ansi2html($line)
{
	$output = "";
	$line = preg_replace('/</','&lt;',$line);
	$line = preg_replace('/>/','&gt;',$line);
	$ansiline = explode(sprintf("%c", 2)."c/",$line);
	## $ansiline = explode(sprintf("%c", 2)."c/",$line);
	reset($ansiline);
	foreach($ansiline as $text)
	{
		##$text = preg_replace("/c(.+?)\\003/","MATCH",$text);
		$text = preg_replace_callback("/p(.+)\\003/",'pueblospan',$text);
		$text = preg_replace_callback("/c([^ ]+?)\\003/",'ansispan',$text);
		$output .= "</span>".$text;
	}
	$standardmatch = array('/\002/','/\003/','/\012/','/\011/','/<span class="bg_n fg_n">(.+?)<\/span>/');
	$standardreturn = array('','',"<br />","&nbsp;&nbsp;&nbsp;&nbsp;",'\\1');
	return preg_replace($standardmatch,$standardreturn,"<span>$output");
}
?>
