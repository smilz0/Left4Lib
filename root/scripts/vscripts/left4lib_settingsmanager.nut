//------------------------------------------------------
//     Author : smilzo
//     https://steamcommunity.com/id/smilz0
//------------------------------------------------------
/*
	You shouldn't use this. It's for L4L internal use for the 'left4lib_hooks' and 'left4lib_users' settings ('ems/left4lib/cfg/settings.txt' file).
*/

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
	}
	
	IncludeScript("left4lib_settings");
	
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
