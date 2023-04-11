//------------------------------------------------------
//     Author : smilzo
//     https://steamcommunity.com/id/smilz0
//------------------------------------------------------

IncludeScript("left4lib_utils");
IncludeScript("left4lib_hooks");

// User levels
enum L4U_LEVEL {
	Griefer = -1,
	User = 0,
	Friend = 1,
	Admin = 2
}

if (!("Left4Users" in getroottable()))
{
	::Left4Users <-
	{
		Settings =
		{
			file_admins = "left4users/cfg/admins.txt"
			file_friends = "left4users/cfg/friends.txt"
			file_griefers = "left4users/cfg/griefers.txt"
		}
		Admins = {}
		OnlineUsers = {}
		JoiningUserids = {}
		Events = {}
	}

	::Left4Users.LoadUsersFromFile <- function (fileName)
	{
		local ret = {};
		
		local admins = Left4Utils.FileToStringList(fileName);
		if (!admins)
			return ret;
		
		foreach (admin in admins)
		{
			local values = split(admin, "//");
			if (values.len() != 2)
				printl("[Left4Users][WARNING] Invalid admin line: " + admin);
			else
			{
				local key = values[0];
				local value = values[1];
				
				if (!key || !value)
					printl("[Left4Users][WARNING] Invalid admin line: " + admin);
				else
				{
					key = strip(key);
					value = strip(value);
					
					ret[key] <- value;
				}
			}
		}
		return ret;
	}

	::Left4Users.SaveAdminsToFile <- function (fileName, admins)
	{
		local adminList = [];
		foreach (key, value in admins)
			adminList.append(key + " //" + value);
		Left4Utils.StringListToFile(fileName, adminList, true);
	}

	::Left4Users.IsInList <- function (steamid, listFile)
	{
		local lines = Left4Utils.FileToStringList(listFile);
		if (!lines)
			return false;
		
		foreach (line in lines)
		{
			local values = split(line, "//");
			if (values.len() != 2)
				printl("[Left4Users][WARNING] Invalid user line in '" + listFile + "': " + line);
			else
			{
				local key = values[0];
				local value = values[1];
				
				if (!key || !value)
					printl("[Left4Users][WARNING] Invalid user line in '" + listFile + "': " + line);
				else
				{
					key = strip(key);
					value = strip(value);
					
					if (key == steamid)
						return true;
				}
			}
		}
		return false;
	}

	::Left4Users.AddToList <- function (steamid, playername, listFile)
	{
		local lines = Left4Utils.FileToStringList(listFile);
		if (!lines)
			lines = [];
		
		lines.append(steamid + " //" + playername);
		Left4Utils.StringListToFile(listFile, lines, true);
	}

	::Left4Users.RemoveFromList <- function (steamid, listFile)
	{
		local lines = Left4Utils.FileToStringList(listFile);
		if (!lines)
			return;
		
		local linesOut = [];
		foreach (line in lines)
		{
			local values = split(line, "//");
			if (values.len() != 2)
				printl("[Left4Users][WARNING] Invalid user line in '" + listFile + "': " + line);
			else
			{
				local key = values[0];
				local value = values[1];
				
				if (!key || !value)
					printl("[Left4Users][WARNING] Invalid user line in '" + listFile + "': " + line);
				else
				{
					key = strip(key);
					value = strip(value);
					
					if (key != steamid)
						linesOut.append(line);
				}
			}
		}
		Left4Utils.StringListToFile(listFile, linesOut, false);
	}

	::Left4Users.AddUser <- function (player, level)
	{
		local steamid = player.GetNetworkIDString();
		if (!steamid || steamid == "BOT")
			return;
		
		Left4Users.RemoveUser(player); // Remove him from any list first
		
		local levelout = L4U_LEVEL.User;
		if (level == "a")
		{
			Left4Users.Admins[steamid] <- player.GetPlayerName();
			Left4Users.SaveAdminsToFile(Left4Users.Settings.file_admins, Left4Users.Admins);
			
			levelout = L4U_LEVEL.Admin;
		}
		else if (level == "f")
		{
			Left4Users.AddToList(steamid, player.GetPlayerName(), Left4Users.Settings.file_friends);
			
			levelout = L4U_LEVEL.Friend;
		}
		else if (level == "g")
		{
			Left4Users.AddToList(steamid, player.GetPlayerName(), Left4Users.Settings.file_griefers);
			
			levelout = L4U_LEVEL.Griefer;
		}
		
		// Update his online users level
		local userid = player.GetPlayerUserId();
		if (userid in ::Left4Users.OnlineUsers)
			Left4Users.OnlineUsers[userid] <- levelout;
	}
	
	::Left4Users.RemoveUser <- function (player)
	{
		local steamid = player.GetNetworkIDString();
		if (!steamid || steamid == "BOT")
			return;
		
		local userid = player.GetPlayerUserId();
		if (!(userid in ::Left4Users.OnlineUsers) || Left4Users.OnlineUsers[userid] == L4U_LEVEL.User)
			return; // No need to remove
		
		// Turn him into a normal user
		Left4Users.OnlineUsers[userid] <- L4U_LEVEL.User;
		
		// Remove him from any list
		if (steamid in ::Left4Users.Admins)
		{
			delete ::Left4Users.Admins[steamid];
			Left4Users.SaveAdminsToFile(Left4Users.Settings.file_admins, Left4Users.Admins);
		}
		Left4Users.RemoveFromList(steamid, Left4Users.Settings.file_friends);
		Left4Users.RemoveFromList(steamid, Left4Users.Settings.file_griefers);
	}

	::Left4Users.GetSteamIDUserLevel <- function (steamid)
	{
		if (!steamid)
			return L4U_LEVEL.User;
		else if (steamid in ::Left4Users.Admins)
			return L4U_LEVEL.Admin;
		else if (Left4Users.IsInList(steamid, Left4Users.Settings.file_friends))
			return L4U_LEVEL.Friend;
		else if (Left4Users.IsInList(steamid, Left4Users.Settings.file_griefers))
			return L4U_LEVEL.Griefer;
		else
			return L4U_LEVEL.User;
	}

	::Left4Users.GetUserLevel <- function (player)
	{
		if (!player || !player.IsValid())
			return L4U_LEVEL.User;
		
		local steamid = player.GetNetworkIDString();
		if (!steamid || steamid == "BOT")
			return L4U_LEVEL.User; // player is a bot
		
		if (Director.IsSinglePlayerGame())
			return L4U_LEVEL.Admin; // It's a single player game, player is supposed to be the only user here. Will give him admin privileges
		
		local host = GetListenServerHost();
		if (host && host == player)
		{
			if (!(steamid in ::Left4Users.Admins))
			{
				// player is the host but wasn't added to the admins list yet. Add now
				
				// But remove him from any other list first
				Left4Users.RemoveFromList(steamid, Left4Users.Settings.file_friends);
				Left4Users.RemoveFromList(steamid, Left4Users.Settings.file_griefers);
				
				Left4Users.Admins[steamid] <- player.GetPlayerName();
				Left4Users.SaveAdminsToFile(Left4Users.Settings.file_admins, Left4Users.Admins);
				
				printl("[Left4Users][INFO] Local host " + player.GetPlayerName() + " has been added to the admins list");
			}
			return L4U_LEVEL.Admin;
		}
		
		return Left4Users.GetSteamIDUserLevel(steamid);
	}

	::Left4Users.GetOnlineUserLevel <- function (userid)
	{
		if (userid in ::Left4Users.OnlineUsers)
			return Left4Users.OnlineUsers[userid];
		else
			return L4U_LEVEL.User;
	}

	::Left4Users.PlayerIn <- function (player, isJoin = false)
	{
		local level = Left4Users.GetUserLevel(player);
		
		//printl("[Left4Users][DEBUG] PlayerIn - player: " + player.GetPlayerName() + " - level: " + level);
		
		Left4Users.OnlineUsers[player.GetPlayerUserId()] <- level;
		
		if (isJoin)
		{
			printl("[Left4Users][INFO] Player joined: " + player.GetPlayerName());
			
			if (level == L4U_LEVEL.Admin)
				Left4Users.AdminNotice("\x03" + "Admin " + player.GetPlayerName() + " joined");
			else if (level == L4U_LEVEL.Friend)
				Left4Users.AdminNotice("\x05" + "Friend " + player.GetPlayerName() + " joined");
			else if (level == L4U_LEVEL.Griefer)
				Left4Users.AdminNotice("\x04" + "Griefer " + player.GetPlayerName() + " joined");
			else
				Left4Users.AdminNotice("\x01" + "User " + player.GetPlayerName() + " joined");
		}
	}

	::Left4Users.PlayerOut <- function (userid, player)
	{
		//if (player &&  player.IsValid())
		//	printl("[Left4Users][DEBUG] PlayerOut - player: " + player.GetPlayerName() + " - userid: " + userid);
		//else
		//	printl("[Left4Users][DEBUG] PlayerOut - userid: " + userid);
		
		if (userid in ::Left4Users.OnlineUsers)
			delete ::Left4Users.OnlineUsers[userid];
	}
	
	::Left4Users.AdminNotice <- function (msg)
	{
		// TODO: settings
		
		foreach (userid, level in ::Left4Users.OnlineUsers)
		{
			if (level == L4U_LEVEL.Admin)
			{
				local p = g_MapScript.GetPlayerFromUserID(userid);
				if (p)
					ClientPrint(p, 3, msg);
			}
		}
	}
	
	::Left4Users.InterceptChat <- function (msg, speaker)
	{
		if (!speaker || !speaker.IsValid())
			return true;
		
		// Removing the ending \r\n
		if (msg.find("\n", msg.len() - 1) != null || msg.find("\r", msg.len() - 1) != null)
			msg = msg.slice(0, msg.len() - 1);
		if (msg.find("\n", msg.len() - 1) != null || msg.find("\r", msg.len() - 1) != null)
			msg = msg.slice(0, msg.len() - 1);
		
		//printl("[Left4Users][DEBUG] InterceptChat - speaker: " + speaker.GetPlayerName() + " - msg: " + msg);
		
		local name = speaker.GetPlayerName() + ": ";
		local text = strip(msg.slice(msg.find(name) + name.len())); // Remove the speaker's name part from the message
		local args = {};
		if (text != null && text != "")
			args = split(text, " ");
		
		if (args.len() < 2)
			return true; // L4U commands have at least 2 arguments ("l4u" and "command")
		
		if (args[0].tolower() != "!l4u")
			return; // Not a L4U command
		
		if (Left4Users.GetOnlineUserLevel(speaker.GetPlayerUserId()) < L4U_LEVEL.Admin)
		{
			printl("[Left4Users][INFO] Non admin " + speaker.GetPlayerName() + " tried to use a L4U command: " + text);
			return true;
		}
		
		local cmd = strip(args[1].tolower());
		local arg1 = null;
		local arg2 = null;
		
		if (args.len() > 2)
			arg1 = strip(args[2].tolower());
			
		if (args.len() > 3)
			arg2 = strip(args[3].tolower());
		
		local isCommand = Left4Users.OnAdminCommand(speaker, cmd, arg1, arg2);
		if (isCommand /*&& Left4Users.Settings.hide_chat_commands*/)
			return false;
		else
			return true;
	}
	
	::Left4Users.UserConsoleCommand <- function (playerScript, arg)
	{
		local args = {};
		if (arg != null && arg != "")
			args = split(arg, ",");
		
		if (args.len() < 2) // L4U commands have at least 2 arguments ("l4u" and "command")
			return;
		
		if (args[0].tolower() != "l4u")
			return; // Not a L4U command
		
		if (Left4Users.GetOnlineUserLevel(playerScript.GetPlayerUserId()) < L4U_LEVEL.Admin)
		{
			printl("[Left4Users][INFO] Non admin " + playerScript.GetPlayerName() + " tried to use a L4U command: " + arg);
			return;
		}
		
		local cmd = strip(args[1].tolower());
		local arg1 = null;
		local arg2 = null;
		
		if (args.len() > 2)
			arg1 = strip(args[2].tolower());
			
		if (args.len() > 3)
			arg2 = strip(args[3].tolower());
		
		Left4Users.OnAdminCommand(playerScript, cmd, arg1, arg2);
	}
	
	::Left4Users.OnAdminCommand <- function (player, cmd, arg1, arg2)
	{
		//printl("[Left4Users][DEBUG] OnAdminCommand - player: " + player.GetPlayerName() + " - cmd: " + cmd + " - arg1: " + arg1 + " - arg2: " + arg2);
		
		local target = null;
		if (arg1)
		{
			target = Left4Utils.GetPlayerFromName(arg1);
			if (target && IsPlayerABot(target) && NetProps.GetPropInt(target, "m_humanSpectatorUserID") > 0)
				target = g_MapScript.GetPlayerFromUserID(NetProps.GetPropInt(target, "m_humanSpectatorUserID")); // If it's a bot, get it's human spectator (if any)
			
			if (target && IsPlayerABot(target))
				target = null;
		}
		
		local level = null;
		local list = null;
		if (arg2 != null)
		{
			if (arg2 == "a" || arg2 == "admin")
			{
				level = "a";
				list = "admins";
			}
			else if (arg2 == "f" || arg2 == "friend")
			{
				level = "f";
				list = "friends";
			}
			else if (arg2 == "g" || arg2 == "griefer")
			{
				level = "g";
				list = "griefers";
			}
		}
		
		switch (cmd)
		{
			case "add":
			{
				if (!target || !target.IsValid())
					ClientPrint(player, 3, "\x04" + "Invalid target (usage: !l4u add [target] [admin/friend/griefer])");
				else if (!level)
					ClientPrint(player, 3, "\x04" + "Invalid level (usage: !l4u add [target] [admin/friend/griefer])");
				else
				{
					Left4Users.AddUser(target, level);
					ClientPrint(player, 3, "\x05" + target.GetPlayerName() + " added to the " + list + " list");
					
					printl("[Left4Users][INFO] " + player.GetPlayerName() + " added " + target.GetPlayerName() + " to the " + list + " list");
				}
				
				return true;
			}
			case "remove":
			{
				if (!target || !target.IsValid())
					ClientPrint(player, 3, "\x04" + "Invalid target (usage: !l4u remove [target])");
				else
				{
					Left4Users.RemoveUser(target);
					ClientPrint(player, 3, "\x05" + target.GetPlayerName() + " removed from all lists");
					
					printl("[Left4Users][INFO] " + player.GetPlayerName() + " removed " + target.GetPlayerName());
				}
				
				return true;
			}
			case "online":
			{
				local t = "";
				foreach (userid, level in ::Left4Users.OnlineUsers)
				{
					local p = g_MapScript.GetPlayerFromUserID(userid);
					if (p)
					{
						local l = "U";
						if (level == L4U_LEVEL.Admin)
							l = "A";
						else if (level == L4U_LEVEL.Friend)
							l = "F";
						else if (level == L4U_LEVEL.Griefer)
							l = "G";
						
						if (t == "")
							t = p.GetPlayerName() + " (" + l + ")";
						else
							t += " - " + p.GetPlayerName() + " (" + l + ")";
					}
				}
				
				ClientPrint(player, 3, "Online Users: " + t);
				
				return true;
			}
			default:
			{
				ClientPrint(player, 3, "\x04" + "Invalid command: " + cmd);
			}
		}
		
		return false;
	}
	
	::Left4Users.Events.OnGameEvent_round_start <- function (params)
	{
		//printl("[Left4Users][DEBUG] OnGameEvent_round_start");
		
		// Admins aren't supposed to be that many, so we can keep them in memory
		Left4Users.Admins = Left4Users.LoadUsersFromFile(Left4Users.Settings.file_admins);
		
		::HooksHub.SetUserConsoleCommand("Left4Users", ::Left4Users.UserConsoleCommand);
		::HooksHub.SetInterceptChat("Left4Users", ::Left4Users.InterceptChat);

		foreach (player in ::Left4Utils.GetHumanPlayers())
			Left4Users.PlayerIn(player);
	}

	::Left4Users.Events.OnGameEvent_player_connect <- function (params)
	{
		if ("userid" in params)
		{
			local userid = params["userid"];
			//local player = g_MapScript.GetPlayerFromUserID(userid); // player's entity hasn't been created yet
			local name = null;
			local index = null;
			local address = null;
			local steamid = null;
			local xuid = null;
			local bot = null;
			
			if ("name" in params)
				name = params["name"];
			if ("index" in params)
				index = params["index"];
			if ("address" in params)
				address = params["address"];
			if ("networkid" in params)
				steamid = params["networkid"];
			if ("xuid" in params)
				xuid = params["xuid"];
			if ("bot" in params)
				bot = params["bot"];

			if (!bot && steamid != "BOT")
			{
				printl("[Left4Users][INFO] Player connected: " + name + " - userid: " + userid + " - index: " + index + " - address: " + address + " - steamid: " + steamid + " - xuid: " + xuid + " - bot: " + bot);

				::Left4Users.JoiningUserids[userid] <- 1;

				if (name)
				{
					local level = Left4Users.GetSteamIDUserLevel(steamid);

					if (level == L4U_LEVEL.Admin)
						Left4Users.AdminNotice("\x03" + "Admin " + name + " connected");
					else if (level == L4U_LEVEL.Friend)
						Left4Users.AdminNotice("\x05" + "Friend " + name + " connected");
					else if (level == L4U_LEVEL.Griefer)
						Left4Users.AdminNotice("\x04" + "Griefer " + name + " connected");
					else
						Left4Users.AdminNotice("\x01" + "User " + name + " connected");
				}
			}
		}
	}

	::Left4Users.Events.OnGameEvent_player_connect_full <- function (params)
	{
		if ("userid" in params)
		{
			local userid = params["userid"];
			local player = g_MapScript.GetPlayerFromUserID(userid);

			local joining = userid in ::Left4Users.JoiningUserids;
			if (joining)
				delete ::Left4Users.JoiningUserids[userid];

			if (player && player.IsValid() && !IsPlayerABot(player))
				Left4Users.PlayerIn(player, joining);
		}
	}

	::Left4Users.Events.OnGameEvent_player_spawn <- function (params)
	{
		if ("userid" in params)
		{
			local player = g_MapScript.GetPlayerFromUserID(params["userid"]);
		
			//printl("[Left4Users][DEBUG] OnGameEvent_player_spawn - player: " + player.GetPlayerName());
		
			if (player && player.IsValid() && !IsPlayerABot(player))
				Left4Users.PlayerIn(player);
		}
	}

	::Left4Users.Events.OnGameEvent_bot_player_replace <- function (params)
	{
		local player = g_MapScript.GetPlayerFromUserID(params["player"]);
		
		//printl("[Left4Users][DEBUG] OnGameEvent_bot_player_replace - player: " + player.GetPlayerName());
		
		if (player && player.IsValid() && !IsPlayerABot(player))
			Left4Users.PlayerIn(player);
	}

	::Left4Users.Events.OnGameEvent_player_disconnect <- function (params)
	{
		if ("userid" in params)
		{
			local userid = params["userid"];
			local player = g_MapScript.GetPlayerFromUserID(userid);

			if (userid in ::Left4Users.JoiningUserids)
				delete ::Left4Users.JoiningUserids[userid];

			if (player && player.IsValid() && IsPlayerABot(player))
				return;

			if (player && player.IsValid())
				printl("[Left4Users][INFO] Player disconnected: " + player.GetPlayerName());

			Left4Users.PlayerOut(userid, player);
		}
	}

	::Left4Users.Events.OnGameEvent_round_end <- function (params)
	{
		//printl("[Left4Users][DEBUG] OnGameEvent_round_end");
		
		::HooksHub.RemoveUserConsoleCommand("Left4Users");
		::HooksHub.RemoveInterceptChat("Left4Users");
	}

	::Left4Users.Events.OnGameEvent_map_transition <- function (params)
	{
		//printl("[Left4Users][DEBUG] OnGameEvent_map_transition");
		
		::HooksHub.RemoveUserConsoleCommand("Left4Users");
		::HooksHub.RemoveInterceptChat("Left4Users");
	}
}

__CollectEventCallbacks(::Left4Users.Events, "OnGameEvent_", "GameEventCallbacks", RegisterScriptGameEventListener);
