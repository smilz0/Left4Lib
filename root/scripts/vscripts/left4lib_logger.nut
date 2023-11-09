//------------------------------------------------------
//     Author : smilzo
//     https://steamcommunity.com/id/smilz0
//------------------------------------------------------
/*
	Little class for logging to console.
*/

IncludeScript("left4lib_consts");

class Left4Logger
{
	constructor(name)
	{
		_name = name;
	}

	function LogLevel(newLogLevel)
	{
		_logLevel = newLogLevel;
	}

	function Error(text)
	{
		if (_logLevel >= LOG_LEVEL_ERROR)
			error("[" + _name + "][ERROR] " + text + "\n");
	}
	
	function Warning(text)
	{
		if (_logLevel >= LOG_LEVEL_WARN)
			error("[" + _name + "][WARNING] " + text + "\n");
	}
	
	function Info(text)
	{
		if (_logLevel >= LOG_LEVEL_INFO)
			printl("[" + _name + "][INFO] " + text);
	}
	
	function Debug(text)
	{
		if (_logLevel >= LOG_LEVEL_DEBUG)
			printl("[" + _name + "][DEBUG] " + text);
	}
	
	_name = "";
	_logLevel = LOG_LEVEL_INFO;
}
