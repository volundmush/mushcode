{extends file="base.tpl"}
{block name=title}Schedule #{$schedule.id}: {$schedule.title}{/block}
{block name=head}<link rel="StyleSheet" href="styles/calendar.css" type="text/css" />{/block}

{block name=contents}
<table border="0" cellpadding="1" align="center" id="scheduleheader">
	<thead>
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
	</thead>
	<tbody>
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
	</tbody>
</table>
{/block}