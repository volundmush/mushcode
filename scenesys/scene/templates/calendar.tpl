{extends file="templates/base.tpl"}
{block name=title}Scene Calendar{/block}
{block name=head}<link rel="StyleSheet" href="styles/calendar.css" type="text/css" />{/block}

{block name=contents}

{foreach from=$calendar item=monthdata}
<h1><center>{$monthdata.header.0}, {$monthdata.header.1}</center></h1>
<table cellpadding="0" cellspacing="0" class="calendar">
	<thead>
		<tr class="calendar-row">
			<th class="calendar-day-head">Sunday</th>
			<th class="calendar-day-head">Monday</th>
			<th class="calendar-day-head">Tuesday</th>
			<th class="calendar-day-head">Wednesday</th>
			<th class="calendar-day-head">Thursday</th>
			<th class="calendar-day-head">Friday</th>
			<th class="calendar-day-head">Saturday</th>
		</tr>
	</thead>
	<tbody>
	{foreach from=$monthdata.data key=day item=schedule}
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
					<a class="scenetitle" href="schedule.php?id={$scene.id}">{$scene.title}</a>
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
	</tbody>
</table>
{/foreach}
{/block}