::Left4Lib.Settings <-
{
	// [1/0] Enable/Disable the "user connected"/"user joined" admin notifications
	users_admin_notice = 1
	
	// File containing the L4U list of users with the ADMIN level
	users_file_admins = "left4lib/cfg/admins.txt"
	
	// File containing the L4U list of users with the FRIEND level
	users_file_friends = "left4lib/cfg/friends.txt"
	
	// File containing the L4U list of users with the GRIEFER level
	users_file_griefers = "left4lib/cfg/griefers.txt"
	
	// Max concurrent human players on the server. A joining player that exceedes this number will be automatically kicked with the users_full_kick_reason reason
	// -1 = no limit
	users_max_human_players = -1
	
	// Kick reason for the joining player exceeding users_max_human_players
	users_full_kick_reason = "Sorry, the server is full at the moment. Try again later."

	// Trigger for the chat commands
	hooks_chatcommand_trigger = "!"
	
	// [1/0] Hide (1) / Show (0) the chat commands to the other players
	hooks_chatcommand_hide = 1
}
