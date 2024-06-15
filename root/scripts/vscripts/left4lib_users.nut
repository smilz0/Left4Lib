//------------------------------------------------------
//     Author : smilzo
//     https://steamcommunity.com/id/smilz0
//------------------------------------------------------
/*
	Centralized users management.
	
	NOTE: ::Left4Users isn't available until another addon includes this script.
	
	To use add:
		IncludeScript("left4lib_users");
	on top of your script.
	
	Players are automatically assigned their user level when they join the server depending on the list they belong to.
	Admins can add/remove users to a certain list with the:
		l4u add playername level
	chat/console command.
	
	The only things you may want to do from your script are:
		Left4Users.GetOnlineUserLevel(userid); // to know the L4U_LEVEL of the player with the given userid (player.GetPlayerUserId())
		Left4Users.IsJustJoined(userid); // returns whether the given player has joined in the current round (true) or in a previous one (false)
		Left4Users.AdminNotice(msg); // sends the given message to all the connected admin users
*/

IncludeScript("left4lib_consts");
IncludeScript("left4lib_utils");
IncludeScript("left4lib_hooks");
IncludeScript("left4lib_settingsmanager");

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
		Admins = {}
		OnlineUsers = {}
		OnlineBots = {}
		PrevOnlineUsers = {}
		PrevOnlineBots = {}
		Events = {}
		TerrorPlayerManager = null
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
				::Left4Lib.Logger.Warning("Left4Users.LoadUsersFromFile - Invalid admin line: " + admin);
			else
			{
				local key = values[0];
				local value = values[1];
				
				if (!key || !value)
					::Left4Lib.Logger.Warning("Left4Users.LoadUsersFromFile - Invalid admin line: " + admin);
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
				::Left4Lib.Logger.Warning("Left4Users.LoadUsersFromFile - Invalid user line in '" + listFile + "': " + line);
			else
			{
				local key = values[0];
				local value = values[1];
				
				if (!key || !value)
					::Left4Lib.Logger.Warning("Left4Users.LoadUsersFromFile - Invalid user line in '" + listFile + "': " + line);
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
				::Left4Lib.Logger.Warning("Left4Users.RemoveFromList - Invalid user line in '" + listFile + "': " + line);
			else
			{
				local key = values[0];
				local value = values[1];
				
				if (!key || !value)
					::Left4Lib.Logger.Warning("Left4Users.RemoveFromList - Invalid user line in '" + listFile + "': " + line);
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
		
		RemoveUser(player); // Remove him from any list first
		
		local levelout = L4U_LEVEL.User;
		if (level == "a")
		{
			Admins[steamid] <- player.GetPlayerName();
			SaveAdminsToFile(Left4Lib.Settings.users_file_admins, Admins);
			
			levelout = L4U_LEVEL.Admin;
		}
		else if (level == "f")
		{
			AddToList(steamid, player.GetPlayerName(), Left4Lib.Settings.users_file_friends);
			
			levelout = L4U_LEVEL.Friend;
		}
		else if (level == "g")
		{
			AddToList(steamid, player.GetPlayerName(), Left4Lib.Settings.users_file_griefers);
			
			levelout = L4U_LEVEL.Griefer;
		}
		
		// Update his online users level
		local userid = player.GetPlayerUserId();
		if (userid in OnlineUsers)
			OnlineUsers[userid].level = levelout;
	}
	
	::Left4Users.RemoveUser <- function (player)
	{
		local steamid = player.GetNetworkIDString();
		if (!steamid || steamid == "BOT")
			return;
		
		local userid = player.GetPlayerUserId();
		if (!(userid in OnlineUsers) || OnlineUsers[userid].level == L4U_LEVEL.User)
			return; // No need to remove
		
		// Turn him into a normal user
		OnlineUsers[userid].level = L4U_LEVEL.User;
		
		// Remove him from any list
		if (steamid in Admins)
		{
			delete Admins[steamid];
			SaveAdminsToFile(Left4Lib.Settings.users_file_admins, Admins);
		}
		RemoveFromList(steamid, Left4Lib.Settings.users_file_friends);
		RemoveFromList(steamid, Left4Lib.Settings.users_file_griefers);
	}

	::Left4Users.GetSteamIDUserLevel <- function (steamid)
	{
		if (!steamid)
			return L4U_LEVEL.User;
		else if (steamid in Admins)
			return L4U_LEVEL.Admin;
		else if (IsInList(steamid, Left4Lib.Settings.users_file_friends))
			return L4U_LEVEL.Friend;
		else if (IsInList(steamid, Left4Lib.Settings.users_file_griefers))
			return L4U_LEVEL.Griefer;
		else
			return L4U_LEVEL.User;
	}

	::Left4Users.GetUserLevel <- function (player)
	{
		if (!player || !player.IsValid())
		{
			::Left4Lib.Logger.Debug("Left4Users.GetUserLevel - player: " + player);
			return L4U_LEVEL.User;
		}
		
		local steamid = player.GetNetworkIDString();
		if (!steamid || steamid == "BOT")
		{
			::Left4Lib.Logger.Debug("Left4Users.GetUserLevel - steamid: " + steamid);
			return L4U_LEVEL.User; // player is a bot
		}
		
		if (Director.IsSinglePlayerGame())
		{
			::Left4Lib.Logger.Debug("Left4Users.GetUserLevel - IsSinglePlayerGame");
			return L4U_LEVEL.Admin; // It's a single player game, player is supposed to be the only user here. Will give him admin privileges
		}
		
		local host = GetListenServerHost();
		if (host && host == player)
		{
			if (!(steamid in Admins))
			{
				// player is the host but wasn't added to the admins list yet. Add now
				
				// But remove him from any other list first
				RemoveFromList(steamid, Left4Lib.Settings.users_file_friends);
				RemoveFromList(steamid, Left4Lib.Settings.users_file_griefers);
				
				Admins[steamid] <- player.GetPlayerName();
				SaveAdminsToFile(Left4Lib.Settings.users_file_admins, Admins);
				
				::Left4Lib.Logger.Info("Local host " + player.GetPlayerName() + " has been added to the admins list");
			}
			else
				::Left4Lib.Logger.Debug("Left4Users.GetUserLevel - steamid in Admins");

			return L4U_LEVEL.Admin;
		}
		
		return GetSteamIDUserLevel(steamid);
	}

	::Left4Users.GetOnlineUserLevel <- function (userid)
	{
		if (userid in OnlineUsers)
			return OnlineUsers[userid].level;
		else
			return L4U_LEVEL.User;
	}

	::Left4Users.PlayerJoined <- function (player)
	{
		local userid = player.GetPlayerUserId();
		local steamid = player.GetNetworkIDString();
		local index = player.GetEntityIndex();
		local level = GetUserLevel(player);
		local tm = Director.GetTotalElapsedMissionTime();
		local joined = false;
		
		::Left4Lib.Logger.Debug("Left4Users.PlayerJoined - player: " + player.GetPlayerName() + " - level: " + level);
		
		if ((userid in OnlineUsers) && OnlineUsers[userid].conntime <= tm)
		{
			// It's an already connected player
			::Left4Lib.Logger.Debug("Left4Users.PlayerJoined - " + player.GetPlayerName() + " is an already connected player");
			
			if (!OnlineUsers[userid].connfull)
			{
				// Player went from connected to joined
				::Left4Lib.Logger.Debug("Left4Users.PlayerJoined - " + player.GetPlayerName() + " went from connected to joined");
				
				OnlineUsers[userid].connfull = 1;
				joined = true;
			}
			OnlineUsers[userid].level = level;
		}
		else
		{
			if (steamid in PrevOnlineUsers)
			{
				// It's an already connected player from previous round
				::Left4Lib.Logger.Debug("Left4Users.PlayerJoined - " + player.GetPlayerName() + " is an already connected player from previous round");
				
				OnlineUsers[userid] <- { steamid = steamid, index = index, level = level, conntime = PrevOnlineUsers[steamid].conntime, connfull = 1, firstround = 0 };
			}
			else
			{
				// It's a new player (likely a missing connected event)
				::Left4Lib.Logger.Debug("Left4Users.PlayerJoined - " + player.GetPlayerName() + " is a new player");
				
				OnlineUsers[userid] <- { steamid = steamid, index = index, level = level, conntime = tm, connfull = 1, firstround = 1 };
				joined = true;
			}
		}
		
		if (joined)
		{
			::Left4Lib.Logger.Info("Player joined: " + player.GetPlayerName());
			
			//::Left4Users.SaveTempOnlineUsers();
		
			if (level == L4U_LEVEL.Admin)
				AdminNotice("\x03" + "Admin " + player.GetPlayerName() + " joined");
			else if (level == L4U_LEVEL.Friend)
				AdminNotice("\x05" + "Friend " + player.GetPlayerName() + " joined");
			else if (level == L4U_LEVEL.Griefer)
				AdminNotice("\x04" + "Griefer " + player.GetPlayerName() + " joined");
			else
				AdminNotice("\x01" + "User " + player.GetPlayerName() + " joined");
		}
		
		::Left4Users.HandleMaxHumanPlayers();
	}

	::Left4Users.AdminNotice <- function (msg)
	{
		if (!Left4Lib.Settings.users_admin_notice)
			return;
		
		foreach (userid, usr in OnlineUsers)
		{
			if (usr.connfull && usr.level == L4U_LEVEL.Admin)
			{
				local p = g_MapScript.GetPlayerFromUserID(userid);
				if (p)
					ClientPrint(p, 3, msg);
			}
		}
	}
	
	::Left4Users.IsJustJoined <- function (userid)
	{
		return ((userid in OnlineUsers) && OnlineUsers[userid].firstround);
	}
	
	::Left4Users.SaveTempOnlineUsers <- function ()
	{
		local t = {};
		foreach (userid, usr in OnlineUsers)
			t[usr.steamid] <- { conntime = usr.conntime };
		
		SaveTable("Left4Users_OnlineUsers", t);
		
		::Left4Lib.Logger.Debug("Left4Users.SaveTempOnlineUsers - Temp OnlineUsers saved:");
		//::Left4Utils.PrintTable(::Left4Users.OnlineUsers);
	}
	
	::Left4Users.RestoreTempOnlineUsers <- function (tblOut)
	{
		local t = {};
		RestoreTable("Left4Users_OnlineUsers", t);
		
		tblOut.clear();
		foreach (steamid, oldusr in t)
			tblOut[steamid] <- { conntime = oldusr.conntime.tointeger() };
		
		::Left4Lib.Logger.Debug("Left4Users.RestoreTempOnlineUsers - Temp OnlineUsers restored:");
		//::Left4Utils.PrintTable(tblOut);
	}
	
	::Left4Users.HandleMaxHumanPlayers <- function (connectingID = null, connectingLevel = -1)
	{
		// No one to kick in single player mode
		if (Director.IsSinglePlayerGame())
			return null;
		
		local n = OnlineUsers.len() + (connectingID != null).tointeger();
		if (::Left4Lib.Settings.users_max_human_players < 0 || n <= ::Left4Lib.Settings.users_max_human_players)
		{
			// Limit not exceeded yet, no one to kick
			::Left4Lib.Logger.Debug("Left4Users.HandleMaxHumanPlayers - No one to kick");
			return null;
		}
		
		// Limit exceeded, someone has to be kicked. Let's find the one with the lowest priority
		
		local hostID = null;
		local hostPlayer = GetListenServerHost();
		if (hostPlayer && hostPlayer.IsValid())
			hostID = hostPlayer.GetNetworkIDString();
		
		local kickid = null;
		local kicklevel = -1;
		local kickconntime = Director.GetTotalElapsedMissionTime();
		
		if (connectingID && connectingID != hostID)
		{
			// Let's start from the connecting player (if any and he is not the host)
			kickid = connectingID;
			kicklevel = connectingLevel;
		}
		
		::Left4Lib.Logger.Debug("Left4Users.HandleMaxHumanPlayers - Search start: kickid: " + kickid + " - kicklevel: " + kicklevel + " - kickconntime: " + kickconntime);
		
		foreach (userid, usr in OnlineUsers)
		{
			if (usr.steamid != hostID && (!kickid || usr.level < kicklevel || (usr.level == kicklevel && usr.conntime > kickconntime)))
			{
				kickid = usr.steamid;
				kicklevel = usr.level;
				kickconntime = usr.conntime;
				
				::Left4Lib.Logger.Debug("Left4Users.HandleMaxHumanPlayers - Search swap: kickid: " + kickid + " - kicklevel: " + kicklevel + " - kickconntime: " + kickconntime);
			}
		}
		
		::Left4Lib.Logger.Debug("Left4Users.HandleMaxHumanPlayers - Search end: kickid: " + kickid + " - kicklevel: " + kicklevel + " - kickconntime: " + kickconntime);
		
		if (!kickid)
		{
			::Left4Lib.Logger.Debug("Left4Users.HandleMaxHumanPlayers - No kick candidate found");
			return null;
		}
		
		// If we are checking against a connecting player and the one to kick is a previously connected one, don't kick anyone for now, wait until this one is fully connected
		if (connectingID && kickid != connectingID)
		{
			::Left4Lib.Logger.Debug("Left4Users.HandleMaxHumanPlayers - Kick delayed");
			return null;
		}
		
		SendToServerConsole("kickid " + kickid + " " + Left4Lib.Settings.users_full_kick_reason);
		::Left4Lib.Logger.Info("Player with steam ID " + kickid + " kicked with reason: " + Left4Lib.Settings.users_full_kick_reason);
		
		// Must remove the kicked player from OnlineUsers to avoid multiple kick to the same player when multiple joined events in the same frame
		foreach (userid, usr in OnlineUsers)
		{
			if (usr.steamid == kickid)
			{
				delete OnlineUsers[userid];
				::Left4Lib.Logger.Debug("Deleted from OnlineUsers");
				break;
			}
		}
		
		return kickid;
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
		
		local name = speaker.GetPlayerName() + ": ";
		local text = strip(msg.slice(msg.find(name) + name.len())); // Remove the speaker's name part from the message
		local args = {};
		if (text != null && text != "")
			args = split(text, " ");
		
		if (args.len() < 2)
			return true; // L4U commands have at least 2 arguments ("l4u" and "command")
		
		if (args[0].tolower() != "!l4u")
			return; // Not a L4U command
		
		if (GetOnlineUserLevel(speaker.GetPlayerUserId()) < L4U_LEVEL.Admin)
		{
			::Left4Lib.Logger.Info("Non admin " + speaker.GetPlayerName() + " tried to use a L4U command: " + text);
			return true;
		}
		
		local cmd = strip(args[1].tolower());
		local arg1 = null;
		local arg2 = null;
		
		if (args.len() > 2)
			arg1 = strip(args[2].tolower());
			
		if (args.len() > 3)
			arg2 = strip(args[3].tolower());
		
		local isCommand = OnAdminCommand(speaker, cmd, arg1, arg2);
		if (isCommand /*&& Left4Lib.Settings.hide_chat_commands*/)
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
		
		if (GetOnlineUserLevel(playerScript.GetPlayerUserId()) < L4U_LEVEL.Admin)
		{
			::Left4Lib.Logger.Info("Non admin " + playerScript.GetPlayerName() + " tried to use a L4U command: " + arg);
			return;
		}
		
		local cmd = strip(args[1].tolower());
		local arg1 = null;
		local arg2 = null;
		
		if (args.len() > 2)
			arg1 = strip(args[2].tolower());
			
		if (args.len() > 3)
			arg2 = strip(args[3].tolower());
		
		OnAdminCommand(playerScript, cmd, arg1, arg2);
	}
	
	::Left4Users.OnAdminCommand <- function (player, cmd, arg1, arg2)
	{
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
					AddUser(target, level);
					ClientPrint(player, 3, "\x05" + target.GetPlayerName() + " added to the " + list + " list");
					
					::Left4Lib.Logger.Info(player.GetPlayerName() + " added " + target.GetPlayerName() + " to the " + list + " list");
				}
				
				return true;
			}
			case "remove":
			{
				if (!target || !target.IsValid())
					ClientPrint(player, 3, "\x04" + "Invalid target (usage: !l4u remove [target])");
				else
				{
					RemoveUser(target);
					ClientPrint(player, 3, "\x05" + target.GetPlayerName() + " removed from all lists");
					
					::Left4Lib.Logger.Info(player.GetPlayerName() + " removed " + target.GetPlayerName());
				}
				
				return true;
			}
			case "online":
			{
				local t = "";
				foreach (userid, usr in OnlineUsers)
				{
					local p = g_MapScript.GetPlayerFromUserID(userid);
					if (p)
					{
						local l = "U";
						if (usr.level == L4U_LEVEL.Admin)
							l = "A";
						else if (usr.level == L4U_LEVEL.Friend)
							l = "F";
						else if (usr.level == L4U_LEVEL.Griefer)
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
		// Admins aren't supposed to be that many, so we can keep them in memory
		::Left4Users.Admins = ::Left4Users.LoadUsersFromFile(Left4Lib.Settings.users_file_admins);
		
		::HooksHub.SetUserConsoleCommand("Left4Users", ::Left4Users.UserConsoleCommand.bindenv(::Left4Users));
		::HooksHub.SetInterceptChat("Left4Users", ::Left4Users.InterceptChat.bindenv(::Left4Users));

		::Left4Users.RestoreTempOnlineUsers(::Left4Users.PrevOnlineUsers);
		
		::Left4Users.PrevOnlineBots.clear();
		RestoreTable("Left4Users_OnlineBots", ::Left4Users.PrevOnlineBots);
		::Left4Lib.Logger.Debug("OnGameEvent_round_start - Temp OnlineBots restored:");
		//::Left4Utils.PrintTable(::Left4Users.PrevOnlineBots);

		foreach (player in ::Left4Utils.GetHumanPlayers())
			::Left4Users.PlayerJoined(player);
	}

	::Left4Users.Events.OnGameEvent_player_connect <- function (params)
	{
		if (!("userid" in params))
			return;
		
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
		
		if (bot || steamid == "BOT")
		{
			::Left4Lib.Logger.Debug("Bot connected: " + name + " - userid: " + userid + " - index: " + index + " - address: " + address + " - steamid: " + steamid + " - xuid: " + xuid + " - bot: " + bot);
			
			local botid = "BOT_" + (index + 1).tostring();
			if (botid in ::Left4Users.OnlineBots)
				::Left4Lib.Logger.Debug("Connected bot " + name + " (" + botid + ") was already in OnlineBots");
			
			::Left4Users.OnlineBots[botid] <- { userid = userid, name = name, index = (index + 1) };
			
			::Left4Lib.Logger.Debug("OnlineBots[" + botid + "]: userid = " + userid + " - name = " + ::Left4Users.OnlineBots[botid].name + " - index = " + ::Left4Users.OnlineBots[botid].index);
			::Left4Lib.Logger.Debug("OnlineBots.len() = " + ::Left4Users.OnlineBots.len());
			
			return;
		}

		local level = ::Left4Users.GetSteamIDUserLevel(steamid);
		
		::Left4Lib.Logger.Info("Player connected: " + name + " - userid: " + userid + " - index: " + index + " - address: " + address + " - steamid: " + steamid + " - xuid: " + xuid + " - bot: " + bot + " - level: " + level);

		local kickedid = ::Left4Users.HandleMaxHumanPlayers(steamid, level);
		if (kickedid == steamid)
			return; // This connecting player was kicked
		
		::Left4Users.OnlineUsers[userid] <- { steamid = steamid, index = (index + 1), level = level, conntime = Director.GetTotalElapsedMissionTime(), connfull = 0, firstround = 1 };
		
		//::Left4Users.SaveTempOnlineUsers();
		
		if (name)
		{
			if (level == L4U_LEVEL.Admin)
				::Left4Users.AdminNotice("\x03" + "Admin " + name + " connected");
			else if (level == L4U_LEVEL.Friend)
				::Left4Users.AdminNotice("\x05" + "Friend " + name + " connected");
			else if (level == L4U_LEVEL.Griefer)
				::Left4Users.AdminNotice("\x04" + "Griefer " + name + " connected");
			else
				::Left4Users.AdminNotice("\x01" + "User " + name + " connected");
		}
	}

	::Left4Users.Events.OnGameEvent_player_connect_full <- function (params)
	{
		if (!("userid" in params))
			return;

		local player = g_MapScript.GetPlayerFromUserID(params["userid"]);
		
		::Left4Lib.Logger.Debug("Left4Users.Events.OnGameEvent_player_connect_full - player: " + player);
		
		if (player && player.IsValid() && !IsPlayerABot(player))
			::Left4Users.PlayerJoined(player);
	}

	::Left4Users.Events.OnGameEvent_player_spawn <- function (params)
	{
		if (!("userid" in params))
			return;
		
		local player = g_MapScript.GetPlayerFromUserID(params["userid"]);
		
		::Left4Lib.Logger.Debug("Left4Users.Events.OnGameEvent_player_spawn - player: " + player);
		
		if (player && player.IsValid() && !IsPlayerABot(player))
			::Left4Users.PlayerJoined(player);
	}

	::Left4Users.Events.OnGameEvent_bot_player_replace <- function (params)
	{
		local player = g_MapScript.GetPlayerFromUserID(params["player"]);
		
		::Left4Lib.Logger.Debug("Left4Users.Events.OnGameEvent_bot_player_replace - player: " + player);
		
		if (player && player.IsValid() && !IsPlayerABot(player))
			::Left4Users.PlayerJoined(player);
	}

	::Left4Users.Events.OnGameEvent_player_disconnect <- function (params)
	{
		if (!("userid" in params))
			return;
		
		local userid = params["userid"];
		local player = g_MapScript.GetPlayerFromUserID(userid);

		if (player && player.IsValid() && IsPlayerABot(player))
		{
			::Left4Lib.Logger.Debug("Bot disconnected: " + player.GetPlayerName() + " - " + player.GetEntityIndex());
			
			local botid = player.GetEntityIndex();
			if (botid in ::Left4Users.OnlineBots)
				delete ::Left4Users.OnlineBots[botid];
			if (botid in ::Left4Users.PrevOnlineBots)
				delete ::Left4Users.PrevOnlineBots[botid];
			
			::Left4Lib.Logger.Debug("OnlineBots[" + botid + "] removed");
			::Left4Lib.Logger.Debug("OnlineBots.len() = " + ::Left4Users.OnlineBots.len());
			
			return;
		}

		if (player && player.IsValid())
			::Left4Lib.Logger.Info("Player disconnected: " + player.GetPlayerName());

		if (userid in ::Left4Users.OnlineUsers)
			delete ::Left4Users.OnlineUsers[userid];
		else
			::Left4Lib.Logger.Warning("Left4Users - Disconnected was not in OnlineUsers!");
		
		//::Left4Users.SaveTempOnlineUsers();
	}

	::Left4Users.Events.OnGameEvent_round_end <- function (params)
	{
		::Left4Users.SaveTempOnlineUsers();
		
		SaveTable("Left4Users_OnlineBots", ::Left4Users.OnlineBots);
		::Left4Lib.Logger.Debug("OnGameEvent_round_end - Temp OnlineBots saved:");
		//::Left4Utils.PrintTable(::Left4Users.OnlineBots);
		
		::HooksHub.RemoveUserConsoleCommand("Left4Users");
		::HooksHub.RemoveInterceptChat("Left4Users");
	}

	::Left4Users.Events.OnGameEvent_map_transition <- function (params)
	{
		::Left4Users.SaveTempOnlineUsers();
		
		SaveTable("Left4Users_OnlineBots", ::Left4Users.OnlineBots);
		::Left4Lib.Logger.Debug("OnGameEvent_map_transition - Temp OnlineBots saved:");
		//::Left4Utils.PrintTable(::Left4Users.OnlineBots);
		
		::HooksHub.RemoveUserConsoleCommand("Left4Users");
		::HooksHub.RemoveInterceptChat("Left4Users");
		
		local ent = null;
		while (ent = Entities.FindByClassname(ent, "info_transitioning_player"))
		{
			local m_loadingProgress = NetProps.GetPropInt(ent, "m_loadingProgress");
			local m_userID = NetProps.GetPropInt(ent, "m_userID");
			local m_playerName = NetProps.GetPropString(ent, "m_playerName");
			
			printl("OnGameEvent_map_transition - Transitioning: " + m_playerName + " - " + m_userID + " - " + m_loadingProgress);
		}
	}
}

__CollectEventCallbacks(::Left4Users.Events, "OnGameEvent_", "GameEventCallbacks", RegisterScriptGameEventListener);
