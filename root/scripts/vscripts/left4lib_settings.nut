::Left4Lib.Settings <-
{
	// [1/0] Hide (1) / Show (0) the chat commands to the other players
	hooks_chatcommand_hide = 1

	// Trigger for the chat commands
	hooks_chatcommand_trigger = "!"
	
	// [1/0] If 1 the player names in the chat messages from the other players will be replaced by their character names. 0 = Normal chat
	// NOTE: If enabled, the team chat messages will turn into global chat messages
	hooks_chat_hidenames = 0
	
	// Minimum log level for the addon's log lines into the console
	// 0 = No log
	// 1 = Only [ERROR] messages are logged
	// 2 = [ERROR] and [WARNING]
	// 3 = [ERROR], [WARNING] and [INFO]
	// 4 = [ERROR], [WARNING], [INFO] and [DEBUG]
	loglevel = 3
	
	// [1/0] If 1 the sb_all_bot_game cvar will be automatically set to 1 when the first human player connects to the server and 0 when the last human player disconnects, regardless of the convars.txt file.
	// This should prevent the dedicated servers crash on hibernation (as long as nothing else is setting the sb_all_bot_game cvar)
	nocrash_sb_all_bot_game = 1
	
	// [1/0] Enable/Disable the "user connected"/"user joined" admin notifications
	users_admin_notice = 1
	
	// File containing the L4U list of users with the ADMIN level
	users_file_admins = "left4lib/cfg/admins.txt"
	
	// File containing the L4U list of users with the FRIEND level
	users_file_friends = "left4lib/cfg/friends.txt"
	
	// File containing the L4U list of users with the GRIEFER level
	users_file_griefers = "left4lib/cfg/griefers.txt"
	
	// Kick reason for the joining player exceeding users_max_human_players
	users_full_kick_reason = "Sorry, the server is full at the moment. Try again later."
	
	// Max concurrent human players on the server. A joining player that exceedes this number will be automatically kicked with the users_full_kick_reason reason
	// -1 = no limit
	users_max_human_players = -1
}
