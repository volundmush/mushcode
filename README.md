# Volund's MUSHcode Suite - For PennMUSH

## CONTACT INFO
**Name:** Volund
**Email:** volundmush@gmail.com
**PayPal:** volundmush@gmail.com
**Patreon:** [link](https://www.patreon.com/volund)

## TERMS AND CONDITIONS

You may copy, distribute, and alter this softcode with the following restrictions:
  1. The softcode may not be used for commercial purposes, whether this be selling the softcode or using it on a pay-to-play game.
  2. Please link back to the original repository in a visible credits file or article somewhere on your game, and give credit where it is due. This is done by default with the Credits helpfile I provide!
  3. You need not release any altered versions of the softcode, but if you do it must be under identical terms.

Support is limited by my time and energy, but it's my goal to provide an easy-to-use and expansive suite of MUSHcode for all fans of the gaming platform to enjoy. If you have questions, bug reports, or feature requests, please use GitHub's Issues tab. Faiing that, email will do.

## REQUIREMENTS
  * A reliable server host.
  * Access to a MySQL or MariaDB database. This MUST be a local server, preferably running on the same host as the game due to latency.
  * Decent computer administration skills.

### REQUIREMENTS - PennMUSH
  * The latest version of PennMUSH. You can find PennMUSH at https://github.com/pennmush/pennmush
  * A WIZARD character to install and maintain the code. (do NOT use #1 for this except where specified!)
  * Access to #1's STARTUP - you'll need to get VERY creative without it.
  * Very specific mush.cnf settings. Those will be detailed below.

### REQUIREMENTS - RhostMUSH
  * The latest version of RhostMUSH. You can find RhostMUSH at https://github.com/RhostMUSH/trunk
  * An IMMORTAL (bittype 6) character to install and maintain the code.
  * Specific netrhost.conf settings. Those will be detailed below.

## FEATURES
  * **CROSS-COMPATABILITY:** Run a game in either PennMUSH or RhostMUSH.

  * **MODULAR DESIGN:** Install only the features you want. The CORE INSTALL is designed to get along with most existing code for well-established games.

  * **MIGRATION SUPPORT:** Previous versions of the code can be upgraded in-place with very little finnagling.

  * **CONFIGURABILITY:** Each code system has a /config menu for admins to customize its behavior, and often a player-equivalent. Most of how the game appears can be easily altered in one place.

  * **ACCOUNT-BASED CHARACTER/ALTS MANAGEMENT:** The Account, Alts, and Approval system offer plenty of support for binding characters together as alts and sharing data between them. The approval system is great for application-based games.

  * **ANCESTOR PARENTS:** Ancestor Things/Players/Rooms/Exits are included, laying an easily-tweaked foundation of room formatters, startup commands, and more.

  * **BULLETIN BOARD:** A high-quality replacement to the ever-popular Myrddin's BBS is provided. With SQL storage for its backend, it can store thousands of posts without trouble. The BBS integrates with the Group system as well, allowing each Group to have its own Boards in a separate namespace.

  * **CHANNELS:** For PennMUSH, its built-in @channels code has been greatly expanded upon with automated tools for configuring extra mogrifier options, displaying channels in a user-friendly style. Channels become easier to secure and manage. A duration-based 'muzzle' system can restrict troublemakers from channels.

  * **CONVENIENCE:** A plethora of player globals and conveniences, such as multi-descer, +beep, and +who.

  * **MULTI-DESCER:** A basic Multi-descer for saving and loading player @descs.

  * **THEME:** An +fclist/+theme system is provided for games with pre-genned characters and any need to track the availability or closure of feature characters. Themes can also have notes/text files attached for tracking important information.

  * **DYNAMICDATA:** Many commands utilize an information-retrieval API that's exposed for players and admin to use for designing their own displays using this codesuite's information.

  * **FINGER:** An incredibly powerful +finger and +oocfinger that can be configured via +gameconfig to be whatever a game owner wants it to be.

  * **DISTRICTS:** Building grids is simplified and better organized under the +District system, a manager for nestable ROOM PARENTS.

  * **NAVIGATION:** The +port and +meetme tools let players easily navigate even huge grids.

  * **GROUP SYSTEM:** A Groups/Guilds system handles representing all factions, organizations, guilds, and similar associations with a flexible rank structure, configurable permissions, softcoded IC and OOC channels, and a set of BBS boards specific to each group if the BBS is installed. Groups can be arranged and sorted into configurable Tiers, and Private Groups

  * **HELP SYSTEM:** The provided help system supports display categories and subfiles, as well as text-based searching. Everything is elaborately documented in a consistent, easy-to-read style. +help for players, +shelp for admin!

  * **INFO SYSTEM:** The +info system allows 'text files' to be created on players and optionally locked by admin, visible to all other players. +pinfo allows players to store private information only they and admin can see. Adding new categories/commands that use this infrastructure takes just two lines of code tweaks.

  * **JOBS:** Inspired by the ever-popular Anomaly Jobs, the Job Tracker handles trouble tickets/requests/issues across various Buckets, with flexible levels of access and administration.

  * **LOCK-SIMPLIFICATION:** With the Group system installed, systems like Jobs and the BBS switch to an incredible powerful and versatile Group-based lock system. It can generate Keystrings acceptable for @lock too.

  * **PAGE EXTENSION:** For PennMUSH, the Page Extension enables the reply command and provides an +ignore command to automatically block unwanted pagers.

  * **PUEBLO/MXP SUPPORT:** In PennMUSH, many systems create clickable output for ease of use.

  * **RADIO:** A flexible frequency-based +radio system allows players to manage their own softcoded 'channels.'

  * **SCENESYS/POT:** The Scene Management System is a very advanced scene scheduling and automatic logging system that uses SQL. Also included is a Pose Tracker (+pot) for local storage and convenience in roleplay.

  * **FRIEND:** A Friends/watch list lets players keep track of their friends and alert them when they connect or disconnect.

  * **WHO AND WHERE:** A Who and Where command is provided that integrates with many other systems. Don't like how Who looks? Change it with DynamicData strings!

  * **LOGIN TRACKER:** If installed, the Login Tracker records IP addresses and times of every login attempt, helping players and admin keep an eye out for suspicious activity.

  * **WIZLIST:** Don't like to give out Royalty or Wizard flags? Don't worry. Specify a private Admin group, and anyone on it is considered an admin in this code package. Only those of a customizable group rank or higher appear on the WizList!

  * **IDLE SWEEPER:**: Give it a destination, a run interval, and an idle limit, and this will keep the grid clear of idlers.

  * **POLL SYSTEM:** Hold global polls that can accept given options and allow for 'Other' field answers.

  * **GUEST MANAGEMENT:** Creating and keeping track of Guests is easy and fully explained. This code makes sure that Guests return to a specific room after disconnect, will have access to a guest channel, and allows them to adopt a temporary custom name.

  * **VIRTUAL ROOMS:** Don't like giving people @dig access? No problem. The Virtual Room parents allows a THING object to be turned into a veritable and highly stylish labyrinth of virtual rooms. Ambitious softcoders can do much to change their room's appearance.

  * **CUSTOM COLORS:** Players can alter most of the colors of things they see, from other character's names to groups to borders in commands like +who and +finger.

## CONSIDERATIONS
  1. Although this code was designed with the hope that it will be easy to install on an established game, those are always case-by-case situations. I can make no guarantees. On PennMUSH, the Core Code Parent must be the Event Handler. On RhostMUSH, it must be the hook_obj. Without this, many things simply will not work.
  2. While many bugs were stomped in the creation of 3.0, more doubtlessly remain. Don't be afraid to send in GitHub issues if you find them.
  3. My code uses lots and lots of action lists. If you're a mostly function-based softcoder, you're on your own.

## INSTALLATION GUIDE - PennMUSH
  1. This readme assumes you at least know the basics of what you're doing by installing softcode and running a game, have a host, know how to get the game running and back it up, edit its files, etc. If you don't, I'd suggest checking out these fine people over at M*U*S*H, PennMUSH's development/social hangout establishment, available at: http://mush.pennmush.org/ - most coders there could easily get you going in a flash.

  Be sure you are saving the cnf files with UNIX (LF) linebreaks if you're on Windows! I recommend notepad++ for the job.
  2. Examine your mush.cnf, make sure it has the following:
     * Event Handler and Ancestors will be handled by the #1 Startup - leave these alone.
     * function_invocation_limit 100000
     * queue_entry_cpu_time 4500
     * null_eq_zero yes
     * pueblo yes
     * Under the help section, comment out ahelp, anews, and news.
  3. Recommendations in mush.cnf: These are not NECESSARY, but are nice to have.
     * mud_name - set it to something short but respectable, it'll be showing up in my code a lot!
     * Uncomment all the dump_* messages and then clear dump_complete - this'll get rid of that annoying 'GAME: Save Complete.'
     * Instead of using the built-in txt files, create in-game objects and put the displays there? It'll protect them from Git updates and lets you use ANSI and softcode displays!
     * player_name_spaces yes
     * page_aliases yes
     * Under Flags section: You may also want to include ANSI and COLOR256 as a default but some clients might barf at this.
  4. In your restart file, uncomment and ensure your LANG=en_US if you want to take advantage of the expanded charset. Little requires this, but it does allow accented names and some other tricks. Some server OSes might need the ISO version of en_US specified: LANG=en_US.ISO-8859-1
  5. Logon to your code-WIZARD character who will own the code. Run the CORE 01 file from PennMUSH folder to create the Core Code Parent.
  6. Next, logon to #1 and run CORE 02.
  7. Return to your WIZARD character and run CORE 03, CORE 04, and CORE 05.
  8. @shutdown/reboot to make sure all of the STARTUPS are working.
  9. At this point, you can choose to install whatever you want.
  10. Use +gameconfig to configure all relevant settings as appropriate to your game.
  11. Have fun!

## INSTALLATION GUIDE - RhostMUSH
1. This readme assumes you at least know the basics of what you're doing by installing softcode and running a game, have a host, know how to get the game running and back it up, edit its files, etc. If you don't, I'd suggest checking out these fine people over at M*U*S*H, PennMUSH's development/social hangout establishment, available at: http://mush.pennmush.org/ - most coders there could easily get you going in a flash. Even if you're using RhostMUSH.

Be sure you are saving the .conf files with UNIX linebreaks if you're on Windows! I recommend notepad++ for the job.

netrhost.conf options:
A) includenest 15
B) includecount 50

Steps:
1. Logon to your Immortal character who will own the code. Run the CORE 01 file to create the Core Code Parent.
2. Run CORE 02. Unlike Penn this will be run off the same character, not #1.
3. Run CORE 03, CORE 04, and CORE 05
4. @reboot to make sure all of the STARTUPS are working.

Why does it not need a lot of modifications to netrhost.conf? Because the CORE 02 startup does all of that! Handy!

5. At this point, you can choose to install whatever you want. HOWEVER, do note that the helpfiles for each system are included in the system's file. If you want to use my Help System, install it FIRST. This will ensure the helpfiles are entered as the systems are installed.

6. Use +gameconfig to configure all relevant settings as appropriate to your game.

7. Have fun!