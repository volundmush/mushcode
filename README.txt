Volund's MUSHcode Suite - For PennMUSH

-=--=--=--=--=--=--=--=--=--=-<* CONTACT INFO *>-=--=--=--=--=--=--=--=--=--=-
Name: Volund
Email: volundmush@gmail.com

-=--=--=--=--=--=--=--=--=--=--<* DISCLAIMER *>--=--=--=--=--=--=--=--=--=--=-
LICENSE for using Volund's MUSHcode Suite
Terms

"Softcode" refers to the contents of every file in this package with the exception of Myrddin's MUSH Cron and the patches for Mercutio's SceneSys and Javelin's Anomaly Jobs. (All hail them and their fine authors!) "Game" refers to any copy of PennMUSH or similar program it's running on.

CONDITIONS
1) This Softcode is provided as-is, with no Warranty - express or implied. The author is not responsible for any possible damages, etc.

2) This Softcode is freely available to all under the terms of the Creative Commons Attribution-Non-Commercial 3.0 Unported License:
http://creativecommons.org/licenses/by-nc/3.0/deed
In other words:
	A) you must give credit where it's due. Please be sure to credit me - Volund - on your game, and link back to my Github: https://github.com/volundmush/mushcode
	B) You may share, alter, remix, port, copy the softcode however you wish. If you release any derivatives of my work it must be under the terms set down in this text.
	C) You may not market the Softcode commercially or use it on games that are pay-to-play.

Support is limited by my time and energy, but it's my goal to provide an easy-to-use and expansive suite of MUSHcode for all fans of the gaming platform to enjoy. If you have questions, bug reports, or feature requests, please email them to me at the address given above.

-=--=--=--=--=--=--=--=--=--=-<* REQUIREMENTS *>-=--=--=--=--=--=--=--=--=--=-
1) PennMUSH 1.8.5p5 or higher - much of my code requires @dolist to have /inline and /nobreak switches and a few bug fixes only available from then on. You can obtain the latest version here: https://code.google.com/p/pennmush/
2) A WIZARD character to install and maintain the code. (do NOT use #1 for this except where specified!)
3) In mush.cnf, under TinyMUSH compatability, null_eq_zero must be 'Yes.'
4) Ideally, access to #1's STARTUP - you'll need to get creative - or lucky - without it.

-=--=--=--=--=--=--=--=--=--=--=<* FEATURES *>=--=--=--=--=--=--=--=--=--=--=-
ADMINISTRATION: The suite includes a player account system and extended staff permissions infrastructure, alongside a variety of tools to extend and simplify @locks and security, managing building rights, track the game's statistics and so on. The code is well-structured and easy to follow, and more importantly, easy to alter.

CONVENIENCE: A plethora of player globals and conveniences, such as multi-descer, personal color scheme configurations, +beep, and +who.

COMMUNICATIONS: Extensions to Penn's built-in @channels code for finer access, configuration, and usability. A multi-frequency +radio system, a replacement for Myrddin's BBS that retains all its original functional and identical syntax but brings a host of new features.

COMMUNITY AND GROUPS: A highly configurable group/organization system's included, supporting ranks, communications, boards (drawing off the global BBS). Players can 'friend lists.'

DOCUMENTATION: The code is largely self-commenting by structure, and comes with easily inserted +help files for the softcoded help system, pre-written and ready to go. Said system also comes with a Staff help menu (+shelp) and +news/news menu - and adding more is easy. Documentation goes the extra mile to try and explain basic MUSHing principles to newbies.

GRID AND NAVIGATION: An ancestor room with an easy on the eyes but distinguished color scheme. A player teleport nexus command for easy navigation, along with ever-popular +meetme and other conveniences. Staff can easily create areas, restrict them to given groups, and etc.

INTEGRATION WITH COMMON SYSTEMS: Patches are provided to make the ever-popular Anomaly Jobs and Mercutio's SceneSys compatible with this code.

-=--=--=--=--=--=--=--=--<* COMPLICATIONS AND BUGS *>--=--=--=--=--=--=--=--=-
1. This code is not designed to get along with anyone else's out of the box, nor was it designed alongside anyone else's for the most part. It provides and relies on its own Event Handler, ancestors, etc. In short, it's designed to help start a new game up, and you're on your own if trying to adapt it to an established one.

2. Some bugs likely remain as this is my first big project. I'm confident folk'll find it useful but everything always needs refinement. The most bugs probably lurk in the group system, so be on the lookout for them and email me your findings so I can fix 'em!

3. My code uses lots and lots of action lists. If you're a mostly function-based softcoder, you're on your own.

-=--=--=--=--=--=--=--=--=--<* RECOMMENDATIONS *>=--=--=--=--=--=--=--=--=--=-
1. This readme assumes you at least know the basics of what you're doing by installing softcode and running a game, have a host, know how to get the game running and back it up, edit its files, etc. If you don't, I'd suggest checking out these fine people over at M*U*S*H, PennMUSH's development/social hangout establishment, available at: http://mush.pennmush.org/ - most coders there could easily get you going in a flash.

2. Examine your mush.cnf, make sure it has the following:
A) mud_name - set it to something short but respectable, it'll be showing up in my code a lot!
B) I usually turn off database compression entirely as a habit to remove a layer of complexity from the crucial dump process after hearing a horror story from one very unlucky game whose install of gzip turned on them. (Lesson to learn: BACKUPS!)
C) Event Handler and Ancestors will be handled by the #1 Startup - leave these alone.
D) Uncomment all the dump_* messages and then clear dump_complete - this'll get rid of that annoying 'GAME: Save Complete.'
E) Instead of using the built-in txt files, why not create TXT`<name> attributes on the PennMUSH configuration object and link these to those when you do? It'll protect them from SVN updates and lets you use ANSI and softcode displays! As an example, once the PCO's installed (let's say as DBREF #8), if you wanted to make a softcoded connect screen you could set connect_file to #8/TXT`CONNECT, then whatever you put in the TXT`CONNECT attribute will be evaluated and shown to folk connecting.
F) Under the help section, comment out ahelp, anews, and news.
G) Under Logins: enable Pueblo - much of my code is clickable to people using Pueblo, though those few are rare indeed.
H) Under Cosmetic stuff: player_name_spaces - set this to yes.
I) Under cosmetic stuff: set page_aliases to yes
J) Under Flags section: If your game allows players to create but need approval before they can join play, ensure that player_flags includes UNREGISTERED. You may also want to include ANSI and COLOR256 as a default but some clients might barf at this.

3. In your restart.cnf, uncomment and ensure your LANG=en_US if you want to take advantage of the expanded charset. Little requires this, but you'll want it for Mercutio's SceneSys and it's a nice convenience. Some server OSes might need the ISO version of en_US specified.

Be sure you are saving the cnf files with UNIX linebreaks if you're on Windows! I recommend notepad++ for the job.

-=--=--=--=--=--=--=--=--=--=-<* INSTRUCTIONS *>-=--=--=--=--=--=--=--=--=--=-
1. Ensure you meet all the requirements. @version in-game to check!

2. Open the CORE 01 file to create the Object Indexer. You'll need to set the given STARTUP attribute on #1 and parent it to the Code Object Index <COI> once it's created. Make sure your WIZARD character also properly parents to the Code Object Index <COI>! Without that the install scripts won't work at all. (this should be done automatically, but verify it.)

3. Copy and paste the contents of the other CORE files in sequence into your client window and let the commands run. This will create and prepare the code objects and link them with the indexer.

4. @shutdown/reboot - and watch the magic. The #1 STARTUP script should detect all of the changes and create all the global functions, set the ancestors and save to mush.cnf, etc.

5. The help files (including staff help) are in HELP FILES.txt Run the whole file to install them.

6. Use +shelp and +help to brush up on administrating the package and your options.

Install the other files as you please.

-=--=--=--=--=--=--=--=--=--=--<* Donations *>=--=--=--=--=--=--=--=--=--=--=-
While the code is all free, if anyone who finds it useful is of a mind to donate and support my work, consider donating to my PayPal? volundmush@gmail.com