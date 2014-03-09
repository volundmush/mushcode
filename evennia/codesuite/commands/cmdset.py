"""
Example command set template module.

To create new commands to populate the cmdset, see
examples/command.py.

To extend the character command set:
  - copy this file up one level to gamesrc/commands and name it
    something fitting.
  - change settings.CMDSET_CHARACTER to point to the new module's
    CharacterCmdSet class
  - import/add commands at the end of CharacterCmdSet's add() method.

To extend Player cmdset:
  - like character set, but point settings.PLAYER on your new cmdset.

To extend Unloggedin cmdset:
  - like default set, but point settings.CMDSET_UNLOGGEDIN on your new cmdset.

To add a wholly new command set:
  - copy this file up one level to gamesrc/commands and name it
    something fitting.
  - add a new cmdset class
  - add it to objects e.g. with obj.cmdset.add(path.to.the.module.and.class)

"""

from ev import CmdSet, Command
from ev import default_cmds
from . cmdmultidesc import CmdMultiDesc
from . cmdinfo import CmdInfo
from . cmdthink import CmdThink
from . useradmin import CmdAccountList,CmdIP
from . uncmdconnect import CmdUnconnectedConnect as CmdNewConnect
from src.commands.default import unloggedin
from . cmdjob import CmdJob
from . cmdchannel import SystemSendToChannel,CmdChannel,CmdCTitle,CmdCRename,CmdCMode,CmdCMuzzle
from . cmdtalk import CmdSay,CmdEmit,CmdPose,CmdSemiPose,CmdOTalk

#from contrib import menusystem, lineeditor
#from contrib import misc_commands
#from contrib import chargen

class CharacterCmdSet(default_cmds.CharacterCmdSet):
    """
    This is an example of how to overload the default command
    set defined in src/commands/default/cmdset_character.py.

    Here we copy everything by calling the parent, but you can
    copy&paste any combination of the default command to customize
    your default set. Next you change settings.CMDSET_CHARACTER to point
    to this class.
    """
    key = "DefaultCharacter"

    def at_cmdset_creation(self):
        """
        Populates the cmdset
        """
        # calling setup in src.commands.default.cmdset_character
        super(CharacterCmdSet, self).at_cmdset_creation()
        #
        # any commands you add below will overload the default ones.
        #
        #self.add(menusystem.CmdMenuTest())
        #self.add(lineeditor.CmdEditor())
        #self.add(misc_commands.CmdQuell())
        self.add(CmdMultiDesc())
        self.add(CmdPose())
        self.add(CmdSemiPose())
        self.add(CmdSay())
        self.add(CmdEmit())
        self.add(CmdOTalk())
        
class UnloggedinCmdSet(default_cmds.UnloggedinCmdSet):
    """
    This is an example of how to overload the command set of the
    unloggedin commands, defined in
    src/commands/default/cmdset_unloggedin.py.

    Here we copy everything by calling the parent, but you can
    copy&paste any combination of the default command to customize
    your default set. Next you change settings.CMDSET_UNLOGGEDIN to
    point to this class.
    """
    key = "DefaultUnloggedin"

    def at_cmdset_creation(self):
        """
        Populates the cmdset
        """
        # calling setup in src.commands.default.cmdset_unloggedin
        super(UnloggedinCmdSet, self).at_cmdset_creation()
        self.remove(unloggedin.CmdUnconnectedConnect())
        self.add(CmdNewConnect())
        #
        # any commands you add below will overload the default ones.
        #

class PlayerCmdSet(default_cmds.PlayerCmdSet):
    """
    This is set is available to the player when they have no
    character connected to them (i.e. they are out-of-character, ooc).
    """
    key = "DefaultPlayer"

    def at_cmdset_creation(self):
        """
        Populates the cmdset
        """
        # calling setup in src.commands.default.cmdset_ooc
        super(PlayerCmdSet, self).at_cmdset_creation()
        #
        # any commands you add below will overload the default ones.
        #
        self.add(SystemSendToChannel())
        self.add(CmdChannel())
        self.add(CmdCTitle())
        self.add(CmdCRename())
        self.add(CmdCMode())
        self.add(CmdCMuzzle())
        self.add(CmdInfo())
        self.add(CmdThink())
        self.add(CmdAccountList())
        self.add(CmdIP())
        self.add(CmdJob())