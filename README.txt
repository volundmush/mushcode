Volund's MUSHcode Suite - For PennMUSH

==============================<* CONTACT INFO *>==============================
Name: Volund
Email: volundmush@gmail.com

===============================<* DISCLAIMER *>===============================
LICENSE for using Volund's MUSHcode Suite 2.0
Terms

"Softcode" refers to the contents of every file in this package with the exception of Myrddin's MUSH Cron. "Game" refers to any copy of PennMUSH, RhostMUSH, or similar program it's running on.

CONDITIONS
You may copy, distribute, and alter this softcode with the following restrictions:
A) The softcode may not be used for commercial purposes, whether this be selling the softcode or using it on a pay-to-play game.
B) Please link back to the original repository in a visible credits file or article somewhere on your game, and give credit where it is due.
C) You need not release any altered versions of the softcode, but if you do it must be under identical terms.

Support is limited by my time and energy, but it's my goal to provide an easy-to-use and expansive suite of MUSHcode for all fans of the gaming platform to enjoy. If you have questions, bug reports, or feature requests, please use GitHub's Issues tab. Faiing that, email will do.

========================<* REQUIREMENTS - PennMUSH *>=========================
1) The latest version of PennMUSH. You can find PennMUSH at https://github.com/pennmush/pennmush
2) A WIZARD character to install and maintain the code. (do NOT use #1 for this except where specified!)
3) Access to #1's STARTUP - you'll need to get creative - or lucky - without it.
4) Very specific mush.cnf settings. Those will be detailed below.
5) Login tracking, JobSys and the non-+pot aspects of SceneSys require MySQL.

========================<* REQUIREMENTS - RhostMUSH *>========================
1) The latest version of RhostMUSH. You can find RhostMUSH at https://github.com/RhostMUSH/trunk
2) An IMMORTAL (bittype 6) character to install and maintain the code.
3) Specific netrhost.conf settings. Those will be detailed below.
4) Login tracking, JobSys and the non-+pot aspects of SceneSys require MySQL.

================================<* FEATURES *>================================
CROSS-COMPATABILITY: Run a game in either PennMUSH or RhostMUSH.

MODULAR DESIGN: Install only the features you want. The CORE INSTALL is designed to get along with most existing code for well-established games.

MIGRATION SUPPORT: The 1.0 code can be quickly replaced with 2.0 without any data loss thanks to a provided Migration tool.

CONFIGURABILITY: The +gameconfig command allows Wizards to configure global settings for their game so that they'll never have to touch attributes or softcode. This makes tasks like configuring +finger, noting which room is the OOC nexus, and what channels to announce character approvals on (or whether the game even requires character approval) easy. The player version, +config, grants a variety of fine control for changing player-side color rendering, whether they receive certain system alerts, and similar.

ACCOUNT-BASED ALTS MANAGEMENT: The Account Management System centralizes character settings and alts lists under separate accounts. If installed, +config settings, BBS read/unread data, and several other things are stored on the Account and not individual characters. Players retain the ability to keep some alts hidden.

ANCESTOR PARENTS: A set of useful displays for room parents, player formatters, and handy building settings.

BULLETIN BOARD: A high-quality replacement to the ever-popular Myrddin's BBS is provided. Used with the same familiar commands and displayed the same familiar way, but far more robust and powerful and more easily secured (see @lock-simplification.) Has the ability to import Myrddin's BBS boards to some extent.

CHANNELS: For PennMUSH, its built-in @channels code has been greatly expanded upon with automated tools for configuring extra mogrifier options, displaying channels in a user-friendly style. Channels become easier to secure and manage. A duration-based 'muzzle' system can restrict troublemakers from channels.

CONVENIENCE: A plethora of player globals and conveniences, such as multi-descer, +beep, and +who.

MULTI-DESCER: A basic Multi-descer for saving and loading player @descs.

FCLIST: An +fclist/+roster system is provided for games with pre-genned characters and any need to track the availability or closure of feature characters.

FINGER: An incredibly powerful +finger and +oocfinger that can be configured via +gameconfig to be whatever a game owner wants it to be.

GRID AND NAVIGATION: Building is simplified under the +District system, a manager for ROOM PARENTS that forms the basis of a highly configurable teleportation and +invite/+summon/+join system.

GROUP SYSTEM: A Groups/Guilds system handles representing all factions, organizations, guilds, and similar associations with a flexible rank structure, configurable permissions, softcoded IC and OOC channels, and a set of BBS boards specific to each group.

HELP SYSTEM: The provided help system supports display categories and subfiles, as well as metatag-based searching. Everything is elaborately documented in a consistent, easy-to-read style.

INFO SYSTEM: The +info system allows 'text files' to be created on players and optionally locked by admin, visible to all other players. This is useful as an add-on for any chargen systems. +pinfo allows players to store private information only they and admin can see.

JOBS SYSTEM: Inspired by the ever-popular Anomaly Jobs, the Job System handles trouble tickets/requests with the ability to assign jobs to categories, grant admin access to categories, and many other features.

@LOCK-SIMPLIFICATION: The Lock Management System creates an abstraction layer to facilitate the creation of complex locks using configurable options.

PAGE EXTENSION: For PennMUSH, the Page Extension enables the reply command and provides an +ignore command to automatically block unwanted pagers.

PUEBLO/MXP SUPPORT: In PennMUSH, many systems create clickable output for ease of use.

RADIO: A flexible frequency-based +radio system allows players to manage their own softcoded 'channels.'

SCENESYS/POT: The Scene Management System is a very advanced scene scheduling and automatic logging system that uses SQL. Also included is a Pose Tracker (+pot) for local storage and convenience in roleplay.

WATCH: A Friends/wf list lets players keep track of their friends and alert them when they connect or disconnect.

WHO: A Who and Where command is provided that integrates with many other systems.

=========================<* COMPLICATIONS AND BUGS *>=========================
1. Although this code was designed with the hope that it will be easy to install on an established game, those are always case-by-case situations. I can make no guarantees. On PennMUSH, the Master Code Object must be the Event Handler. On RhostMUSH, it must be the hook_obj. Without this, many things simply will not work.

2. While many bugs were stomped in the creation of 2.0, more doubtlessly remain. Don't be afraid to send in GitHub issues if you find them.

3. My code uses lots and lots of action lists. If you're a mostly function-based softcoder, you're on your own.

===========================<* INSTALL - PennMUSH *>===========================
1. This readme assumes you at least know the basics of what you're doing by installing softcode and running a game, have a host, know how to get the game running and back it up, edit its files, etc. If you don't, I'd suggest checking out these fine people over at M*U*S*H, PennMUSH's development/social hangout establishment, available at: http://mush.pennmush.org/ - most coders there could easily get you going in a flash.

Be sure you are saving the cnf files with UNIX linebreaks if you're on Windows! I recommend notepad++ for the job.

2. Examine your mush.cnf, make sure it has the following:
A) Event Handler and Ancestors will be handled by the #1 Startup - leave these alone.
B) function_invocation_limit 100000
C) queue_entry_cpu_time 4500
D) null_eq_zero yes
E) pueblo yes
F) Under the help section, comment out ahelp, anews, and news.

3. Recommendations in mush.cnf: These are not NECESSARY, but are nice to have.
A) mud_name - set it to something short but respectable, it'll be showing up in my code a lot!
B) Uncomment all the dump_* messages and then clear dump_complete - this'll get rid of that annoying 'GAME: Save Complete.'
C) Instead of using the built-in txt files, create in-game objects and put the displays there? It'll protect them from Git updates and lets you use ANSI and softcode displays!
D) Under Cosmetic stuff: player_name_spaces - set this to yes.
E) Under Cosmetic stuff: set page_aliases to yes
F) Under Flags section: You may also want to include ANSI and COLOR256 as a default but some clients might barf at this.

3. In your restart file, uncomment and ensure your LANG=en_US if you want to take advantage of the expanded charset. Little requires this, but it does allow accented names and some other tricks. Some server OSes might need the ISO version of en_US specified.

4. Logon to your code-WIZARD character who will own the code. Run the CORE 01 file to create the Master Code Object.
5. Next, logon to #1 and run CORE 02.
6. Return to your WIZARD character and run CORE 03 and CORE 04.
7. @shutdown/reboot to make sure all of the STARTUPS are working.

8. At this point, you can choose to install whatever you want. HOWEVER, do note that the helpfiles for each system are included in the system's file, as are the MIGRATION COMMANDS. If you are planning on migrating data from 1.0, install the Migration Tool first. If you are going to use the Help System, it should follow. This will ensure that Help files (and migration code) will be installed when the systems are installed.

9. Use +gameconfig to configure all relevant settings as appropriate to your game.

10. Have fun!

==========================<* INSTALL - RhostMUSH *>===========================
1. This readme assumes you at least know the basics of what you're doing by installing softcode and running a game, have a host, know how to get the game running and back it up, edit its files, etc. If you don't, I'd suggest checking out these fine people over at M*U*S*H, PennMUSH's development/social hangout establishment, available at: http://mush.pennmush.org/ - most coders there could easily get you going in a flash. Even if you're using RhostMUSH.

Be sure you are saving the .conf files with UNIX linebreaks if you're on Windows! I recommend notepad++ for the job.

1. Logon to your Immortal character who will own the code. Run the CORE 01 file to create the Master Code Object.
2. Run CORE 02. Unlike Penn this will be run off the same character, not #1.
3. Run CORE 03 and CORE 04.
4. @reboot to make sure all of the STARTUPS are working.

Why does it not need a lot of modifications to netrhost.conf? Because the CORE 02 startup does all of that! Handy!

5. At this point, you can choose to install whatever you want. HOWEVER, do note that the helpfiles for each system are included in the system's file. If you want to use my Help System, install it FIRST. This will ensure the helpfiles are entered as the systems are installed.

6. Use +gameconfig to configure all relevant settings as appropriate to your game.

7. Have fun!

============================<* Migrate From 1.0 *>============================
This only affects users of PennMUSH because there was no 1.0 available for Rhost!

So you were using 1.0 and now you want to upgrade to 2.0? Here's how this works!

Each relevant system has some attributes on it that will install to the MIGRATION system. There are three commands available on it: +migrate, +cleanup, and +conflict.

NOTE ABOUT MIGRATIONS: -ENSURE- that you have set the Function Invocation Limit and queue_entry_cpu_time as described in the install instructions or you may have some problems. Also, DO BE SURE TO BACK UP FIRST! These have been bested, but you can never be paranoid enough when working with so much data processing. Furthermore, you CANNOT mix and match 1.0 code and 2.0 code. Most 1.0 code will barf the moment the 2.0 Master Code Object supplants the 1.0 Code Object Indexer.

Conversion is fairly simple. Use your previous Codewizard and go through the installation procedures. Then run +migrate Account, +migrate BBS, and so on as you are doing so.

If Migrations are successful, run the relevant +cleanup command to clear old player data (only a few systems have this) then use +conflict Account, +conflict BBS, etc, to disable the old objects and put them in storage.

===============================<* DONATIONS *>================================
While the code is all free, if anyone who finds it useful is of a mind to donate and support my work, consider donating to my PayPal? volundmush@gmail.com