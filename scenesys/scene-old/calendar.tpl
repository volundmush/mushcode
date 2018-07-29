{extends file="base.tpl"}
{block name=title}Scene Calendar{/block}
{block name=head}<link rel="StyleSheet" href="calendar.css" type="text/css" />{/block}

{block name=contents}
<h1><center>{$header.1}</center></h1>
<table cellpadding="0" cellspacing="0" class="calendar">
	<tr class="calendar-row">
		<td class="calendar-day-head">Sunday</td>
		<td class="calendar-day-head">Monday</td>
		<td class="calendar-day-head">Tuesday</td>
		<td class="calendar-day-head">Wednesday</td>
		<td class="calendar-day-head">Thursday</td>
		<td class="calendar-day-head">Friday</td>
		<td class="calendar-day-head">Saturday</td>
	</tr>
	{foreach from=$cal1 key=day item=schedule}
		{if $day == 1 || $day == 8 || $day == 15 || $day == 22 || $day == 29}
			<tr class="calendar-row">
		{/if}
		{if $schedule}
			<td class="calendar-day">
			<div class="day-number">{$schedule.num}</div>
			{if $schedule.scenes}
				<table class=CalendarItems>
				{foreach from=$schedule.scenes item=scene}
					<tr><td>{$scene.date} - {$scene.owner}<br/>
					<a href="schedule.php?id={$scene.id}">{$scene.title}</a>
					</td></tr>
				{/foreach}
				</table>
			{else}
				<p>&nbsp;</p><p>&nbsp;</p>
			{/if}
		{else}
			<td class="calendar-day-np">&nbsp;</td>
		{/if}
		{if $day % 7 == 0}
			</tr>
		{/if}
	{/foreach}
</table>

<h1><center>{$header.2}</center></h1>
<table cellpadding="0" cellspacing="0" class="calendar">
	<tr class="calendar-row">
		<td class="calendar-day-head">Sunday</td>
		<td class="calendar-day-head">Monday</td>
		<td class="calendar-day-head">Tuesday</td>
		<td class="calendar-day-head">Wednesday</td>
		<td class="calendar-day-head">Thursday</td>
		<td class="calendar-day-head">Friday</td>
		<td class="calendar-day-head">Saturday</td>
	</tr>
	{foreach from=$cal2 key=day item=schedule}
		{if $day == 1 || $day == 8 || $day == 15 || $day == 22 || $day == 29}
			<tr class="calendar-row">
		{/if}
		{if $schedule}
			<td class="calendar-day">
			<div class="day-number">{$schedule.num}</div>
			{if $schedule.scenes}
				<table class=CalendarItems>
				{foreach from=$schedule.scenes item=scene}
					<tr><td>{$scene.date} - {$scene.owner}<br/>
					<a href="schedule.php?id={$scene.id}">{$scene.title}</a>
					</td></tr>
				{/foreach}
				</table>
			{else}
				<p>&nbsp;</p><p>&nbsp;</p>
			{/if}
		{else}
			<td class="calendar-day-np">&nbsp;</td>
		{/if}
		{if $day % 7 == 0}
			</tr>
		{/if}
	{/foreach}
</table>
{/block}
