==========================<* Installing SceneSys *>===========================
Hopefully you've read the README for the Codesuite 2.0 by the time you're reading this. If not, go read it now. This can wait.

Done reading it? Okay, good. Get ready for a headache.

So you want to install SceneSys. It's easier said than done. In order to do this, you're going to need some familiarity with configuring webservers, editing PHP files, and both installing and configuring MediaWiki... or help from someone who can do that. This is in fact pretty difficult and will be until some better method of packaging it can be discovered.

Unlike the main package installation I can't hold your hand through this one. You'll have to find resources of your own that fit your situation. Google.com is a lifesaver.

If you need help with topics such as installing MySQL, a webserver, and Mediawiki, the fine folks at M*U*S*H (mush.pennmush.org 4201) might be able to offer guidance.

==============================<* Requirements *>==============================
1) A webhost that can run MediaWiki and the PHP scene listing site. This should IDEALLY be the same server that your game's running on.
2) MySQL. No other SQL server will do.
3) MediaWiki.
4) MediaWiki Extensions: Semantic MediaWiki (install it using Composer or you'll have dependency issues!), Semantic Compound Queries, Semantic Forms, CSS, External Data, Header Tabs, MagicNoCache, RegexFunctions, ParserFunctions.
5) RECOMMENDED: Put a Captcha on the Wiki using ConfirmEdit and enable the SpamBlacklist. Otherwise, beware the spambots.

==============================<* Instructions *>==============================
1) Install your webserver and mediawiki.
2) In addition to the privileged MySQL user account used by Mediawiki and your MUSH, create one that has only SELECT privileges. This is insurance in case the PHP code can be exploited.
3) Install the Extensions. If this is a fresh install of mediawiki, I recommend installing Semantic Mediawiki first. You can find 'git clone' commands for everything else - meant to be run from within your wiki's extensions directory - at the bottom of this text file, as well as some example configuration data. Use the SELECT-only MySql account for the External Data settings.
5) Go to your wiki's Special:Import page and upload scenesys_volund_pages.xml
6) Copy the 'scene' directory in this folder to somewhere your webserver can serve it up.
7) Edit the db.php file in the scene directory to use the proper MySQL settings. This is where that SELECT-only account comes in handy.
8) Open up view.php in the scene directory and find, near the bottom line, the following: <form action="../mw/index.php/Special:FormEdit/Roleplaying Log/<?php echo $num.'/'.$title['scene_title'] ?>" method="POST"> - it should be line 151. You'll have to edit this to point at your wiki.
9) You will need to edit several pages. The Logs page will need monthly updating for new tabs, you will likely want to change the character template drastically, and the character creation form.
10) ???
11) Profit!

===============================<* Resources *>================================

git clone https://git.wikimedia.org/git/mediawiki/extensions/CSS.git
git clone https://git.wikimedia.org/git/mediawiki/extensions/RegexFunctions.git
git clone https://git.wikimedia.org/git/mediawiki/extensions/Variables.git
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/SemanticCompoundQueries.git
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/SemanticResultFormats.git
git clone https://git.wikimedia.org/git/mediawiki/extensions/SemanticForms.git
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/ExternalData.git
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/MagicNoCache.git
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/ReplaceText.git
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/HeaderTabs.git

# Semantic Mediawiki
enableSemantics('example.org');

# Semantic Comound Queries
include_once( "$IP/extensions/SemanticCompoundQueries/SemanticCompoundQueries.php");

# Semantic Forms
include_once("$IP/extensions/SemanticForms/SemanticForms.php");

# Confirm Account
require_once("$IP/extensions/ConfirmAccount/ConfirmAccount.php");

# Rename User
require_once("$IP/extensions/Renameuser/Renameuser.php");

# Replace Text
require_once("$IP/extensions/ReplaceText/ReplaceText.php");

# CSS
require_once("$IP/extensions/CSS/CSS.php");

# External Data
include_once("$IP/extensions/ExternalData/ExternalData.php");
$edgDBServer['scenesys'] = "localhost";
$edgDBServerType['scenesys'] = "mysql"; 
$edgDBName['scenesys'] = "DB name";
$edgDBUser['scenesys'] = "username";
$edgDBPass['scenesys'] = "password";

# Header Tabs
require_once("$IP/extensions/HeaderTabs/HeaderTabs.php");

# MagicNoCache
require_once "$IP/extensions/MagicNoCache/MagicNoCache.php";

# RegexFunctions
require_once("$IP/extensions/RegexFunctions/RegexFunctions.php");

# ConfirmEdit
require_once("$IP/extensions/ConfirmEdit/ConfirmEdit.php");

# WikiEditor
require_once("$IP/extensions/WikiEditor/WikiEditor.php");
# Enables use of WikiEditor by default but still allow users to disable it in preferences
$wgDefaultUserOptions['usebetatoolbar'] = 1;
$wgDefaultUserOptions['usebetatoolbar-cgd'] = 1;
 
# Displays the Preview and Changes tabs
$wgDefaultUserOptions['wikieditor-preview'] = 1;
 
# Displays the Publish and Cancel buttons on the top right side
$wgDefaultUserOptions['wikieditor-publish'] = 1;

# Parser Functions
require_once("$IP/extensions/ParserFunctions/ParserFunctions.php");
$wgPFEnableStringFunctions = true;

# Variables
require_once("$IP/extensions/Variables/Variables.php");