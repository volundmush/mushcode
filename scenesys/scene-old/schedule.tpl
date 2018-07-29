{extends file="base.tpl"}
{block name=title}Schedule #{$schedule.id}: {$schedule.title}{/block}
{block name=head}<link rel="StyleSheet" href="calendar.css" type="text/css" />{/block}

{block name=contents}
<table border="0" cellpadding="1" align="center" id="scheduleheader">
	<tr>
		<th>{$schedule.player_name} scheduled, <br>On {$schedule.date} at {$schedule.time}<br/>
			 <font size="5">
			 {if $schedule.title}
				{$schedule.title}
			{else}
				No Title.
			{/if}
			</font>
		</th>
	</tr>
	<tr>
		<td width="400">
		<hr>
		{if $schedule.desc}
			{$schedule.desc}
		{else}
			No description.
		{/if}
		</td>
	</tr>
</table>
{/block}