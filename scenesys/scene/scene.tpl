{extends file="base.tpl"}
{block name=title}Scene #{$scene.id}: {$scene.title}{/block}

{block name=contents}
<table id="posetable" class="table table-bordered">
	<thead>
	<tr>
		<th class="scene_poser_row">Owner</th>
		<th class="scene_pose_row">Pose</th>
	</tr>
	</thead>
	<tbody>
	{foreach $poses as $pose}
	<tr class='pose'>
		<td><a href="owner.php?id={$pose.owner}">{$pose.owner_name}</a></td>
		<td>{$pose.text}</td>
	</tr>
	{/foreach}
	</table>
{/block}

{block name=footer}
<form action="{$scene.url}{$scene.id}/{$scene.title}" method="POST">
<input type="hidden" name="target" value="{$scene.title}">
<input type="hidden" name="form" value="Roleplaying Log">
<input type="hidden" name="Log Header[pretty]" value="yes">
<input type="hidden" name="Log Header[Date of Scene]" value="{$scene.creation_date}">
<input type="hidden" name="Log Header[Location]" value="{$scene.location}">
<input type="hidden" name="Log Header[Cast of Characters]" value="{$scene.poser_ids}">
<input type="hidden" name="Log Header[Synopsis]" value="{$scene.description}">
<input type="hidden" name="Poses[Poses]" value="{$scene.formatted_poses}">
{if $scene.title}
	<input id='logsubmit' type='submit' value='Submit Log to Wiki'>
{else}
	<input id='logsubmit' type='submit' value='No Scene Title' disabled>
{/if}
</form>
{/block}