//------------------------------------------------------
//     Author : smilzo
//     https://steamcommunity.com/id/smilz0
//------------------------------------------------------

IncludeScript("left4lib_consts");
IncludeScript("left4lib_settings");

if (!("HooksHub" in getroottable()))
{
	::HooksHub <-
	{
		Loaded = false
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
		foreach (key, val in ::HooksHub.InterceptChatFuncs)
			printl("[HooksHub][DEBUG] InterceptChatFuncs[" + key + "] = " + val);
			
		foreach (key, val in ::HooksHub.AllowTakeDamageFuncs)
			printl("[HooksHub][DEBUG] AllowTakeDamageFuncs[" + key + "] = " + val);
			
		foreach (key, val in ::HooksHub.AllowBashFuncs)
			printl("[HooksHub][DEBUG] AllowBashFuncs[" + key + "] = " + val);
			
		foreach (key, val in ::HooksHub.UserConsoleCommandFuncs)
			printl("[HooksHub][DEBUG] UserConsoleCommandFuncs[" + key + "] = " + val);
			
		foreach (key, val in ::HooksHub.BotQueryFuncs)
			printl("[HooksHub][DEBUG] BotQueryFuncs[" + key + "] = " + val);
			
		foreach (key, val in ::HooksHub.CanPickupObjectFuncs)
			printl("[HooksHub][DEBUG] CanPickupObjectFuncs[" + key + "] = " + val);
		
		foreach (key, val in ::HooksHub.ChatCommandHandlers)
			printl("[HooksHub][DEBUG] ChatCommandHandlers[" + key + "] = " + val);
			
		foreach (key, val in ::HooksHub.ConsoleCommandHandlers)
			printl("[HooksHub][DEBUG] ConsoleCommandHandlers[" + key + "] = " + val);
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
				error("[HooksHub][ERROR] InterceptChat - Exception in func '" + key + "': " + exception + "\n");
			}

			//printl("[HooksHub][DEBUG] " + key + "'s InterceptChat func returned " + r);

			// Global return value will be false if at least one func returns false
			if (r == false)
				ret = false;
		}

		if (::HooksHub.ChatCommandHandlers.len() > 0 && speaker && speaker.IsValid())
		{
			// Removing the ending \r\n
			if (msg.find("\n", msg.len() - 1) != null || msg.find("\r", msg.len() - 1) != null)
				msg = msg.slice(0, msg.len() - 1);
			if (msg.find("\n", msg.len() - 1) != null || msg.find("\r", msg.len() - 1) != null)
				msg = msg.slice(0, msg.len() - 1);
			
			local name = speaker.GetPlayerName() + ": ";
			local text = strip(msg.slice(msg.find(name) + name.len())); // Remove the speaker's name part from the message
			
			printl("[HooksHub][DEBUG] InterceptChat - speaker: " + speaker.GetPlayerName() + " - text: " + text);
			
			if (text.find(Left4Lib.Settings.hooks_chatcommand_trigger) == 0)
			{
				local args = split(text, " ");
				if (args.len() > 1) // Must have at least 2 arguments: "!handler command"
				{
					local handler = args[0].slice(Left4Lib.Settings.hooks_chatcommand_trigger.len());
					local command = args[1].tolower();
					
					printl("[HooksHub][DEBUG] InterceptChat - handler: " + handler + " - command: " + command);
					
					if (handler in ::HooksHub.ChatCommandHandlers)
					{
						try
						{
							::HooksHub.ChatCommandHandlers[handler](speaker, command, args, text);
						}
						catch(exception)
						{
							error("[HooksHub][ERROR] InterceptChat - Exception in ChatCommandHandler '" + key + "': " + exception + "\n");
						}
					}
				}
				
				// If no InterceptChat func wanted to hide the chat, only hide it if the text starts with hooks_chatcommand_trigger and hooks_chatcommand_hide is true
				if (ret && Left4Lib.Settings.hooks_chatcommand_hide)
					ret = false;
			}
		}
		
		printl("[HooksHub][DEBUG] InterceptChat - ret: " + ret);
		
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
				error("[HooksHub][ERROR] AllowTakeDamage - Exception in func '" + key + "': " + exception + "\n");
			}
			
			//printl("[HooksHub][DEBUG] " + key + "'s AllowTakeDamage func returned " + r);
			
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
				error("[HooksHub][ERROR] AllowBash - Exception in func '" + key + "': " + exception + "\n");
			}
			
			//printl("[HooksHub][DEBUG] " + key + "'s AllowBash func returned " + r);
			
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
		//printl("[HooksHub][DEBUG] UserConsoleCommand - arg: " + arg);
		
		foreach (key, func in ::HooksHub.UserConsoleCommandFuncs)
		{
			try
			{
				func(playerScript, arg);
			}
			catch(exception)
			{
				error("[HooksHub][ERROR] UserConsoleCommand - Exception in func '" + key + "': " + exception + "\n");
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
					
				printl("[HooksHub][DEBUG] UserConsoleCommand - handler: " + handler + " - command: " + command);
				
				if (handler in ::HooksHub.ConsoleCommandHandlers)
				{
					try
					{
						::HooksHub.ConsoleCommandHandlers[handler](playerScript, command, args, arg);
					}
					catch(exception)
					{
						error("[HooksHub][ERROR] UserConsoleCommand - Exception in ConsoleCommandHandler '" + key + "': " + exception + "\n");
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
				error("[HooksHub][ERROR] BotQuery - Exception in func '" + key + "': " + exception + "\n");
			}

			//printl("[HooksHub][DEBUG] " + key + "'s BotQuery func returned " + r);

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
				error("[HooksHub][ERROR] CanPickupObject - Exception in func '" + key + "': " + exception + "\n");
			}

			//printl("[HooksHub][DEBUG] " + key + "'s CanPickupObject func returned " + r);

			if (r == true)
				ret = true;
		}
		
		// Global return value will be true if at least one func returns true
		
		return ret;
	}
	
	::HooksHub.Init <- function ()
	{
		printl("[HooksHub][DEBUG] Init");
		
		// Setting up InterceptChat hooks
		if ("InterceptChat" in getroottable() && getroottable().InterceptChat != null && getroottable().InterceptChat != HooksHub.InterceptChat)
		{
			HooksHub.SetInterceptChat("L4LROOT", getroottable().InterceptChat);
				
			printl("[HooksHub][DEBUG] Init - Added previous getroottable() InterceptChat hook");
			
			getroottable().InterceptChat <- ::HooksHub.InterceptChat;
		}
		if ("InterceptChat" in g_ModeScript && g_ModeScript.InterceptChat != null && g_ModeScript.InterceptChat != HooksHub.InterceptChat && HooksHub.GetInterceptChatByFunc(g_ModeScript.InterceptChat) == null)
		{
			HooksHub.SetInterceptChat("L4LMODE", g_ModeScript.InterceptChat);
				
			printl("[HooksHub][DEBUG] Init - Added g_ModeScript InterceptChat hook");
			
			g_ModeScript.InterceptChat <- null;
		}
		if ("InterceptChat" in g_MapScript && g_MapScript.InterceptChat != null && g_MapScript.InterceptChat != HooksHub.InterceptChat && HooksHub.GetInterceptChatByFunc(g_MapScript.InterceptChat) == null)
		{
			HooksHub.SetInterceptChat("L4LMAP", g_MapScript.InterceptChat);
				
			printl("[HooksHub][DEBUG] Init - Added g_MapScript InterceptChat hook");
			
			g_MapScript.InterceptChat <- null;
		}
		if (HooksHub.Loaded)
		{
			printl("[HooksHub][DEBUG] Init - Setting HooksHub.InterceptChat hook");
			
			getroottable().InterceptChat <- ::HooksHub.InterceptChat;
			g_ModeScript.InterceptChat <- ::HooksHub.InterceptChat;
		}

		// Setting up AllowTakeDamage hooks
		if ("AllowTakeDamage" in getroottable() && getroottable().AllowTakeDamage != null && getroottable().AllowTakeDamage != HooksHub.AllowTakeDamage)
		{
			HooksHub.SetAllowTakeDamage("L4LROOT", getroottable().AllowTakeDamage);
				
			printl("[HooksHub][DEBUG] Init - Added previous getroottable() AllowTakeDamage hook");
			
			getroottable().AllowTakeDamage <- ::HooksHub.AllowTakeDamage;
		}
		if ("AllowTakeDamage" in g_ModeScript && g_ModeScript.AllowTakeDamage != null && g_ModeScript.AllowTakeDamage != HooksHub.AllowTakeDamage && HooksHub.GetAllowTakeDamageByFunc(g_ModeScript.AllowTakeDamage) == null)
		{
			HooksHub.SetAllowTakeDamage("L4LMODE", g_ModeScript.AllowTakeDamage);
				
			printl("[HooksHub][DEBUG] Init - Added g_ModeScript AllowTakeDamage hook");
			
			g_ModeScript.AllowTakeDamage <- null;
		}
		if ("AllowTakeDamage" in g_MapScript && g_MapScript.AllowTakeDamage != null && g_MapScript.AllowTakeDamage != HooksHub.AllowTakeDamage && HooksHub.GetAllowTakeDamageByFunc(g_MapScript.AllowTakeDamage) == null)
		{
			HooksHub.SetAllowTakeDamage("L4LMAP", g_MapScript.AllowTakeDamage);
				
			printl("[HooksHub][DEBUG] Init - Added g_MapScript AllowTakeDamage hook");
			
			g_MapScript.AllowTakeDamage <- null;
		}
		if (HooksHub.Loaded)
		{
			printl("[HooksHub][DEBUG] Init - Setting HooksHub.AllowTakeDamage hook");
			
			getroottable().AllowTakeDamage <- ::HooksHub.AllowTakeDamage;
			g_ModeScript.AllowTakeDamage <- ::HooksHub.AllowTakeDamage;
		}

		// Setting up AllowBash hooks
		if ("AllowBash" in getroottable() && getroottable().AllowBash != null && getroottable().AllowBash != HooksHub.AllowBash)
		{
			HooksHub.SetAllowBash("L4LROOT", getroottable().AllowBash);
				
			printl("[HooksHub][DEBUG] Init - Added previous getroottable() AllowBash hook");
			
			getroottable().AllowBash <- ::HooksHub.AllowBash;
		}
		if ("AllowBash" in g_ModeScript && g_ModeScript.AllowBash != null && g_ModeScript.AllowBash != HooksHub.AllowBash && HooksHub.GetAllowBashByFunc(g_ModeScript.AllowBash) == null)
		{
			HooksHub.SetAllowBash("L4LMODE", g_ModeScript.AllowBash);
				
			printl("[HooksHub][DEBUG] Init - Added g_ModeScript AllowBash hook");
			
			g_ModeScript.AllowBash <- null;
		}
		if ("AllowBash" in g_MapScript && g_MapScript.AllowBash != null && g_MapScript.AllowBash != HooksHub.AllowBash && HooksHub.GetAllowBashByFunc(g_MapScript.AllowBash) == null)
		{
			HooksHub.SetAllowBash("L4LMAP", g_MapScript.AllowBash);
				
			printl("[HooksHub][DEBUG] Init - Added g_MapScript AllowBash hook");
			
			g_MapScript.AllowBash <- null;
		}
		if (HooksHub.Loaded)
		{
			printl("[HooksHub][DEBUG] Init - Setting HooksHub.AllowBash hook");
			
			getroottable().AllowBash <- ::HooksHub.AllowBash;
			g_ModeScript.AllowBash <- ::HooksHub.AllowBash;
		}

		// Setting up UserConsoleCommand hooks
		if ("UserConsoleCommand" in getroottable() && getroottable().UserConsoleCommand != null && getroottable().UserConsoleCommand != HooksHub.UserConsoleCommand)
		{
			HooksHub.SetUserConsoleCommand("L4LROOT", getroottable().UserConsoleCommand);
				
			printl("[HooksHub][DEBUG] Init - Added previous getroottable() UserConsoleCommand hook");
			
			getroottable().UserConsoleCommand <- ::HooksHub.UserConsoleCommand;
		}
		if ("UserConsoleCommand" in g_ModeScript && g_ModeScript.UserConsoleCommand != null && g_ModeScript.UserConsoleCommand != HooksHub.UserConsoleCommand && HooksHub.GetUserConsoleCommandByFunc(g_ModeScript.UserConsoleCommand) == null)
		{
			HooksHub.SetUserConsoleCommand("L4LMODE", g_ModeScript.UserConsoleCommand);
				
			printl("[HooksHub][DEBUG] Init - Added g_ModeScript UserConsoleCommand hook");
			
			g_ModeScript.UserConsoleCommand <- null;
		}
		if ("UserConsoleCommand" in g_MapScript && g_MapScript.UserConsoleCommand != null && g_MapScript.UserConsoleCommand != HooksHub.UserConsoleCommand && HooksHub.GetUserConsoleCommandByFunc(g_MapScript.UserConsoleCommand) == null)
		{
			HooksHub.SetUserConsoleCommand("L4LMAP", g_MapScript.UserConsoleCommand);
				
			printl("[HooksHub][DEBUG] Init - Added g_MapScript UserConsoleCommand hook");
			
			g_MapScript.UserConsoleCommand <- null;
		}
		if (HooksHub.Loaded)
		{
			printl("[HooksHub][DEBUG] Init - Setting HooksHub.UserConsoleCommand hook");
			
			getroottable().UserConsoleCommand <- ::HooksHub.UserConsoleCommand;
			g_ModeScript.UserConsoleCommand <- ::HooksHub.UserConsoleCommand;
		}
		
		// Setting up BotQuery hooks
		if ("BotQuery" in getroottable() && getroottable().BotQuery != null && getroottable().BotQuery != HooksHub.BotQuery)
		{
			HooksHub.SetBotQuery("L4LROOT", getroottable().BotQuery);
				
			printl("[HooksHub][DEBUG] Init - Added previous getroottable() BotQuery hook");
			
			getroottable().BotQuery <- ::HooksHub.BotQuery;
		}
		if ("BotQuery" in g_ModeScript && g_ModeScript.BotQuery != null && g_ModeScript.BotQuery != HooksHub.BotQuery && HooksHub.GetBotQueryByFunc(g_ModeScript.BotQuery) == null)
		{
			HooksHub.SetBotQuery("L4LMODE", g_ModeScript.BotQuery);
				
			printl("[HooksHub][DEBUG] Init - Added g_ModeScript BotQuery hook");
			
			g_ModeScript.BotQuery <- null;
		}
		if ("BotQuery" in g_MapScript && g_MapScript.BotQuery != null && g_MapScript.BotQuery != HooksHub.BotQuery && HooksHub.GetBotQueryByFunc(g_MapScript.BotQuery) == null)
		{
			HooksHub.SetBotQuery("L4LMAP", g_MapScript.BotQuery);
				
			printl("[HooksHub][DEBUG] Init - Added g_MapScript BotQuery hook");
			
			g_MapScript.BotQuery <- null;
		}
		if (HooksHub.Loaded)
		{
			printl("[HooksHub][DEBUG] Init - Setting HooksHub.BotQuery hook");
			
			getroottable().BotQuery <- ::HooksHub.BotQuery;
			g_ModeScript.BotQuery <- ::HooksHub.BotQuery;
		}
		
		// Setting up CanPickupObject hooks
		if ("CanPickupObject" in getroottable() && getroottable().CanPickupObject != null && getroottable().CanPickupObject != HooksHub.CanPickupObject)
		{
			HooksHub.SetCanPickupObject("L4LROOT", getroottable().CanPickupObject);
				
			printl("[HooksHub][DEBUG] Init - Added previous getroottable() CanPickupObject hook");
			
			getroottable().CanPickupObject <- ::HooksHub.CanPickupObject;
		}
		if ("CanPickupObject" in g_ModeScript && g_ModeScript.CanPickupObject != null && g_ModeScript.CanPickupObject != HooksHub.CanPickupObject && HooksHub.GetCanPickupObjectByFunc(g_ModeScript.CanPickupObject) == null)
		{
			HooksHub.SetCanPickupObject("L4LMODE", g_ModeScript.CanPickupObject);
				
			printl("[HooksHub][DEBUG] Init - Added g_ModeScript CanPickupObject hook");
			
			g_ModeScript.CanPickupObject <- null;
		}
		if ("CanPickupObject" in g_MapScript && g_MapScript.CanPickupObject != null && g_MapScript.CanPickupObject != HooksHub.CanPickupObject && HooksHub.GetCanPickupObjectByFunc(g_MapScript.CanPickupObject) == null)
		{
			HooksHub.SetCanPickupObject("L4LMAP", g_MapScript.CanPickupObject);
				
			printl("[HooksHub][DEBUG] Init - Added g_MapScript CanPickupObject hook");
			
			g_MapScript.CanPickupObject <- null;
		}
		if (HooksHub.Loaded)
		{
			printl("[HooksHub][DEBUG] Init - Setting HooksHub.CanPickupObject hook");
			
			getroottable().CanPickupObject <- ::HooksHub.CanPickupObject;
			g_ModeScript.CanPickupObject <- ::HooksHub.CanPickupObject;
		}

		HooksHub.Loaded = true;

		// Prevent duplicate calls from VSLib...
		
		// P.S. Also make sure to add the "g_ModeScript.XXX" and "g_MapScript.XXX" hooks regardless the addons loading order
		//      If L4L is loaded AFTER Admin System then "g_ModeScript.XXX" and "g_MapScript.XXX" are already gone (but they're still in ModeXXX)
		
		if ("ModeInterceptChat" in g_ModeScript)
		{
			if (g_ModeScript.ModeInterceptChat != null && HooksHub.GetInterceptChatByFunc(g_ModeScript.ModeInterceptChat) == null)
			{
				HooksHub.SetInterceptChat("L4LMODE", g_ModeScript.ModeInterceptChat);
					
				printl("[HooksHub][DEBUG] Init - Added g_ModeScript InterceptChat (ModeInterceptChat) hook");
			}

			delete g_ModeScript.ModeInterceptChat;
		}
		if ("MapInterceptChat" in g_ModeScript)
		{
			if (g_ModeScript.MapInterceptChat != null && HooksHub.GetInterceptChatByFunc(g_ModeScript.MapInterceptChat) == null)
			{
				HooksHub.SetInterceptChat("L4LMAP", g_ModeScript.MapInterceptChat);
					
				printl("[HooksHub][DEBUG] Init - Added g_MapScript InterceptChat (MapInterceptChat) hook");
			}
			
			delete g_ModeScript.MapInterceptChat;
		}
			
		if ("ModeAllowTakeDamage" in g_ModeScript)
		{
			if (g_ModeScript.ModeAllowTakeDamage != null && HooksHub.GetAllowTakeDamageByFunc(g_ModeScript.ModeAllowTakeDamage) == null)
			{
				HooksHub.SetAllowTakeDamage("L4LMODE", g_ModeScript.ModeAllowTakeDamage);
					
				printl("[HooksHub][DEBUG] Init - Added g_ModeScript AllowTakeDamage (ModeAllowTakeDamage) hook");
			}
			
			delete g_ModeScript.ModeAllowTakeDamage;
		}
		if ("MapAllowTakeDamage" in g_ModeScript)
		{
			if (g_ModeScript.MapAllowTakeDamage != null && HooksHub.GetAllowTakeDamageByFunc(g_ModeScript.MapAllowTakeDamage) == null)
			{
				HooksHub.SetAllowTakeDamage("L4LMAP", g_ModeScript.MapAllowTakeDamage);
					
				printl("[HooksHub][DEBUG] Init - Added g_MapScript AllowTakeDamage (MapAllowTakeDamage) hook");
			}
			
			delete g_ModeScript.MapAllowTakeDamage;
		}

		if ("ModeAllowBash" in g_ModeScript)
		{
			if (g_ModeScript.ModeAllowBash != null && HooksHub.GetAllowBashByFunc(g_ModeScript.ModeAllowBash) == null)
			{
				HooksHub.SetAllowBash("L4LMODE", g_ModeScript.ModeAllowBash);
					
				printl("[HooksHub][DEBUG] Init - Added g_ModeScript AllowBash (ModeAllowBash) hook");
			}
			
			delete g_ModeScript.ModeAllowBash;
		}
		if ("MapAllowBash" in g_ModeScript)
		{
			if (g_ModeScript.MapAllowBash != null && HooksHub.GetAllowBashByFunc(g_ModeScript.MapAllowBash) == null)
			{
				HooksHub.SetAllowBash("L4LMAP", g_ModeScript.MapAllowBash);
					
				printl("[HooksHub][DEBUG] Init - Added g_MapScript AllowBash (MapAllowBash) hook");
			}
			
			delete g_ModeScript.MapAllowBash;
		}
			
		if ("ModeUserConsoleCommand" in g_ModeScript)
		{
			if (g_ModeScript.ModeUserConsoleCommand != null && HooksHub.GetUserConsoleCommandByFunc(g_ModeScript.ModeUserConsoleCommand) == null)
			{
				HooksHub.SetUserConsoleCommand("L4LMODE", g_ModeScript.ModeUserConsoleCommand);
					
				printl("[HooksHub][DEBUG] Init - Added g_ModeScript UserConsoleCommand (ModeUserConsoleCommand) hook");
			}
			
			delete g_ModeScript.ModeUserConsoleCommand;
		}
		if ("MapUserConsoleCommand" in g_ModeScript)
		{
			if (g_ModeScript.MapUserConsoleCommand != null && HooksHub.GetUserConsoleCommandByFunc(g_ModeScript.MapUserConsoleCommand) == null)
			{
				HooksHub.SetUserConsoleCommand("L4LMAP", g_ModeScript.MapUserConsoleCommand);
					
				printl("[HooksHub][DEBUG] Init - Added g_MapScript UserConsoleCommand (MapUserConsoleCommand) hook");
			}
			
			delete g_ModeScript.MapUserConsoleCommand;
		}
			
		if ("ModeBotQuery" in g_ModeScript)
		{
			if (g_ModeScript.ModeBotQuery != null && HooksHub.GetBotQueryByFunc(g_ModeScript.ModeBotQuery) == null)
			{
				HooksHub.SetBotQuery("L4LMODE", g_ModeScript.ModeBotQuery);
					
				printl("[HooksHub][DEBUG] Init - Added g_ModeScript BotQuery (ModeBotQuery) hook");
			}
			
			delete g_ModeScript.ModeBotQuery;
		}
		if ("MapBotQuery" in g_ModeScript)
		{
			if (g_ModeScript.MapBotQuery != null && HooksHub.GetBotQueryByFunc(g_ModeScript.MapBotQuery) == null)
			{
				HooksHub.SetBotQuery("L4LMAP", g_ModeScript.MapBotQuery);
					
				printl("[HooksHub][DEBUG] Init - Added g_MapScript BotQuery (MapBotQuery) hook");
			}
			
			delete g_ModeScript.MapBotQuery;
		}
			
		if ("ModeCanPickupObject" in g_ModeScript)
		{
			if (g_ModeScript.ModeCanPickupObject != null && HooksHub.GetCanPickupObjectByFunc(g_ModeScript.ModeCanPickupObject) == null)
			{
				HooksHub.SetCanPickupObject("L4LMODE", g_ModeScript.ModeCanPickupObject);
					
				printl("[HooksHub][DEBUG] Init - Added g_ModeScript CanPickupObject (ModeCanPickupObject) hook");
			}
			
			delete g_ModeScript.ModeCanPickupObject;
		}
		if ("MapCanPickupObject" in g_ModeScript)
		{
			if (g_ModeScript.MapCanPickupObject != null && HooksHub.GetCanPickupObjectByFunc(g_ModeScript.MapCanPickupObject) == null)
			{
				HooksHub.SetCanPickupObject("L4LMAP", g_ModeScript.MapCanPickupObject);
					
				printl("[HooksHub][DEBUG] Init - Added g_MapScript CanPickupObject (MapCanPickupObject) hook");
			}
			
			delete g_ModeScript.MapCanPickupObject;
		}
	}
	
	::HooksHub.Events.OnGameEvent_round_start <- function (params)
	{
		//printl("[HooksHub][DEBUG] OnGameEvent_round_start");

		HooksHub.Init();
		
		HooksHub.DbgPrintFuncs();
	}
	
	printl("[HooksHub][INFO] HooksHub created");
}

__CollectEventCallbacks(::HooksHub.Events, "OnGameEvent_", "GameEventCallbacks", RegisterScriptGameEventListener);
