{extends file="templates/base.tpl"}
{block name=title}SceneSys: Listing{/block}

{block name=contents}
	<table id="scenetable" class="table-scenesys">
		<thead>
			<tr>
				<th class="cell-id th-scenesys">ID</th>
				<th class="cell-status th-scenesys">State</th>
				<th class="cell-owner th-scenesys">Owner</th>
				<th class="cell-title th-scenesys">Title</th>
				<th class="cell-desc th-scenesys">Description</th>
			</tr>
		</thead>
		<tbody>
		{foreach $scenes as $scene}
			<tr>
				<td class="cell-id td-scenesys"><a href="scene.php?id={$scene.id}">{$scene.id}</a></td>
				<td class="cell-status td-scenesys">{$scene.state}</td>
				<td class="cell-owner td-scenesys"><a href="owner.php?id={$scene.owner}">{$scene.owner_name}</a></td>
				<td class="cell-title td-scenesys"><a href="scene.php?id={$scene.id}">{$scene.title}</a></td>
				<td class="cell-desc td-scenesys">{$scene.description}</td>
			</tr>
		{/foreach}
	</table>
{/block}

{block name=footer}
<div id="index-footer">
	Click a Scene to view poses!
</div>

{/block}