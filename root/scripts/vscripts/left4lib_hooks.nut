//------------------------------------------------------
//     Author : smilzo
//     https://steamcommunity.com/id/smilz0
//------------------------------------------------------
/*
	Handles the C++ -> VScript game hooks.
	
	NOTE: ::HooksHub isn't available until another addon includes this script.
	
	To use add:
		IncludeScript("left4lib_hooks");
	on top of your script.
	
	NOTE2: This script requires an initialization via:
		HooksHub.Init();
	to work.
	If ::HooksHub exists (because the script was included by another script), the 'Init' function is automatically called upon director initialization ( via 'director_base_addon.nut' )
	and 'OnGameEvent_round_start'. So you are supposed to include this script before these events or you will need to call the Init function manually.
	
	This script acts as a 'dispatcher' for game hooks allowing more than one vscript to receive the hooks.
	The hooks are:
		InterceptChat
		AllowTakeDamage
		AllowBash
		UserConsoleCommand
		BotQuery
		CanPickupObject
	The script replaces any active hook vscript functions with its own functions and calls the hook functions of the scripts that registered, one after the other, when then main hook is called by C++.
	
	You register/unregister your hooks to HooksHub with:
		HooksHub.SetInterceptChat(key, func);
		HooksHub.RemoveInterceptChat(key);
		HooksHub.SetAllowTakeDamage(key, func);
		HooksHub.RemoveAllowTakeDamage(key);
		HooksHub.SetAllowBash(key, func);
		HooksHub.RemoveAllowBash(key);
		HooksHub.SetUserConsoleCommand(key, func);
		HooksHub.RemoveUserConsoleCommand(key);
		HooksHub.SetBotQuery(key, func);
		HooksHub.RemoveBotQuery(key);
		HooksHub.SetCanPickupObject(key, func);
		HooksHub.RemoveCanPickupObject(key);
	
	Your hook's 'key' must be an unique key that identifies your addon/script (for example i use 'L4F' in Left 4 Fun, 'L4B' in Left 4 Bots and so on).
	If your 'func' is on the root table, its name must be different from the one of the hook.
	For example it can be something like this:
		::MyAllowTakeDamage <- function (damageTable)
		{
		}
	or this:
		::Left4Fun.AllowTakeDamage <- function (damageTable)
		{
		}
	but not this:
		::AllowTakeDamage <- function (damageTable)
		{
		}
	
	CUSTOM CHAT/CONSOLE COMMANDS
	For receiving chat/console commands for your script, consider using:
		HooksHub.SetChatCommandHandler(key, func);
		HooksHub.SetConsoleCommandHandler(key, func);
		HooksHub.RemoveChatCommandHandler(key);
		HooksHub.RemoveConsoleCommandHandler(key);
	instead of registering for the InterceptChat hook. You can also use the same function for both the chat and console commands as the two 'func' have the same parameters.
	
	'key' is always your unique addon/script key and will also be the trigger for your commands (!key command - scripted_user_func key,command).
	'func' is a function like this:
		::Left4Bots.HandleCommand <- function (player, cmd, args, text)
		{
			// 'player' is the entity of the player who sent the command
			// 'cmd' is the first argument after the key
			// 'args' is the full list of arguments (including the trigger and the command)
			// 'text' is the entire command string
		}
*/

IncludeScript("left4lib_consts");
IncludeScript("left4lib_settingsmanager");

if (!("HooksHub" in getroottable()))
{
	::HooksHub <-
	{
		InterceptChatFuncs = {}
		AllowTakeDamageFuncs = {}
		AllowBashFuncs = {}
		UserConsoleCommandFuncs = {}
		BotQueryFuncs = {}
		CanPickupObjectFuncs = {}
		ChatCommandHandlers = {}
		ConsoleCommandHandlers = {}
		Events = {}
	}

	::HooksHub.SetInterceptChat <- function (key, func)
	{
		::HooksHub.InterceptChatFuncs[key] <- func;
	}
	
	::HooksHub.RemoveInterceptChat <- function (key)
	{
		if (key in ::HooksHub.InterceptChatFuncs)
			delete ::HooksHub.InterceptChatFuncs[key];
	}
	
	::HooksHub.HasInterceptChat <- function (key)
	{
		return (key in ::HooksHub.InterceptChatFuncs);
	}
	
	::HooksHub.GetInterceptChatByFunc <- function (func)
	{
		foreach (key, val in ::HooksHub.InterceptChatFuncs)
		{
			if (val == func)
				return key;
		}
		return null;
	}
	
	::HooksHub.SetAllowTakeDamage <- function (key, func)
	{
		::HooksHub.AllowTakeDamageFuncs[key] <- func;
	}
	
	::HooksHub.RemoveAllowTakeDamage <- function (key)
	{
		if (key in ::HooksHub.AllowTakeDamageFuncs)
			delete ::HooksHub.AllowTakeDamageFuncs[key];
	}
	
	::HooksHub.HasAllowTakeDamage <- function (key)
	{
		return (key in ::HooksHub.AllowTakeDamageFuncs);
	}
	
	::HooksHub.GetAllowTakeDamageByFunc <- function (func)
	{
		foreach (key, val in ::HooksHub.AllowTakeDamageFuncs)
		{
			if (val == func)
				return key;
		}
		return null;
	}
	
	::HooksHub.SetAllowBash <- function (key, func)
	{
		::HooksHub.AllowBashFuncs[key] <- func;
	}
	
	::HooksHub.RemoveAllowBash <- function (key)
	{
		if (key in ::HooksHub.AllowBashFuncs)
			delete ::HooksHub.AllowBashFuncs[key];
	}
	
	::HooksHub.HasAllowBash <- function (key)
	{
		return (key in ::HooksHub.AllowBashFuncs);
	}
	
	::HooksHub.GetAllowBashByFunc <- function (func)
	{
		foreach (key, val in ::HooksHub.AllowBashFuncs)
		{
			if (val == func)
				return key;
		}
		return null;
	}
	
	::HooksHub.SetUserConsoleCommand <- function (key, func)
	{
		::HooksHub.UserConsoleCommandFuncs[key] <- func;
	}
	
	::HooksHub.RemoveUserConsoleCommand <- function (key)
	{
		if (key in ::HooksHub.UserConsoleCommandFuncs)
			delete ::HooksHub.UserConsoleCommandFuncs[key];
	}
	
	::HooksHub.HasUserConsoleCommand <- function (key)
	{
		return (key in ::HooksHub.UserConsoleCommandFuncs);
	}
	
	::HooksHub.GetUserConsoleCommandByFunc <- function (func)
	{
		foreach (key, val in ::HooksHub.UserConsoleCommandFuncs)
		{
			if (val == func)
				return key;
		}
		return null;
	}
	
	::HooksHub.SetBotQuery <- function (key, func)
	{
		::HooksHub.BotQueryFuncs[key] <- func;
	}
	
	::HooksHub.RemoveBotQuery <- function (key)
	{
		if (key in ::HooksHub.BotQueryFuncs)
			delete ::HooksHub.BotQueryFuncs[key];
	}
	
	::HooksHub.HasBotQuery <- function (key)
	{
		return (key in ::HooksHub.BotQueryFuncs);
	}
	
	::HooksHub.GetBotQueryByFunc <- function (func)
	{
		foreach (key, val in ::HooksHub.BotQueryFuncs)
		{
			if (val == func)
				return key;
		}
		return null;
	}
	
	::HooksHub.SetCanPickupObject <- function (key, func)
	{
		::HooksHub.CanPickupObjectFuncs[key] <- func;
	}
	
	::HooksHub.RemoveCanPickupObject <- function (key)
	{
		if (key in ::HooksHub.CanPickupObjectFuncs)
			delete ::HooksHub.CanPickupObjectFuncs[key];
	}
	
	::HooksHub.HasCanPickupObject <- function (key)
	{
		return (key in ::HooksHub.CanPickupObjectFuncs);
	}
	
	::HooksHub.GetCanPickupObjectByFunc <- function (func)
	{
		foreach (key, val in ::HooksHub.CanPickupObjectFuncs)
		{
			if (val == func)
				return key;
		}
		return null;
	}
	
	::HooksHub.SetChatCommandHandler <- function (key, func)
	{
		::HooksHub.ChatCommandHandlers[key] <- func;
	}
	
	::HooksHub.RemoveChatCommandHandler <- function (key)
	{
		if (key in ::HooksHub.ChatCommandHandlers)
			delete ::HooksHub.ChatCommandHandlers[key];
	}
	
	::HooksHub.HasChatCommandHandler <- function (key)
	{
		return (key in ::HooksHub.ChatCommandHandlers);
	}
	
	::HooksHub.GetChatCommandHandlerByFunc <- function (func)
	{
		foreach (key, val in ::HooksHub.ChatCommandHandlers)
		{
			if (val == func)
				return key;
		}
		return null;
	}
	
	::HooksHub.SetConsoleCommandHandler <- function (key, func)
	{
		::HooksHub.ConsoleCommandHandlers[key] <- func;
	}
	
	::HooksHub.RemoveConsoleCommandHandler <- function (key)
	{
		if (key in ::HooksHub.ConsoleCommandHandlers)
			delete ::HooksHub.ConsoleCommandHandlers[key];
	}
	
	::HooksHub.HasConsoleCommandHandler <- function (key)
	{
		return (key in ::HooksHub.ConsoleCommandHandlers);
	}
	
	::HooksHub.GetConsoleCommandHandlerByFunc <- function (func)
	{
		foreach (key, val in ::HooksHub.ConsoleCommandHandlers)
		{
			if (val == func)
				return key;
		}
		return null;
	}

	::HooksHub.DbgPrintFuncs <- function ()
	{
		::Left4Lib.Logger.Debug("HooksHub.DbgPrintFuncs - ::HooksHub.InterceptChat = " + ::HooksHub.InterceptChat);
		::Left4Lib.Logger.Debug("HooksHub.DbgPrintFuncs - ::HooksHub.AllowTakeDamage = " + ::HooksHub.AllowTakeDamage);
		::Left4Lib.Logger.Debug("HooksHub.DbgPrintFuncs - ::HooksHub.AllowBash = " + ::HooksHub.AllowBash);
		::Left4Lib.Logger.Debug("HooksHub.DbgPrintFuncs - ::HooksHub.UserConsoleCommand = " + ::HooksHub.UserConsoleCommand);
		::Left4Lib.Logger.Debug("HooksHub.DbgPrintFuncs - ::HooksHub.BotQuery = " + ::HooksHub.BotQuery);
		::Left4Lib.Logger.Debug("HooksHub.DbgPrintFuncs - ::HooksHub.CanPickupObject = " + ::HooksHub.CanPickupObject);
		
		foreach (key, val in ::HooksHub.InterceptChatFuncs)
			::Left4Lib.Logger.Debug("HooksHub.DbgPrintFuncs - InterceptChatFuncs[" + key + "] = " + val);
			
		foreach (key, val in ::HooksHub.AllowTakeDamageFuncs)
			::Left4Lib.Logger.Debug("HooksHub.DbgPrintFuncs - AllowTakeDamageFuncs[" + key + "] = " + val);
			
		foreach (key, val in ::HooksHub.AllowBashFuncs)
			::Left4Lib.Logger.Debug("HooksHub.DbgPrintFuncs - AllowBashFuncs[" + key + "] = " + val);
			
		foreach (key, val in ::HooksHub.UserConsoleCommandFuncs)
			::Left4Lib.Logger.Debug("HooksHub.DbgPrintFuncs - UserConsoleCommandFuncs[" + key + "] = " + val);
			
		foreach (key, val in ::HooksHub.BotQueryFuncs)
			::Left4Lib.Logger.Debug("HooksHub.DbgPrintFuncs - BotQueryFuncs[" + key + "] = " + val);
			
		foreach (key, val in ::HooksHub.CanPickupObjectFuncs)
			::Left4Lib.Logger.Debug("HooksHub.DbgPrintFuncs - CanPickupObjectFuncs[" + key + "] = " + val);
		
		foreach (key, val in ::HooksHub.ChatCommandHandlers)
			::Left4Lib.Logger.Debug("HooksHub.DbgPrintFuncs - ChatCommandHandlers[" + key + "] = " + val);
			
		foreach (key, val in ::HooksHub.ConsoleCommandHandlers)
			::Left4Lib.Logger.Debug("HooksHub.DbgPrintFuncs - ConsoleCommandHandlers[" + key + "] = " + val);
	}
	
	::HooksHub.InterceptChat <- function (msg, speaker)
	{
		local ret = true;
		local r = null;
		foreach (key, func in ::HooksHub.InterceptChatFuncs)
		{
			try
			{
				r = func(msg, speaker);
			}
			catch(exception)
			{
				::Left4Lib.Logger.Error("HooksHub.InterceptChat - Exception in func '" + key + "': " + exception);
			}

			// Global return value will be false if at least one func returns false
			if (r == false)
				ret = false;
		}

		if (speaker && speaker.IsValid())
		{
			// Removing the ending \r\n
			if (msg.find("\n", msg.len() - 1) != null || msg.find("\r", msg.len() - 1) != null)
				msg = msg.slice(0, msg.len() - 1);
			if (msg.find("\n", msg.len() - 1) != null || msg.find("\r", msg.len() - 1) != null)
				msg = msg.slice(0, msg.len() - 1);
				
			local name = speaker.GetPlayerName() + ": ";
			local text = strip(msg.slice(msg.find(name) + name.len())); // Remove the speaker's name part from the message
				
			::Left4Lib.Logger.Debug("HooksHub.InterceptChat - speaker: " + speaker.GetPlayerName() + " - text: " + text);
			
			if (::HooksHub.ChatCommandHandlers.len() > 0)
			{
				if (text.find(Left4Lib.Settings.hooks_chatcommand_trigger) == 0)
				{
					local args = split(text, " ");
					if (args.len() > 1) // Must have at least 2 arguments: "!handler command"
					{
						local handler = args[0].slice(Left4Lib.Settings.hooks_chatcommand_trigger.len());
						local command = args[1].tolower();
						
						::Left4Lib.Logger.Debug("HooksHub.InterceptChat - handler: " + handler + " - command: " + command);
						
						if (handler in ::HooksHub.ChatCommandHandlers)
						{
							try
							{
								::HooksHub.ChatCommandHandlers[handler](speaker, command, args, text);
							}
							catch(exception)
							{
								::Left4Lib.Logger.Error("HooksHub.InterceptChat - Exception in ChatCommandHandler '" + key + "': " + exception);
							}
						}
					}
					
					// If no InterceptChat func wanted to hide the chat, only hide it if the text starts with hooks_chatcommand_trigger and hooks_chatcommand_hide is 1
					if (ret && ::Left4Lib.Settings.hooks_chatcommand_hide)
						ret = false;
				}
			}
			
			if (ret && ::Left4Lib.Settings.hooks_chat_hidenames && !IsPlayerABot(speaker) && ("Left4Users" in getroottable()))
			{
				::Left4Lib.Logger.Debug("HooksHub.InterceptChat - Hiding chat name");
				ret = false;
				local speakerUserId = speaker.GetPlayerUserId();
				local speakerCharacterName = GetCharacterDisplayName(speaker);
				if (!speakerCharacterName || speakerCharacterName == "")
					speakerCharacterName = "Spectator";
				foreach (userid, usr in ::Left4Users.OnlineUsers)
				{
					if (userid != speakerUserId)
					{
						local p = g_MapScript.GetPlayerFromUserID(userid);
						if (p)
							ClientPrint(p, 3, "\x03" + speakerCharacterName + "\x01 : " + text);
					}
				}
			}
		}
		
		::Left4Lib.Logger.Debug("HooksHub.InterceptChat - ret: " + ret);
		
		return ret;
	}

	::HooksHub.AllowTakeDamage <- function (damageTable)
	{
		local ret = true;
		//local r = true;
		local r = null;
		foreach (key, func in ::HooksHub.AllowTakeDamageFuncs)
		{
			try
			{
				r = func(damageTable);
			}
			catch(exception)
			{
				::Left4Lib.Logger.Error("HooksHub.AllowTakeDamage - Exception in func '" + key + "': " + exception);
			}
			
			// If one of the AllowTakeDamage functions returned false, there's no need to run the others
			//if (r == false)
			//	return false;
			
			if (r == false)
				ret = false;
		}
		
		// Global return value will be false if at least one func returns false
		
		return ret;
	}

	::HooksHub.AllowBash <- function (basher, bashee)
	{
		local ret = ALLOW_BASH_ALL;
		local r = null;
		foreach (key, func in ::HooksHub.AllowBashFuncs)
		{
			try
			{
				r = func(basher, bashee);
			}
			catch(exception)
			{
				::Left4Lib.Logger.Error("HooksHub.AllowBash - Exception in func '" + key + "': " + exception);
			}
			
			if (r != null && r != ret)
			{
				if (r == ALLOW_BASH_NONE && ret != r)
					ret = r;
				else if (r == ALLOW_BASH_PUSHONLY && ret != r && ret != ALLOW_BASH_NONE)
					ret = r;
			}
		}
		
		// The func returning the highest return value sets the global return value - Possible values are in this order (from highest to lowest): ALLOW_BASH_NONE, ALLOW_BASH_PUSHONLY, ALLOW_BASH_ALL, null
		
		return ret;
	}
	
	::HooksHub.UserConsoleCommand <- function (playerScript, arg)
	{
		foreach (key, func in ::HooksHub.UserConsoleCommandFuncs)
		{
			try
			{
				func(playerScript, arg);
			}
			catch(exception)
			{
				::Left4Lib.Logger.Error("HooksHub.UserConsoleCommand - Exception in func '" + key + "': " + exception);
			}
		}
		
		// Return values have no meaning here
		
		if (arg != null && arg != "" && ::HooksHub.ConsoleCommandHandlers.len() > 0 && playerScript && playerScript.IsValid())
		{
			local args = split(arg, ",");
			if (args.len() > 1) // Must have at least 2 arguments: "handler,command"
			{
				local handler = args[0];
				local command = args[1].tolower();
					
				::Left4Lib.Logger.Debug("HooksHub.UserConsoleCommand - handler: " + handler + " - command: " + command);
				
				if (handler in ::HooksHub.ConsoleCommandHandlers)
				{
					try
					{
						::HooksHub.ConsoleCommandHandlers[handler](playerScript, command, args, arg);
					}
					catch(exception)
					{
						::Left4Lib.Logger.Error("HooksHub.UserConsoleCommand - Exception in ConsoleCommandHandler '" + key + "': " + exception);
					}
				}
			}
		}
	}
	
	::HooksHub.BotQuery <- function (queryflag, entity, defaultvalue)
	{
		local ret = true;
		local r = null;
		foreach (key, func in ::HooksHub.BotQueryFuncs)
		{
			try
			{
				r = func(queryflag, entity, defaultvalue);
			}
			catch(exception)
			{
				::Left4Lib.Logger.Error("HooksHub.BotQuery - Exception in func '" + key + "': " + exception);
			}

			if (r == false)
				ret = false;
		}
		
		// Global return value will be false if at least one func returns false
		
		return ret;
	}
	
	::HooksHub.CanPickupObject <- function (object)
	{
		local ret = false;
		local r = null;
		foreach (key, func in ::HooksHub.CanPickupObjectFuncs)
		{
			try
			{
				r = func(object);
			}
			catch(exception)
			{
				::Left4Lib.Logger.Error("HooksHub.CanPickupObject - Exception in func '" + key + "': " + exception);
			}

			if (r == true)
				ret = true;
		}
		
		// Global return value will be true if at least one func returns true
		
		return ret;
	}
	
	::HooksHub.Init <- function ()
	{
		::Left4Lib.Logger.Debug("HooksHub.Init");
		
		local my_roottable = getroottable();
		local my_g_ModeScript = my_roottable.DirectorScript.MapScript.ChallengeScript;
		local my_g_MapScript = my_roottable.DirectorScript.MapScript;
		
		// Setting up InterceptChat hooks
		if ("InterceptChat" in my_roottable && my_roottable.InterceptChat != null && my_roottable.InterceptChat != HooksHub.InterceptChat)
		{
			HooksHub.SetInterceptChat("L4LROOT", my_roottable.InterceptChat);
				
			::Left4Lib.Logger.Debug("HooksHub.Init - Added previous my_roottable InterceptChat hook");
		}
		if ("InterceptChat" in my_g_ModeScript && my_g_ModeScript.InterceptChat != null && my_g_ModeScript.InterceptChat != HooksHub.InterceptChat && HooksHub.GetInterceptChatByFunc(my_g_ModeScript.InterceptChat) == null)
		{
			HooksHub.SetInterceptChat("L4LMODE", my_g_ModeScript.InterceptChat);
				
			::Left4Lib.Logger.Debug("HooksHub.Init - Added my_g_ModeScript InterceptChat hook");
		}
		if ("InterceptChat" in my_g_MapScript && my_g_MapScript.InterceptChat != null && my_g_MapScript.InterceptChat != HooksHub.InterceptChat && HooksHub.GetInterceptChatByFunc(my_g_MapScript.InterceptChat) == null)
		{
			HooksHub.SetInterceptChat("L4LMAP", my_g_MapScript.InterceptChat);
				
			::Left4Lib.Logger.Debug("HooksHub.Init - Added my_g_MapScript InterceptChat hook");
		}
		
		::Left4Lib.Logger.Debug("HooksHub.Init - Setting HooksHub.InterceptChat hook");
		my_roottable.InterceptChat <- ::HooksHub.InterceptChat;
		my_g_ModeScript.InterceptChat <- ::HooksHub.InterceptChat;
		my_g_MapScript.InterceptChat <- ::HooksHub.InterceptChat;

		// Setting up AllowTakeDamage hooks
		if ("AllowTakeDamage" in my_roottable && my_roottable.AllowTakeDamage != null && my_roottable.AllowTakeDamage != HooksHub.AllowTakeDamage)
		{
			HooksHub.SetAllowTakeDamage("L4LROOT", my_roottable.AllowTakeDamage);
				
			::Left4Lib.Logger.Debug("HooksHub.Init - Added previous getroottable() AllowTakeDamage hook");
		}
		if ("AllowTakeDamage" in my_g_ModeScript && my_g_ModeScript.AllowTakeDamage != null && my_g_ModeScript.AllowTakeDamage != HooksHub.AllowTakeDamage && HooksHub.GetAllowTakeDamageByFunc(my_g_ModeScript.AllowTakeDamage) == null)
		{
			HooksHub.SetAllowTakeDamage("L4LMODE", my_g_ModeScript.AllowTakeDamage);
				
			::Left4Lib.Logger.Debug("HooksHub.Init - Added my_g_ModeScript AllowTakeDamage hook");
		}
		if ("AllowTakeDamage" in my_g_MapScript && my_g_MapScript.AllowTakeDamage != null && my_g_MapScript.AllowTakeDamage != HooksHub.AllowTakeDamage && HooksHub.GetAllowTakeDamageByFunc(my_g_MapScript.AllowTakeDamage) == null)
		{
			HooksHub.SetAllowTakeDamage("L4LMAP", my_g_MapScript.AllowTakeDamage);
				
			::Left4Lib.Logger.Debug("HooksHub.Init - Added my_g_MapScript AllowTakeDamage hook");
		}
		
		::Left4Lib.Logger.Debug("HooksHub.Init - Setting HooksHub.AllowTakeDamage hook");
		my_roottable.AllowTakeDamage <- ::HooksHub.AllowTakeDamage;
		my_g_ModeScript.AllowTakeDamage <- ::HooksHub.AllowTakeDamage;
		my_g_MapScript.AllowTakeDamage <- ::HooksHub.AllowTakeDamage;

		// Setting up AllowBash hooks
		if ("AllowBash" in my_roottable && my_roottable.AllowBash != null && my_roottable.AllowBash != HooksHub.AllowBash)
		{
			HooksHub.SetAllowBash("L4LROOT", my_roottable.AllowBash);
				
			::Left4Lib.Logger.Debug("HooksHub.Init - Added previous my_roottable AllowBash hook");
		}
		if ("AllowBash" in my_g_ModeScript && my_g_ModeScript.AllowBash != null && my_g_ModeScript.AllowBash != HooksHub.AllowBash && HooksHub.GetAllowBashByFunc(my_g_ModeScript.AllowBash) == null)
		{
			HooksHub.SetAllowBash("L4LMODE", my_g_ModeScript.AllowBash);
				
			::Left4Lib.Logger.Debug("HooksHub.Init - Added my_g_ModeScript AllowBash hook");
		}
		if ("AllowBash" in my_g_MapScript && my_g_MapScript.AllowBash != null && my_g_MapScript.AllowBash != HooksHub.AllowBash && HooksHub.GetAllowBashByFunc(my_g_MapScript.AllowBash) == null)
		{
			HooksHub.SetAllowBash("L4LMAP", my_g_MapScript.AllowBash);
				
			::Left4Lib.Logger.Debug("HooksHub.Init - Added my_g_MapScript AllowBash hook");
		}
		
		::Left4Lib.Logger.Debug("HooksHub.Init - Setting HooksHub.AllowBash hook");
		my_roottable.AllowBash <- ::HooksHub.AllowBash;
		my_g_ModeScript.AllowBash <- ::HooksHub.AllowBash;
		my_g_MapScript.AllowBash <- ::HooksHub.AllowBash;

		// Setting up UserConsoleCommand hooks
		if ("UserConsoleCommand" in my_roottable && my_roottable.UserConsoleCommand != null && my_roottable.UserConsoleCommand != HooksHub.UserConsoleCommand)
		{
			HooksHub.SetUserConsoleCommand("L4LROOT", my_roottable.UserConsoleCommand);
				
			::Left4Lib.Logger.Debug("HooksHub.Init - Added previous my_roottable UserConsoleCommand hook");
		}
		if ("UserConsoleCommand" in my_g_ModeScript && my_g_ModeScript.UserConsoleCommand != null && my_g_ModeScript.UserConsoleCommand != HooksHub.UserConsoleCommand && HooksHub.GetUserConsoleCommandByFunc(my_g_ModeScript.UserConsoleCommand) == null)
		{
			HooksHub.SetUserConsoleCommand("L4LMODE", my_g_ModeScript.UserConsoleCommand);
				
			::Left4Lib.Logger.Debug("HooksHub.Init - Added my_g_ModeScript UserConsoleCommand hook");
		}
		if ("UserConsoleCommand" in my_g_MapScript && my_g_MapScript.UserConsoleCommand != null && my_g_MapScript.UserConsoleCommand != HooksHub.UserConsoleCommand && HooksHub.GetUserConsoleCommandByFunc(my_g_MapScript.UserConsoleCommand) == null)
		{
			HooksHub.SetUserConsoleCommand("L4LMAP", my_g_MapScript.UserConsoleCommand);
				
			::Left4Lib.Logger.Debug("HooksHub.Init - Added my_g_MapScript UserConsoleCommand hook");
		}
		
		::Left4Lib.Logger.Debug("HooksHub.Init - Setting HooksHub.UserConsoleCommand hook");
		my_roottable.UserConsoleCommand <- ::HooksHub.UserConsoleCommand;
		my_g_ModeScript.UserConsoleCommand <- ::HooksHub.UserConsoleCommand;
		my_g_MapScript.UserConsoleCommand <- ::HooksHub.UserConsoleCommand;
		
		// Setting up BotQuery hooks
		if ("BotQuery" in my_roottable && my_roottable.BotQuery != null && my_roottable.BotQuery != HooksHub.BotQuery)
		{
			HooksHub.SetBotQuery("L4LROOT", my_roottable.BotQuery);
				
			::Left4Lib.Logger.Debug("HooksHub.Init - Added previous my_roottable BotQuery hook");
		}
		if ("BotQuery" in my_g_ModeScript && my_g_ModeScript.BotQuery != null && my_g_ModeScript.BotQuery != HooksHub.BotQuery && HooksHub.GetBotQueryByFunc(my_g_ModeScript.BotQuery) == null)
		{
			HooksHub.SetBotQuery("L4LMODE", my_g_ModeScript.BotQuery);
				
			::Left4Lib.Logger.Debug("HooksHub.Init - Added my_g_ModeScript BotQuery hook");
		}
		if ("BotQuery" in my_g_MapScript && my_g_MapScript.BotQuery != null && my_g_MapScript.BotQuery != HooksHub.BotQuery && HooksHub.GetBotQueryByFunc(my_g_MapScript.BotQuery) == null)
		{
			HooksHub.SetBotQuery("L4LMAP", my_g_MapScript.BotQuery);
				
			::Left4Lib.Logger.Debug("HooksHub.Init - Added my_g_MapScript BotQuery hook");
		}
		
		::Left4Lib.Logger.Debug("HooksHub.Init - Setting HooksHub.BotQuery hook");
		my_roottable.BotQuery <- ::HooksHub.BotQuery;
		my_g_ModeScript.BotQuery <- ::HooksHub.BotQuery;
		my_g_MapScript.BotQuery <- ::HooksHub.BotQuery;
		
		// Setting up CanPickupObject hooks
		if ("CanPickupObject" in my_roottable && my_roottable.CanPickupObject != null && my_roottable.CanPickupObject != HooksHub.CanPickupObject)
		{
			HooksHub.SetCanPickupObject("L4LROOT", my_roottable.CanPickupObject);
				
			::Left4Lib.Logger.Debug("HooksHub.Init - Added previous my_roottable CanPickupObject hook");
		}
		if ("CanPickupObject" in my_g_ModeScript && my_g_ModeScript.CanPickupObject != null && my_g_ModeScript.CanPickupObject != HooksHub.CanPickupObject && HooksHub.GetCanPickupObjectByFunc(my_g_ModeScript.CanPickupObject) == null)
		{
			HooksHub.SetCanPickupObject("L4LMODE", my_g_ModeScript.CanPickupObject);
				
			::Left4Lib.Logger.Debug("HooksHub.Init - Added my_g_ModeScript CanPickupObject hook");
		}
		if ("CanPickupObject" in my_g_MapScript && my_g_MapScript.CanPickupObject != null && my_g_MapScript.CanPickupObject != HooksHub.CanPickupObject && HooksHub.GetCanPickupObjectByFunc(my_g_MapScript.CanPickupObject) == null)
		{
			HooksHub.SetCanPickupObject("L4LMAP", my_g_MapScript.CanPickupObject);
				
			::Left4Lib.Logger.Debug("HooksHub.Init - Added my_g_MapScript CanPickupObject hook");
		}
		
		::Left4Lib.Logger.Debug("HooksHub.Init - Setting HooksHub.CanPickupObject hook");
		my_roottable.CanPickupObject <- ::HooksHub.CanPickupObject;
		my_g_ModeScript.CanPickupObject <- ::HooksHub.CanPickupObject;
		my_g_MapScript.CanPickupObject <- ::HooksHub.CanPickupObject;

		// Prevent duplicate calls from VSLib...
		
		// P.S. Also make sure to add the "g_ModeScript.XXX" and "g_MapScript.XXX" hooks regardless the addons loading order
		//      If L4L is loaded AFTER Admin System then "g_ModeScript.XXX" and "g_MapScript.XXX" are already gone (but they're still in ModeXXX)
		
		if ("ModeInterceptChat" in my_g_ModeScript)
		{
			if (my_g_ModeScript.ModeInterceptChat != null && HooksHub.GetInterceptChatByFunc(my_g_ModeScript.ModeInterceptChat) == null)
			{
				HooksHub.SetInterceptChat("L4LMODE", my_g_ModeScript.ModeInterceptChat);
					
				::Left4Lib.Logger.Debug("HooksHub.Init - Added my_g_ModeScript InterceptChat (ModeInterceptChat) hook");
			}

			delete my_g_ModeScript.ModeInterceptChat;
		}
		if ("MapInterceptChat" in my_g_ModeScript)
		{
			if (my_g_ModeScript.MapInterceptChat != null && HooksHub.GetInterceptChatByFunc(my_g_ModeScript.MapInterceptChat) == null)
			{
				HooksHub.SetInterceptChat("L4LMAP", my_g_ModeScript.MapInterceptChat);
					
				::Left4Lib.Logger.Debug("HooksHub.Init - Added my_g_MapScript InterceptChat (MapInterceptChat) hook");
			}
			
			delete my_g_ModeScript.MapInterceptChat;
		}
			
		if ("ModeAllowTakeDamage" in my_g_ModeScript)
		{
			if (my_g_ModeScript.ModeAllowTakeDamage != null && HooksHub.GetAllowTakeDamageByFunc(my_g_ModeScript.ModeAllowTakeDamage) == null)
			{
				HooksHub.SetAllowTakeDamage("L4LMODE", my_g_ModeScript.ModeAllowTakeDamage);
					
				::Left4Lib.Logger.Debug("HooksHub.Init - Added my_g_ModeScript AllowTakeDamage (ModeAllowTakeDamage) hook");
			}
			
			delete my_g_ModeScript.ModeAllowTakeDamage;
		}
		if ("MapAllowTakeDamage" in my_g_ModeScript)
		{
			if (my_g_ModeScript.MapAllowTakeDamage != null && HooksHub.GetAllowTakeDamageByFunc(my_g_ModeScript.MapAllowTakeDamage) == null)
			{
				HooksHub.SetAllowTakeDamage("L4LMAP", my_g_ModeScript.MapAllowTakeDamage);
					
				::Left4Lib.Logger.Debug("HooksHub.Init - Added g_MapScript AllowTakeDamage (MapAllowTakeDamage) hook");
			}
			
			delete my_g_ModeScript.MapAllowTakeDamage;
		}

		if ("ModeAllowBash" in my_g_ModeScript)
		{
			if (my_g_ModeScript.ModeAllowBash != null && HooksHub.GetAllowBashByFunc(my_g_ModeScript.ModeAllowBash) == null)
			{
				HooksHub.SetAllowBash("L4LMODE", my_g_ModeScript.ModeAllowBash);
					
				::Left4Lib.Logger.Debug("HooksHub.Init - Added g_ModeScript AllowBash (ModeAllowBash) hook");
			}
			
			delete my_g_ModeScript.ModeAllowBash;
		}
		if ("MapAllowBash" in my_g_ModeScript)
		{
			if (my_g_ModeScript.MapAllowBash != null && HooksHub.GetAllowBashByFunc(my_g_ModeScript.MapAllowBash) == null)
			{
				HooksHub.SetAllowBash("L4LMAP", my_g_ModeScript.MapAllowBash);
					
				::Left4Lib.Logger.Debug("HooksHub.Init - Added g_MapScript AllowBash (MapAllowBash) hook");
			}
			
			delete my_g_ModeScript.MapAllowBash;
		}
			
		if ("ModeUserConsoleCommand" in my_g_ModeScript)
		{
			if (my_g_ModeScript.ModeUserConsoleCommand != null && HooksHub.GetUserConsoleCommandByFunc(my_g_ModeScript.ModeUserConsoleCommand) == null)
			{
				HooksHub.SetUserConsoleCommand("L4LMODE", my_g_ModeScript.ModeUserConsoleCommand);
					
				::Left4Lib.Logger.Debug("HooksHub.Init - Added g_ModeScript UserConsoleCommand (ModeUserConsoleCommand) hook");
			}
			
			delete my_g_ModeScript.ModeUserConsoleCommand;
		}
		if ("MapUserConsoleCommand" in my_g_ModeScript)
		{
			if (my_g_ModeScript.MapUserConsoleCommand != null && HooksHub.GetUserConsoleCommandByFunc(my_g_ModeScript.MapUserConsoleCommand) == null)
			{
				HooksHub.SetUserConsoleCommand("L4LMAP", my_g_ModeScript.MapUserConsoleCommand);
					
				::Left4Lib.Logger.Debug("HooksHub.Init - Added g_MapScript UserConsoleCommand (MapUserConsoleCommand) hook");
			}
			
			delete my_g_ModeScript.MapUserConsoleCommand;
		}
			
		if ("ModeBotQuery" in my_g_ModeScript)
		{
			if (my_g_ModeScript.ModeBotQuery != null && HooksHub.GetBotQueryByFunc(my_g_ModeScript.ModeBotQuery) == null)
			{
				HooksHub.SetBotQuery("L4LMODE", my_g_ModeScript.ModeBotQuery);
					
				::Left4Lib.Logger.Debug("HooksHub.Init - Added g_ModeScript BotQuery (ModeBotQuery) hook");
			}
			
			delete my_g_ModeScript.ModeBotQuery;
		}
		if ("MapBotQuery" in my_g_ModeScript)
		{
			if (my_g_ModeScript.MapBotQuery != null && HooksHub.GetBotQueryByFunc(my_g_ModeScript.MapBotQuery) == null)
			{
				HooksHub.SetBotQuery("L4LMAP", my_g_ModeScript.MapBotQuery);
					
				::Left4Lib.Logger.Debug("HooksHub.Init - Added g_MapScript BotQuery (MapBotQuery) hook");
			}
			
			delete my_g_ModeScript.MapBotQuery;
		}
			
		if ("ModeCanPickupObject" in my_g_ModeScript)
		{
			if (my_g_ModeScript.ModeCanPickupObject != null && HooksHub.GetCanPickupObjectByFunc(my_g_ModeScript.ModeCanPickupObject) == null)
			{
				HooksHub.SetCanPickupObject("L4LMODE", my_g_ModeScript.ModeCanPickupObject);
					
				::Left4Lib.Logger.Debug("HooksHub.Init - Added g_ModeScript CanPickupObject (ModeCanPickupObject) hook");
			}
			
			delete my_g_ModeScript.ModeCanPickupObject;
		}
		if ("MapCanPickupObject" in my_g_ModeScript)
		{
			if (my_g_ModeScript.MapCanPickupObject != null && HooksHub.GetCanPickupObjectByFunc(my_g_ModeScript.MapCanPickupObject) == null)
			{
				HooksHub.SetCanPickupObject("L4LMAP", my_g_ModeScript.MapCanPickupObject);
					
				::Left4Lib.Logger.Debug("HooksHub.Init - Added g_MapScript CanPickupObject (MapCanPickupObject) hook");
			}
			
			delete my_g_ModeScript.MapCanPickupObject;
		}
	}
	
	::HooksHub.CheckHooks <- function ()
	{
		local function checkHooksInTable(tbl, tblName, hookNames, err = false)
		{
			local n = 0;
			foreach (hookName in hookNames)
			{
				if ((hookName in tbl) && tbl[hookName] != ::HooksHub[hookName])
				{
					if (err)
						::Left4Lib.Logger.Error(hookName + " hook in " + tblName + " is not HooksHub." + hookName + "! Hook was set in " + tbl[hookName].getinfos().src);
					else
						::Left4Lib.Logger.Warning(hookName + " hook in " + tblName + " is not HooksHub." + hookName + "! Hook was set in " + tbl[hookName].getinfos().src);
					n++;
				}
			}
			return n;
		}
		
		::Left4Lib.Logger.Debug("HooksHub.CheckHooks");
		
		local hooks = ["InterceptChat", "AllowTakeDamage", "AllowBash", "UserConsoleCommand", "BotQuery", "CanPickupObject"];
		local errors = checkHooksInTable(getroottable(), "getroottable()", hooks);
		errors += checkHooksInTable(getroottable().DirectorScript.MapScript.ChallengeScript, "g_ModeScript", hooks, true);
		errors += checkHooksInTable(getroottable().DirectorScript.MapScript, "g_MapScript", hooks);
		/*
			NOTE:
			C++ seems to give g_ModeScript hooks the highest priority, so at this point if roottable and g_MapScript hooks are overwritten it doesn't matter, as long as g_ModeScript hooks are OK.
		*/
		
		if (errors == 0)
			::Left4Lib.Logger.Info("HooksHub hooks OK");
	}
	
	// https://github.com/smilz0/Left4Bots/issues/96
	/*
		Scripts/events order of each map (excluding map restart):
			1. scriptedmode_addon of all the addons (order seems to be the order in addonlist.txt)
			2. director_base_addon of all the addons (same order ^)
			3. OnGameEvent_round_start_pre_entity (only once)
			4. scriptedmode_addon of all the addons (again)
			5. director_base_addon of all the addons (again)
			6. OnGameEvent_round_start_post_nav (only once)
			7. OnGameEvent_round_start (only once)
		
		C++ seems to save the final vscript hooks during the call to OnActivate, which is after n. 7 on first map but between 5 and 6 on next maps, so moving HooksHub.Init in director_base_addon was always
		working on first map (OnGameEvent_round_start being before OnActivate) but was working on next maps only if the director_base_addon order did put L4L after L4B (or any other addon that included HooksHub).
		It didn't work with different order because the first time HooksHub.Init wouldn't run (cause HooksHub not included yet) so HooksHub.Init ran only once (but needed at least 2 with previous logic).
		New logic only needs one HooksHub.Init run and it's moved after the first cycle of scriptedmode_addon/director_base_addon to let VSLib (and other addons) to set their hooks before they get saved and replaced by HooksHub.
		However this will fail if other addons don't check if the hooks are already set and will replace HooksHub in the second scriptedmode_addon/director_base_addon cycle (previous logic likely had the same problem, so...).
	*/
	
	// This is triggered even before the scriptedmode.nut (but only the second time, so only once per map). NOTE: This is triggere before the director_base_addon(s) in map restart!
	/*
	::HooksHub.Events.OnGameEvent_round_start_pre_entity <- function (params)
	{
		::Left4Lib.Logger.Debug("OnGameEvent_round_start_pre_entity");
	}
	*/
	
	// This is triggered right before round_start (but still after OnActivate after map transitions)
	/*
	::HooksHub.Events.OnGameEvent_round_start_post_nav <- function (params)
	{
		::Left4Lib.Logger.Debug("OnGameEvent_round_start_post_nav");
	}
	*/
	
	// Like round_start_post_nav, it's triggered after OnActivate after map transition, before only on first map
	::HooksHub.Events.OnGameEvent_round_start <- function (params)
	{
		::Left4Lib.Logger.Debug("OnGameEvent_round_start");
		
		DoEntFire("worldspawn", "RunScriptCode", "::HooksHub.CheckHooks()", 5.0, null, null);
	}
	
	::Left4Lib.Logger.Info("HooksHub created");
}

__CollectEventCallbacks(::HooksHub.Events, "OnGameEvent_", "GameEventCallbacks", RegisterScriptGameEventListener);
