# CHANGELOG

## Version 3.5
* (Experimental) Rhost support is in! There's probably a plethora of bugs, but much of the code is working. I'm still hammering out the kinks but feel welcome to try it.

## Version 3.1

### SCENESYS:
* +scene/edit now properly documented. it uses ^^^ to split before/after, just like +bbedit.
* +scene/joins are now timestamped. Timestamps older than 8h are invalidated. This is to prevent posing to the wrong scene two days later by accident.
* +scene/start and +scene/continue now link the room to the scene. To log a scene you must be in said room. This means only one scene can ever be active in a location at a time. Again, to prevent accidental cross-scene logging.
* +scene/upcoming aka +events, +Scenes, etc, now shows an empty day for today if there are no scenes today. This should make it easier to not mistake tomorrow for today, etc.
* +scene/old now displays the scene's creation date instead of its finish date, as the latter might be wildly inaccurate.
* Several fixes to the way scene data is created and handled. 

### ACCOUNT:
* +account/options MAIL option now works properly.

### BBS:
* The Mandatory board alert system now functions properly.
* +bbadmin/create now gives output on a success.
* +bbadmin/create works properly for setting default permissions now.
* +help bbs/admin is now accurate.
* +bbread/# now works for pagifying properly.

### GROUP:
* GBADMIN permission in default rank data renamed to BBADMIN. It was already supposed to be this, I just forgot.
* +help Groups/Membership now explains Group Titles.
* Group RADIO setting now processes kicks properly.
* Added +group/options with the ability to make +group <target> change focus.

### GUESTS:
* Guests are no longer automatically added to 'CHANNELS_PLAYERS' list by the Account System.
* Guest creation now works properly.

### GRID:
* +district/subcreate no longer gives display errors.
* +shelp +district now displays properly. Pesky commas!

### JOBS:
+job/newbucket now sets default permissions properly.

### MEETME:
* Displays now use the proper character (target, not enactor!) for figuring out width/color/formatting.

### SCENESYS:
* Now respects @lock/speech properly.

### THEME aka FCLIST:
* +Theme/status now works properly.

### TECHNICAL/MISC:
* Removed the vol_game_config legacy function.
* SQL Schema no longer uses nested Stored Procedures due to incompatability with PennMUSH's sql connection. Simply re-run the Schema.sql file to fix.

## Version 3.0:
* GROUP TIERS: Now Groups can be arranged into custom-named Tiers 0-255, not just Minor and Major.
* GROUP COMMANDS: Have been aggregated and streamlined into a new arrangement with much clearer meanings: +gmember, +gadmin, +grank, +gperm, etc, each with their own switches.
* PRIVATE GROUPS: Groups can be 'private', visible to only staff and members of such a private group.
* LOCKGEN: The Group System is at the heart of a new way to generate @lock keys for flexible permissions control. This replaces the old +key commands.
* BBS: Group Boards now exist in the 'global' namespace and can be locked the same way as any other board. They are distinguished from the main BBS by having a prefix before their order number. Posts no longer timeout because storage space is no longer a concern: enjoy thousands of posts per board!
* DYNAMIC DATA: For softcoder enthusiasts, the API for constructing your own room formatters, +who lists, and other displays using information from the game code has been exposed and documented.
* NESTED DISTRICTS: Districts can now be nested so you can have sub-districts, sub-sub-sub-districts, and so on. This will hopefully help those few games with truly massive and sprawling grids.
* OPTIONS: Most commands now support an /options switch that works just like the global +options command that replaces +config. The new menu is more helpful and explains the available options better.
* CONFIG: Admin can now use /config with many commands just like player use /options to configure the specifics of individual systems. +gameconfig has been drastically simplified.
* COLOR SYSTEM: The +Color system has been massively simplified but remains just as powerful.
* FRIENDS: The Watch System has evolved into the Friends system and now has the ability to keep an Account-based list of friends that's separate from the current character you're using.
* SCENE SLOTS: Now you can set the max slots you'd like to see for your scheduled scenes!

TECHNICAL STUFF:
* INCREASED MODULARITY: Many code systems have been split into their own code objects with fewer interdependencies. Install only the features you want on a streamlined CORE platform.
* SQL STORAGE: MySQL or MariaDB is now REQUIRED. Much of the code has been streamlined and now uses SQL Storage, Views, and Stored Procedures on a new and better-optimized SQL Schema. There should be fewer delays on loading data for over-stuffed databases with commands like +scene/old.
* CLEANED UP CODE: 3.0 has been massively refactored and streamlined to run cleaner and hopefully be easier to debug, extend, and maintain for the future.
* THE FUTURE: 3.0 has been written with future web integration futures and/or migration to my Python-based MU* Project Athanor (using the Evennia engine from www.evennia.com ) in mind.
