//------------------------------------------------------
//     Author : smilzo
//     https://steamcommunity.com/id/smilz0
//------------------------------------------------------

IncludeScript("left4lib_consts");
IncludeScript("left4lib_utils");

// Log levels
const LOG_LEVEL_NONE = 0; // Log always
const LOG_LEVEL_ERROR = 1;
const LOG_LEVEL_WARN = 2;
const LOG_LEVEL_INFO = 3;
const LOG_LEVEL_DEBUG = 4;

if (!("Left4Lib" in getroottable()))
{
	::Left4Lib <-
	{
		Initialized = false
		Settings =
		{
			users_file_admins = "left4lib/cfg/admins.txt"
			users_file_friends = "left4lib/cfg/friends.txt"
			users_file_griefers = "left4lib/cfg/griefers.txt"
			users_max_human_players = -1
			//users_full_kick_reason = "Sorry, server is full at the moment"
			users_full_kick_reason = ""
			hooks_chatcommand_trigger = "!"
			hooks_chatcommand_hide = true
		}
	}

	::Left4Lib.Log <- function (level, text)
	{
		//if (level > Left4Lib.Settings.loglevel)
		//	return;
		
		if (level == LOG_LEVEL_DEBUG)
			printl("[L4L][DEBUG] " + text);
		else if (level == LOG_LEVEL_INFO)
			printl("[L4L][INFO] " + text);
		else if (level == LOG_LEVEL_WARN)
			error("[L4L][WARNING] " + text + "\n");
		else if (level == LOG_LEVEL_ERROR)
			error("[L4L][ERROR] " + text + "\n");
		else
			error("[L4L][" + level + "] " + text + "\n");
	}
	
	// Left4Lib main initialization function
	::Left4Lib.Initialize <- function ()
	{
		if (Left4Lib.Initialized)
		{
			Left4Lib.Log(LOG_LEVEL_DEBUG, "Already initialized");
			return;
		}
		
		Left4Lib.Log(LOG_LEVEL_INFO, "Loading settings...");
		Left4Utils.LoadSettingsFromFile("left4lib/cfg/settings.txt", "Left4Lib.Settings.", Left4Lib.Log);
		Left4Utils.SaveSettingsToFile("left4lib/cfg/settings.txt", ::Left4Lib.Settings, Left4Lib.Log);
		Left4Utils.PrintSettings(::Left4Lib.Settings, Left4Lib.Log, "[Settings] ");
		
		Left4Lib.Initialized = true;
	}
	
	::Left4Lib.SaveSettings <- function ()
	{
		Left4Utils.SaveSettingsToFile("left4lib/cfg/settings.txt", ::Left4Lib.Settings, Left4Lib.Log);
		Left4Lib.Log(LOG_LEVEL_INFO, "Settings Saved");
	}
	
	Left4Lib.Initialize();
}
