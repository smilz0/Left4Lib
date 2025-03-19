//------------------------------------------------------
//     Author : smilzo
//     https://steamcommunity.com/id/smilz0
//------------------------------------------------------
/*
	You shouldn't use this. It's for L4L internal use for the 'left4lib_hooks' and 'left4lib_users' settings ('ems/left4lib/cfg/settings.txt' file).
*/

IncludeScript("left4lib_logger");
IncludeScript("left4lib_utils");

if (!("Left4Lib" in getroottable()))
{
	::Left4Lib <-
	{
		Initialized = false
		//Logger = Left4Logger("L4L")
		Logger = ::Left4LibLogger.weakref() // ::Left4Lib.Logger should be replaced by ::Left4LibLogger everywhere, eventually
	}
	
	IncludeScript("left4lib_settings");
	
	::Left4Lib.Log <- function (level, text)
	{
		printl("[ERROR] TODO: replace with Logger: " + text);
	}
	
	// Left4Lib main initialization function
	::Left4Lib.Initialize <- function ()
	{
		if (Left4Lib.Initialized)
		{
			Logger.Debug("Already initialized");
			return;
		}
		
		Logger.Info("Loading settings...");
		Left4Utils.LoadSettingsFromFileNew("left4lib/cfg/settings.txt", "Left4Lib.Settings.", Logger);
		Logger.LogLevel(Settings.loglevel);
		Left4Utils.SaveSettingsToFileNew("left4lib/cfg/settings.txt", Settings, Logger);
		Left4Utils.PrintSettingsNew(Settings, Logger, "[Settings] ");

		Left4Lib.Initialized = true;
	}
	
	::Left4Lib.SaveSettings <- function ()
	{
		Left4Utils.SaveSettingsToFileNew("left4lib/cfg/settings.txt", Settings, Logger);
		Logger.Info("Settings Saved");
	}

	Left4Lib.Initialize();
}
