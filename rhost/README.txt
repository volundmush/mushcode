             MOUVAR'S MUSHCODE SUITE - VERSION 1.0

1. INTRODUCTION
When you're hoping to start up a MUSH, it's more than a little daunting. You went to Game A, realized they had a pretty neat system for doing something crucially convenient, and wondered how, or where you could get it yourself. Maybe you stumbled around looking for a coder interested in your project, but were disappointed when none were to be found.

This pack is for you. It is the sincerest goal of the author that by using this MUSHcode suite nearly all the aspects of setting up and administrating a game will be child's play compared to starting off with a stock PennMUSH installation.

2. REQUIREMENTS
This MUSHcode suite requires PennMUSH version 1.8.5p4 or newer. It may work in earlier versions, but all @dolist/inlines will need to be replaced with @dolists. None of the code requires SQL.

MUSHcode knowledge is not required, but it definitely helps for doing anything fancy building off of this pack.

This code will NOT function in TinyMUSH or TinyMUX, and it's really not worth your time bothering trying to make it do so. An experienced coder may have some luck porting it to RhostMUSH (which shares many similarities with Penn) however.

3. FEATURES

	a. Infrastructure
	Code Indexing object for central management of code object DBREFs.
	Room, Thing, Player, and Exit Ancestor creating code and basic room layout.
	Custom Colors system for players to change how they see the game.
	Event Handler designed to locate any provided Event trigger on indexed object for future expansions.
	Centralized configuration object for keeping track of restricted and modified attributes and similar settings.
	Global Functions for many common tasks.
	
	b. Administration
	Character and Staff Administration for handling staff lists, players and their alts in accounts. Supports bitless staffers.
	Sitematch / IP logging and login security checker.
	Key / Lock system that simplifies PennMUSH's @lock system, designed to conveniently handle groups, factions, races, and similar setups.
	Channel Management system for simple creation and locking of @channels (integrates with Key / Lock system) and muzzling problem players, among other features.
	Job System inspired by Anomaly Jobs. Categorical organization of player or staff requests, supporting logging, commenting, approval, denying, and similar features.
	Help System that can be used for softcoded help menus, supports sub-menus and can be called many ways to access different help systems (staff help, news, help, etc.)
	Commands that simplify debugging and other common tasks.
	
	c. Player Conveniences
	Watch System for tracking when friends log on and off.
	Myrddin's BBS 4.0.6 Custom. Optimized for PennMUSH and integrates the Key / Lock system (see above.) Comes with a +bbnext that does not ignore board locks.
	Group System for small or medium player factions, supports rank structure, IC and OOC channels, and plenty of customization options.
	Pose Order Tracker (+pot) that stores poses for retrieval with a simple command. Supports privacy options and is easily reconfigured.
	Tel Code for helping players get around a grid. Easily setup and organized by districts/regions.
	Info Files, a shareable player notepad that players can use to track character data or other things, which may be published for other players to read and/or approved by admins for roleplay purposes (equipment lists, character backgrounds, etc.)
	Meet Code for teleporting straight to other players with a quick exchange.
	Who and Where code.
	A frequency-based Radio system that supports logging, recall, and encryption.

4. 


