{extends file="base.tpl"}
{block name=title}SceneSys: Listing{/block}

{block name=contents}
<table id="scenetable" class="table table-bordered">
	<thead>
	<tr>
		<th class="scene_id_row">ID</th>
		<th class="scene_state_row">State</th>
		<th class="scene_owner_row">Owner</th>
		<th class="scene_title_row">Title</th>
		<th>Description</th>
	</tr>
	</thead>
	<tbody>
	{foreach $scenes as $scene}
	<tr>
		<td><a href="scene.php?id={$scene.id}">{$scene.id}</a></td>
		<td>{$scene.state}</td>
		<td><a href="owner.php?id={$scene.owner}">{$scene.owner_name}</a></td>
		<td><a href="scene.php?id={$scene.id}">{$scene.title}</a></td>
		<td>{$scene.description}</td>
	</tr>
	{/foreach}
	</table>
{/block}