//------------------------------------------------------
//     Author : smilzo
//     https://steamcommunity.com/id/smilz0
//------------------------------------------------------

const TEAM_UNKNOWN = 0;
const TEAM_SPECTATORS = 1;
const TEAM_SURVIVORS = 2;
const TEAM_INFECTED = 3;
const TEAM_L4D1_SURVIVORS = 4;

const BOT_CMD_ATTACK = 0;
const BOT_CMD_MOVE = 1;
const BOT_CMD_RETREAT = 2;
const BOT_CMD_RESET = 3;

const INV_SLOT_PRIMARY = "slot0";
const INV_SLOT_SECONDARY = "slot1";
const INV_SLOT_THROW = "slot2";
const INV_SLOT_MEDKIT = "slot3";
const INV_SLOT_PILLS = "slot4";

const Z_INFECTED = 0;
const Z_COMMON = 0;
const Z_SMOKER = 1;
const Z_BOOMER = 2;
const Z_HUNTER = 3;
const Z_SPITTER = 4;
const Z_JOCKEY = 5;
const Z_CHARGER = 6;
const Z_WITCH = 7;
const Z_TANK = 8;
const Z_SURVIVOR = 9;
const Z_MOB = 10;
const Z_WITCH_BRIDE = 11;

const S_NICK = 0;
const S_ROCHELLE = 1;
const S_COACH = 2;
const S_ELLIS = 3;
const S_BILL = 0;    // 4
const S_ZOEY = 1;    // 5
const S_LOUIS = 2;   // 6
const S_FRANCIS = 3; // 7
const EXTRA_S_BILL = 4;
const EXTRA_S_ZOEY = 9;
const EXTRA_S_FRANCIS = 6;
const EXTRA_S_LOUIS = 7;

const BUTTON_ATTACK = 1;
const BUTTON_JUMP = 2;
const BUTTON_DUCK = 4;
const BUTTON_FORWARD = 8;
const BUTTON_BACK = 16;
const BUTTON_USE = 32;
const BUTTON_CANCEL = 64;
const BUTTON_LEFT = 128;
const BUTTON_RIGHT = 256;
const BUTTON_MOVELEFT = 512;
const BUTTON_MOVERIGHT = 1024;
const BUTTON_SHOVE = 2048;
const BUTTON_RUN = 4096;
const BUTTON_RELOAD = 8192;
const BUTTON_ALT1 = 16384;
const BUTTON_ALT2 = 32768;
const BUTTON_SCORE = 65536;
const BUTTON_WALK = 131072;
const BUTTON_ZOOM = 524288;
const BUTTON_WEAPON1 = 1048576;
const BUTTON_WEAPON2 = 2097152;
const BUTTON_BULLRUSH = 4194304;
const BUTTON_GRENADE1 = 8388608;
const BUTTON_GRENADE2 = 16777216;
const BUTTON_LOOKSPIN = 0x2000000;

const DMG_GENERIC = 0;
const DMG_CRUSH = 1;
const DMG_BULLET = 2;
const DMG_SLASH = 4;
const DMG_BURN = 8;
const DMG_VEHICLE = 16;
const DMG_FALL = 32;
const DMG_BLAST = 64;
const DMG_CLUB = 128;
const DMG_SHOCK = 256;
const DMG_SONIC = 512;
const DMG_ENERGYBEAM = 1024;
const DMG_PREVENT_PHYSICS_FORCE = 2048;
const DMG_NEVERGIB = 4096;
const DMG_ALWAYSGIB = 8192;
const DMG_DROWN = 16384;
const DMG_PARALYZE = 32768;
const DMG_NERVEGAS = 65536;
const DMG_POISON = 131072;
const DMG_RADIATION = 262144;
const DMG_DROWNRECOVER = 524288;
const DMG_CHOKE = 1048576;
const DMG_ACID = 1048576;
const DMG_MELEE = 2097152;
const DMG_SLOWBURN = 2097152;
const DMG_REMOVENORAGDOLL = 4194304;
const DMG_PHYSGUN = 8388608;
const DMG_PLASMA = 16777216;
const DMG_STUMBLE = 33554432;
const DMG_AIRBOAT = 33554432;
const DMG_DISSOLVE = 67108864;
const DMG_BLAST_SURFACE = 134217728;
const DMG_DIRECT = 268435456;
const DMG_BUCKSHOT = 536870912;
const DMG_HEADSHOT = 1073741824;
const DMG_DISMEMBER = 2147483648;

const TRACE_MASK_ALL = -1;
const TRACE_MASK_SOLID = 33570827;
const TRACE_MASK_NPC_SOLID = 33701899;
const TRACE_MASK_PLAYER_SOLID = 33636363;
const TRACE_MASK_SHOT = 1174421507;
const TRACE_MASK_VISIBLE_AND_NPCS = 33579137;
const TRACE_MASK_VISION = 33579073;
const TRACE_MASK_VISIBLE = 24705;
const TRACE_MASK_SOLID_BRUSHONLY = 16395;

//const TRACE_MASK_DEFAULT = 33570827 // TRACE_MASK_SOLID; // 1174421507 TRACE_MASK_SHOT;
//const TRACE_MASK_DEFAULT = 33579075; // TODO: MASK_BLOCKLOS_AND_NPCS|CONTENTS_IGNORE_NODRAW_OPAQUE
const TRACE_MASK_DEFAULT = 1174421507;

const NAVAREA_SPAWNATTR_BATTLESTATION = 32;
const NAVAREA_SPAWNATTR_FINALE = 64;
const NAVAREA_SPAWNATTR_PLAYER_START = 128;
const NAVAREA_SPAWNATTR_CHECKPOINT = 2048;
const NAVAREA_SPAWNATTR_RESCUE_VEHICLE = 32768;
const NAVAREA_SPAWNATTR_ESCAPE_ROUTE = 131072;
const NAVAREA_SPAWNATTR_DOOR = 262144;

const NAVAREA_DIR_NORTH = 0;
const NAVAREA_DIR_EAST = 1;
const NAVAREA_DIR_SOUTH = 2;
const NAVAREA_DIR_WEST = 3;

const WITCH_ANIM_DUCKING = 4;
const WITCH_ANIM_DUCKING_ANGRY = 27;

const FINDGROUND_MAXHEIGHT = 120; // 70
const FINDGROUND_MINFRACTION = 0.2; // 0.5

// Log levels
const LOG_LEVEL_NONE = 0; // Log always
const LOG_LEVEL_ERROR = 1;
const LOG_LEVEL_WARN = 2;
const LOG_LEVEL_INFO = 3;
const LOG_LEVEL_DEBUG = 4;

if (!("Left4Utils" in getroottable()))
{
	::Left4Utils <-
	{
		DirectorStopped = false
		DirectorStopCVARS = {}
		
		// weapon_spawn weapon ids
		WeaponId =
		{
			none = 0
			weapon_pistol = 1
			weapon_smg = 2
			weapon_pumpshotgun = 3
			weapon_autoshotgun = 4
			weapon_rifle = 5
			weapon_hunting_rifle = 6
			weapon_smg_silenced = 7
			weapon_shotgun_chrome = 8
			weapon_rifle_desert = 9
			weapon_sniper_military = 10
			weapon_shotgun_spas = 11
			weapon_first_aid_kit = 12
			weapon_molotov = 13
			weapon_pipe_bomb = 14
			weapon_pain_pills = 15
			weapon_gascan = 16
			weapon_propanetank = 17
			weapon_oxygentank = 18
			weapon_melee = 19
			weapon_chainsaw = 20
			weapon_grenade_launcher = 21
			weapon_ammo_pack = 22       		// ?
			weapon_adrenaline = 23
			weapon_defibrillator = 24
			weapon_vomitjar = 25
			weapon_rifle_ak47 = 26
			weapon_gnome = 27
			weapon_cola_bottles = 28
			weapon_fireworkcrate = 29
			weapon_upgradepack_incendiary = 30
			weapon_upgradepack_explosive = 31
			weapon_pistol_magnum = 32
			weapon_smg_mp5 = 33
			weapon_rifle_sg552 = 34
			weapon_sniper_awp = 35
			weapon_sniper_scout = 36
			weapon_rifle_m60 = 37
			/*
			weapon_tank_claw = 38
			weapon_hunter_claw = 39
			weapon_charger_claw = 40
			weapon_boomer_claw = 41
			weapon_smoker_claw = 42
			weapon_spitter_claw = 43
			weapon_jockey_claw = 44
			weapon_machinegun = 45
			weapon_vomit = 46
			weapon_splat = 47
			weapon_pounce = 48
			weapon_lounge = 49
			weapon_pull = 50
			weapon_choke = 51
			weapon_rock = 52
			weapon_physics = 53
			*/
			weapon_ammo = 54             		// (weapon_ammo_spawn)
			weapon_upgrade_item = 55      		// (upgrade_*)
		}

		// 
		MeleeWeaponId =
		{
			none = 100
			baseball_bat = 101
			cricket_bat = 102
			crowbar = 103
			electric_guitar = 104
			fireaxe = 105
			frying_pan = 106
			golfclub = 107
			katana = 108
			knife = 109
			machete = 110
			pitchfork = 111
			shovel = 112
			riot_shield = 113
			tonfa = 114
		}

		//
		MeleeWeaponModels =
		{
			none = 100
			w_bat = 101
			w_cricket_bat = 102
			w_crowbar = 103
			w_electric_guitar = 104
			w_fireaxe = 105
			w_frying_pan = 106
			w_golfclub = 107
			w_katana = 108
			w_knife_t = 109
			w_machete = 110
			w_pitchfork = 111
			w_shovel = 112
			w_riotshield = 113
			w_tonfa = 114
		}

		// 
		UpgradeWeaponId =
		{
			none = 200
			upgrade_ammo_explosive = 201
			upgrade_ammo_incendiary = 202
			upgrade_laser_sight = 203
		}
	}

	::Left4Utils.StringReplace <- function (str, orig, replace)
	{
		local expr = regexp(orig);
		local ret = "";
		local pos = 0;
		local captures = null;
		
		while (captures = expr.capture(str, pos))
		{
			foreach (i, c in captures)
			{
				ret += str.slice(pos, c.begin);
				ret += replace;
				pos = c.end;
			}
		}
		
		if (pos < str.len())
			ret += str.slice(pos);

		return ret;
	}

	::Left4Utils.ExtractFileName <- function (path)
	{
		if (!path)
			return null;
		
		local tmp = split(path, "/");
		if (!tmp)
			return null;
			
		local fileNameWithExt = tmp[tmp.len() - 1].tolower();
		tmp = split(fileNameWithExt, ".");
		if (!tmp)
			return fileNameWithExt;
		
		if (tmp.len() > 1)
		{
			local fileExt = tmp[tmp.len() - 1];
			tmp = fileNameWithExt.slice(0, fileNameWithExt.len() - (fileExt.len() + 1));
		}
		else
			tmp = fileNameWithExt;
			
		return strip(tmp);
	}

	::Left4Utils.StripComments <- function (text)
	{
		if (text.find("//") != null)
		{
			text = Left4Utils.StringReplace(text, "//" + ".*", "");
			text = rstrip(text);
			return text;
		}
		return text;
	}

	::Left4Utils.FileExists <- function (fileName)
	{
		local fileContents = FileToString(fileName);
		if (fileContents == null)
			return false;
		
		return true;
	}

	::Left4Utils.FileToStringList <- function (fileName)
	{
		local fileContents = FileToString(fileName);
		if (!fileContents)
			return null;

		fileContents = Left4Utils.StringReplace(fileContents, "\\r", "\n");
		fileContents = Left4Utils.StringReplace(fileContents, "\\n\\n", "\n");   // Basically: any CRLF combination ("\n", "\r", "\r\n") becomes "\n"
		
		return split(fileContents, "\n");
	}

	::Left4Utils.StringListToFile <- function (fileName, stringList, sort = false)
	{
		if (!stringList)
			return false;
		
		if (sort)
			stringList.sort();
		
		local fileContents = "";
		foreach(str in stringList)
		{
			if (fileContents == "")
				fileContents = str;
			else
				fileContents += "\n" + str;
		}
		StringToFile(fileName, fileContents); // StringToFile seems to convert "\n" to the current OS CRLF char(s).
		                                      // Infact it converts "\n" to "\r\n" on Windows - TODO: to confirm it's also the case on Linux and Mac
	}

	::Left4Utils.LoadSettingsFromFile <- function (fileName, scope, logFunc)
	{
		local settings = Left4Utils.FileToStringList(fileName);
		if (!settings)
			return false;

		foreach (setting in settings)
		{
			setting = Left4Utils.StripComments(setting);
			if (setting != "")
			{
				try
				{
					local compiledscript = compilestring(scope + setting);
					compiledscript();
				}
				catch(exception)
				{
					logFunc(LOG_LEVEL_ERROR, exception);
				}
			}
		}
		logFunc(LOG_LEVEL_INFO, "Settings loaded");
		
		return true;
	}

	::Left4Utils.SaveSettingsToFile <- function (fileName, settings, logFunc)
	{
		local settingList = [];
		foreach(key, value in settings)
		{
			if (typeof(value) == "string")
				value = "\"" + value + "\"";
			
			settingList.append(key + " = " + value);
		}
		Left4Utils.StringListToFile(fileName, settingList, true);
		
		logFunc(LOG_LEVEL_INFO, "Settings saved");
	}

	::Left4Utils.PrintSettings <- function (settings, logFunc, prefix = "[Settings] ")
	{
		foreach(key, value in settings)
		{
			if (typeof(value) == "string")
				value = "\"" + value + "\"";
			
			logFunc(LOG_LEVEL_INFO, prefix + key + " = " + value);
		}
	}

	::Left4Utils.LoadAdminsFromFile <- function (fileName, logFunc)
	{
		local ret = {};
		
		local admins = Left4Utils.FileToStringList(fileName);
		if (!admins)
			return ret;
		
		foreach (admin in admins)
		{
			local values = split(admin, "//");
			if (values.len() != 2)
				logFunc(LOG_LEVEL_WARN, "Invalid admin line: " + admin);
			else
			{
				local key = values[0];
				local value = values[1];
				
				if (!key || !value)
					logFunc(LOG_LEVEL_WARN, "Invalid admin line: " + admin);
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

	::Left4Utils.SaveAdminsToFile <- function (fileName, admins)
	{
		local adminList = [];
		foreach (key, value in admins)
			adminList.append(key + " //" + value);
		Left4Utils.StringListToFile(fileName, adminList, true);
	}

	::Left4Utils.LoadCvarsFromFile <- function (fileName, logFunc)
	{
		local count = 0;

		local cvars = Left4Utils.FileToStringList(fileName);
		if (!cvars)
			return count;

		foreach (cvar in cvars)
		{
			//logFunc(LOG_LEVEL_DEBUG, cvar);
			cvar = Left4Utils.StringReplace(cvar, "\\t", "");
			cvar = Left4Utils.StripComments(cvar);
			if (cvar && cvar != "")
			{
				cvar = strip(cvar);
				//logFunc(LOG_LEVEL_DEBUG, cvar);
			
				if (cvar && cvar != "")
				{
					local idx = cvar.find(" ");
					if (idx != null)
					{
						local command = cvar.slice(0, idx);
						command = Left4Utils.StringReplace(command, "\"", "");
						command = strip(command);
						//logFunc(LOG_LEVEL_DEBUG, command);
						
						local value = cvar.slice(idx + 1);
						value = Left4Utils.StringReplace(value, "\"", "");
						value = strip(value);
						
						logFunc(LOG_LEVEL_DEBUG, "CVAR: " + command + " " + value);
						
						Convars.SetValue(command, value);
						
						count++;
					}
				}
			}
		}
		
		return count;
	}

	::Left4Utils.IsFinale <- function ()
	{
		local ent = Entities.FindByClassname(null, "terror_player_manager");
		if (!ent)
			return false;
		
		return (NetProps.GetPropInt(ent, "m_isFinale") > 0) ? true : false;
	}

	// This returns the list index of the nearest entity in the given list from the given player
	::Left4Utils.GetNearestEntityInList <- function (player, entList)
	{
		local ret = null;
		local minDist = 1000000;
		foreach (idx, ent in entList)
		{
			local dist = (ent.GetOrigin() - player.GetOrigin()).Length();
			if (dist < minDist)
			{
				ret = idx;
				minDist = dist;
			}
		}
		return ret;
	}

	::Left4Utils.GetType <- function (entity)
	{
		if (!entity || !entity.IsValid())
			return null;
		
		if (entity.GetClassname() == "infected")
			return Z_COMMON;
		else if (entity.GetClassname() == "witch")
			return Z_WITCH;
		else if (entity.GetClassname() == "player")
		{
			if ("GetZombieType" in entity)
				return entity.GetZombieType();
			
			return null;
		}
		else if (entity.GetClassname() == "survivor_bot")
			return Z_SURVIVOR;
		
		return;
	}
	
	::Left4Utils.GetAllPlayers <- function (team = 0)
	{
		local t = {};
		local ent = null;
		local i = -1;
		while (ent = Entities.FindByClassname(ent, "player"))
		{
			if (ent.IsValid() && (team == 0 || NetProps.GetPropInt(ent, "m_iTeamNum") == team))
				t[++i] <- ent;
		}
		// If a human controlled survivor dies and the player disconnects, the player is temporarily replaced by a bot of class "survivor_bot" instead of "player",
		// until the survivor is respawned or another human player joins and takes control of the survivor but in the meantime the dead survivor isn't listed.
		ent = null;
		while (ent = Entities.FindByClassname(ent, "survivor_bot"))
		{
			if (ent.IsValid())
				t[++i] <- ent;
		}
		return t;
	}

	::Left4Utils.GetHumanPlayers <- function (team = 0)
	{
		local t = {};
		local ent = null;
		local i = -1;
		while (ent = Entities.FindByClassname(ent, "player"))
		{
			if (ent.IsValid() && !IsPlayerABot(ent) && (team == 0 || NetProps.GetPropInt(ent, "m_iTeamNum") == team))
				t[++i] <- ent;
		}
		return t;
	}
	
	::Left4Utils.GetBotPlayers <- function (team = 0)
	{
		local t = {};
		local ent = null;
		local i = -1;
		while (ent = Entities.FindByClassname(ent, "player"))
		{
			if (ent.IsValid() && IsPlayerABot(ent) && (team == 0 || NetProps.GetPropInt(ent, "m_iTeamNum") == team))
				t[++i] <- ent;
		}
		ent = null;
		while (ent = Entities.FindByClassname(ent, "survivor_bot"))
		{
			if (ent.IsValid() && IsPlayerABot(ent) && (team == 0 || NetProps.GetPropInt(ent, "m_iTeamNum") == team))
				t[++i] <- ent;
		}
		return t;
	}

	::Left4Utils.GetAlivePlayersByType <- function (playerType)
	{
		local t = {};
		local ent = null;
		local i = -1;
		while (ent = Entities.FindByClassname(ent, "player"))
		{
			if (ent.IsValid() && NetProps.GetPropInt(ent, "m_zombieClass") == playerType && !ent.IsDead() && !ent.IsDying())
				t[++i] <- ent;
		}
		return t;
	}

	::Left4Utils.GetAllSurvivors <- function (team = TEAM_SURVIVORS)
	{
		local t = {};
		local ent = null;
		local i = -1;
		while (ent = Entities.FindByClassname(ent, "player"))
		{
			if (ent.IsValid() && ent.IsSurvivor() && (team == 0 || NetProps.GetPropInt(ent, "m_iTeamNum") == team))
				t[++i] <- ent;
		}
		ent = null;
		while (ent = Entities.FindByClassname(ent, "survivor_bot"))
		{
			if (ent.IsValid() && ent.IsSurvivor() && (team == 0 || NetProps.GetPropInt(ent, "m_iTeamNum") == team))
				t[++i] <- ent;
		}
		return t;
	}

	::Left4Utils.GetHumanSurvivors <- function (team = TEAM_SURVIVORS)
	{
		local t = {};
		local ent = null;
		local i = -1;
		while (ent = Entities.FindByClassname(ent, "player"))
		{
			if (ent.IsValid() && !IsPlayerABot(ent) && ent.IsSurvivor() && (team == 0 || NetProps.GetPropInt(ent, "m_iTeamNum") == team))
				t[++i] <- ent;
		}
		return t;
	}
	
	::Left4Utils.GetAliveHumanSurvivors <- function (team = TEAM_SURVIVORS)
	{
		local t = {};
		local ent = null;
		local i = -1;
		while (ent = Entities.FindByClassname(ent, "player"))
		{
			if (ent.IsValid() && !IsPlayerABot(ent) && !ent.IsDead() && !ent.IsDying() && ent.IsSurvivor() && (team == 0 || NetProps.GetPropInt(ent, "m_iTeamNum") == team))
				t[++i] <- ent;
		}
		return t;
	}
	
	::Left4Utils.GetAliveSurvivors <- function (team = TEAM_SURVIVORS)
	{
		local t = {};
		local ent = null;
		local i = -1;
		while (ent = Entities.FindByClassname(ent, "player"))
		{
			if (ent.IsValid() && !ent.IsDead() && !ent.IsDying() && ent.IsSurvivor() && (team == 0 || NetProps.GetPropInt(ent, "m_iTeamNum") == team))
				t[++i] <- ent;
		}
		return t;
	}
	
	::Left4Utils.GetIncapacitatedSurvivors <- function (team = TEAM_SURVIVORS)
	{
		local t = {};
		local ent = null;
		local i = -1;
		while (ent = Entities.FindByClassname(ent, "player"))
		{
			if (ent.IsValid() && !ent.IsDead() && !ent.IsDying() && ent.IsIncapacitated() && ent.IsSurvivor() && (team == 0 || NetProps.GetPropInt(ent, "m_iTeamNum") == team))
				t[++i] <- ent;
		}
		return t;
	}
	
	::Left4Utils.GetDeadSurvivors <- function (team = TEAM_SURVIVORS)
	{
		local t = {};
		local ent = null;
		local i = -1;
		while (ent = Entities.FindByClassname(ent, "player"))
		{
			if (ent.IsValid() && (ent.IsDead() || ent.IsDying()) && ent.IsSurvivor() && (team == 0 || NetProps.GetPropInt(ent, "m_iTeamNum") == team))
				t[++i] <- ent;
		}
		ent = null;
		while (ent = Entities.FindByClassname(ent, "survivor_bot"))
		{
			if (ent.IsValid() && (ent.IsDead() || ent.IsDying()) && ent.IsSurvivor() && (team == 0 || NetProps.GetPropInt(ent, "m_iTeamNum") == team))
				t[++i] <- ent;
		}
		return t;
	}
	
	::Left4Utils.GetAliveSurvivorBots <- function (team = TEAM_SURVIVORS)
	{
		local t = {};
		local ent = null;
		local i = -1;
		while (ent = Entities.FindByClassname(ent, "player"))
		{
			if (ent.IsValid() && IsPlayerABot(ent) && !ent.IsDead() && !ent.IsDying() && ent.IsSurvivor() && (team == 0 || NetProps.GetPropInt(ent, "m_iTeamNum") == team))
				t[++i] <- ent;
		}
		return t;
	}
	
	::Left4Utils.GetOtherAliveSurvivors <- function (me, team = TEAM_SURVIVORS)
	{
		local t = {};
		local ent = null;
		local i = -1;
		while (ent = Entities.FindByClassname(ent, "player"))
		{
			if (ent.IsValid() && ent.GetPlayerUserId() != me.GetPlayerUserId() && !ent.IsDead() && !ent.IsDying() && ent.IsSurvivor() && (team == 0 || NetProps.GetPropInt(ent, "m_iTeamNum") == team))
				t[++i] <- ent;
		}
		return t;
	}
	
	::Left4Utils.GetAnyAliveSurvivor <- function (team = TEAM_SURVIVORS)
	{
		local t = GetAliveSurvivors(team);
		if (t.len() == 0)
			return null;
		
		return t[RandomInt(0, t.len() - 1)];
	}
	
	::Left4Utils.GetSpectators <- function ()
	{
		local t = {};
		local ent = null;
		local i = -1;
		while (ent = Entities.FindByClassname(ent, "player"))
		{
			if (ent.IsValid() && NetProps.GetPropInt(ent, "m_iTeamNum") == TEAM_SPECTATORS)
				t[++i] <- ent;
		}
		return t;
	}
	
	::Left4Utils.GetAllInfected <- function ()
	{
		local t = {};
		local ent = null;
		local i = -1;
		while (ent = Entities.FindByClassname(ent, "player"))
		{
			if (ent.IsValid() && NetProps.GetPropInt(ent, "m_iTeamNum") == TEAM_INFECTED)
				t[++i] <- ent;
		}
		while (ent = Entities.FindByClassname(ent, "infected"))
		{
			if (ent.IsValid())
				t[++i] <- ent;
		}
		while (ent = Entities.FindByClassname(ent, "witch"))
		{
			if (ent.IsValid())
				t[++i] <- ent;
		}
		return t;
	}

	::Left4Utils.GetBotInfected <- function ()
	{
		local t = {};
		local ent = null;
		local i = -1;
		while (ent = Entities.FindByClassname(ent, "player"))
		{
			if (ent.IsValid() && IsPlayerABot(ent) && NetProps.GetPropInt(ent, "m_iTeamNum") == TEAM_INFECTED)
				t[++i] <- ent;
		}
		while (ent = Entities.FindByClassname(ent, "infected"))
		{
			if (ent.IsValid())
				t[++i] <- ent;
		}
		while (ent = Entities.FindByClassname(ent, "witch"))
		{
			if (ent.IsValid())
				t[++i] <- ent;
		}
		return t;
	}
	
	::Left4Utils.SurvivorWithHighestFlow <- function (team = TEAM_SURVIVORS)
	{
		local ret = null;
		local flow = -1000000;
		foreach (surv in ::Left4Utils.GetAliveSurvivors(team))
		{
			local dist = g_MapScript.GetCurrentFlowDistanceForPlayer(surv);
			if (dist > flow)
			{
				ret = surv;
				flow = dist;
			}
		}
		return ret;
	}

	::Left4Utils.SurvivorWithLowestFlow <- function (team = TEAM_SURVIVORS)
	{
		local ret = null;
		local flow = 1000000;
		foreach (surv in ::Left4Utils.GetAliveSurvivors(team))
		{
			local dist = g_MapScript.GetCurrentFlowDistanceForPlayer(surv);
			if (dist < flow)
			{
				ret = surv;
				flow = dist;
			}
		}
		return ret;
	}
	
	::Left4Utils.GetNearestAliveSurvivor <- function (ent, team = TEAM_SURVIVORS)
	{
		local ret = null;
		local minDist = 1000000;
		foreach (surv in ::Left4Utils.GetAliveSurvivors(team))
		{
			if (surv == ent)
				continue;

			local dist = (ent.GetOrigin() - surv.GetOrigin()).Length();
			if (dist < minDist)
			{
				ret = surv;
				minDist = dist;
			}
		}
		return ret;
	}
	
	// playerType = -1 = all
	::Left4Utils.GetPlayersAliveByTypeWithin <- function (origin, radius = 1000, playerType = -1)
	{
		local t = {};
		local ent = null;
		local i = -1;
		while (ent = Entities.FindByClassnameWithin(ent, "player", origin, radius))
		{
			if (ent.IsValid() && IsPlayerABot(ent) && !ent.IsDead() && !ent.IsDying() && "GetZombieType" in ent && (playerType < 0 || ent.GetZombieType() == playerType))
				t[++i] <- ent;
		}
		return t;
	}
	
	// playerType = -1 = all
	::Left4Utils.GetNearestPlayerAliveByTypeWithin <- function (ent, radius = 1000, playerType = -1)
	{
		local ret = null;
		local minDist = 1000000;
		foreach (player in ::Left4Utils.GetPlayersAliveByTypeWithin(ent.GetOrigin(), radius, playerType))
		{
			if (player == ent)
				continue;

			local dist = (ent.GetOrigin() - player.GetOrigin()).Length();
			if (dist < minDist)
			{
				ret = player;
				minDist = dist;
			}
		}
		return ret;
	}
	
	::Left4Utils.GetFirstVisibleCommonInfectedWithin <- function (player, radius = 1000)
	{
		local ent = null;
		while (ent = Entities.FindByClassnameWithin(ent, "infected", player.GetOrigin(), radius))
		{
			if (ent.IsValid() && Left4Utils.CanTraceTo(player, ent))
				return ent;
		}
		return null;
	}
	
	::Left4Utils.GetCommonInfectedWithin <- function (player, radius = 1000)
	{
		local t = {};
		local ent = null;
		local i = -1;
		while (ent = Entities.FindByClassnameWithin(ent, "infected", player.GetOrigin(), radius))
		{
			if (ent.IsValid())
				t[++i] <- ent;
		}
		return t;
	}
	
	::Left4Utils.GetSpecialInfectedWithin <- function (player, radius = 1000)
	{
		local t = {};
		local ent = null;
		local i = -1;
		while (ent = Entities.FindByClassnameWithin(ent, "player", player.GetOrigin(), radius))
		{
			if (ent.IsValid() && !ent.IsDead() && !ent.IsDying() && ent.GetZombieType() != Z_SURVIVOR && !ent.IsGhost() && Left4Utils.CanTraceTo(player, ent))
				t[++i] <- ent;
		}
		return t;
	}
	
	::Left4Utils.HasSpecialInfectedWithin <- function (player, radius = 1000)
	{
		local ent = null;
		while (ent = Entities.FindByClassnameWithin(ent, "player", player.GetOrigin(), radius))
		{
			if (ent.IsValid() && !ent.IsDead() && !ent.IsDying() && ent.GetZombieType() != Z_SURVIVOR && !ent.IsGhost() && Left4Utils.CanTraceTo(player, ent))
				return true;
		}
		return false;
	}
	
	::Left4Utils.GetMedkitsWithin <- function (player, radius = 500)
	{
		local t = {};
		local ent = null;
		local i = -1;
		while (ent = Entities.FindInSphere(ent, player.GetOrigin(), radius))
		{
			// Note: we are counting both weapon_first_aid_kit and weapon_first_aid_kit_spawn
			if (ent.IsValid() && ent.GetClassname().find("weapon_first_aid_kit") != null && NetProps.GetPropEntity(ent, "m_hOwner") == null)
				t[++i] <- ent;
		}
		return t;
	}
	
	::Left4Utils.GetSurvivorDeathModelWithin <- function (player, radius = 500)
	{
		local t = {};
		local ent = null;
		local i = -1;
		while (ent = Entities.FindByClassnameWithin(ent, "survivor_death_model", player.GetOrigin(), radius))
		{
			if (ent.IsValid())
				t[++i] <- ent;
		}
		return t;
	}
	
	::Left4Utils.GetCharacterName <- function (survivor)
	{
		local char = NetProps.GetPropInt(survivor, "m_survivorCharacter");

		if (char == 4)
			return "Bill";
		else if (char == 5)
			return "Zoey";
		else if (char == 6)
			return "Francis";
		else if (char == 7)
			return "Louis";

		return g_MapScript.GetCharacterDisplayName(survivor);
	}
	
	::Left4Utils.GetBaseCharacterName <- function (survivor)
	{
		local char = NetProps.GetPropInt(survivor, "m_survivorCharacter");

		if (char == 0)
			return "Nick";
		else if (char == 1)
			return "Rochelle";
		else if (char == 2)
			return "Coach";
		else if (char == 3)
			return "Ellis";

		return Left4Utils.GetCharacterName(survivor);
	}

	::Left4Utils.GetPlayerFromName <- function (name)
	{
		foreach (player in ::Left4Utils.GetAllPlayers())
		{
			local playerName = player.GetPlayerName();
			if ((playerName == name) || (playerName.tolower() == name.tolower()) || (player.IsSurvivor() && Left4Utils.GetCharacterName(player).tolower() == name.tolower()) || (player.IsSurvivor() && Left4Utils.GetBaseCharacterName(player).tolower() == name.tolower()) || (playerName.tolower().find(name.tolower()) != null))
				return player;
		}
		return null;
	}
	
	::Left4Utils.GetDeadSurvivorByChar <- function (char)
	{
		foreach (dead in Left4Utils.GetDeadSurvivors())
		{
			if (NetProps.GetPropInt(dead, "m_survivorCharacter") == char)
				return dead;
		}
		return null;
	}
	
	::Left4Utils.GetSurvivorDeathModelByChar <- function (char)
	{
		local ent = null;
		while (ent = Entities.FindByClassname(ent, "survivor_death_model"))
		{
			if (ent.IsValid() && NetProps.GetPropInt(ent, "m_nCharacterType") == char)
				return ent;
		}
		return null;
	}
	
	::Left4Utils.GetSurvivorByDeathModel <- function (death_model)
	{
		if (!death_model || !death_model.IsValid())
			return null;
		
		return Left4Utils.GetDeadSurvivorByChar(NetProps.GetPropInt(death_model, "m_nCharacterType"));
	}
	
	::Left4Utils.HasMedkit <- function (survivor)
	{
		local item = Left4Utils.GetInventoryItemInSlot(survivor, INV_SLOT_MEDKIT);
		if (item && item.GetClassname() == "weapon_first_aid_kit")
			return true;
		
		return false;
	}
	
	::Left4Utils.HasDefib <- function (survivor)
	{
		local item = Left4Utils.GetInventoryItemInSlot(survivor, INV_SLOT_MEDKIT);
		if (item && item.GetClassname() == "weapon_defibrillator")
			return true;
		
		return false;
	}
	
	::Left4Utils.HasLaserSight <- function (survivor)
	{
		local item = Left4Utils.GetInventoryItemInSlot(survivor, INV_SLOT_PRIMARY);
		if (item && (NetProps.GetPropInt(item, "m_upgradeBitVec") & 4) > 0)
			return true;
		
		return false;
	}
	
	::Left4Utils.GetInventoryItem <- function (survivor, className)
	{
		local inv = {};
		GetInvTable(survivor, inv);
		foreach(slot, item in inv)
		{
			if (item.GetClassname() == className)
				return item;
		}
		return null;
	}
	
	::Left4Utils.HasItem <- function (survivor, className)
	{
		return (Left4Utils.GetInventoryItem(survivor, className) != null);
	}

	::Left4Utils.FindSlotForItemClass <- function (player, itemClass)
	{
		local inv = {};
		GetInvTable(player, inv);
		
		for (local i = 0; i < 5; i++)
		{
			local slot = "slot" + i;
			if ((slot in inv) && inv[slot] && inv[slot].GetClassname() == itemClass)
				return slot;
		}
		
		return null;
	}
	
	::Left4Utils.BotCmdAttack <- function (bot, target)
	{
		return CommandABot( { cmd = BOT_CMD_ATTACK, target = target, bot = bot } );
	}
	
	::Left4Utils.BotCmdMove <- function (bot, location)
	{
		return CommandABot( { cmd = BOT_CMD_MOVE, pos = location, bot = bot } );
	}
	
	::Left4Utils.BotCmdRetreat <- function (bot, from)
	{
		return CommandABot( { cmd = BOT_CMD_RETREAT, target = from, bot = bot } );
	}
	
	::Left4Utils.BotCmdReset <- function (bot)
	{
		return CommandABot( { cmd = BOT_CMD_RESET, bot = bot } );
	}
	
	::Left4Utils.GetInventoryItemInSlot <- function (player, slot)
	{
		local inv = {};
		GetInvTable(player, inv);
		if (!(slot in inv))
			return null;
		
		return inv[slot];
	}
	
	::Left4Utils.RemoveInventoryItemInSlot <- function (player, slot)
	{
		local inv = {};
		GetInvTable(player, inv);
		if (slot in inv)
		{
			// Without the DropItem, the vanilla AI will bug out and will still think that the item is in the inventory (or something like that)
			// This bug can be seen by removing the medkit from the bots (Kill without DropItem), give them a defib and hurt them enough to make them heal. They will try to heal with the defib and get stuck
			player.DropItem(inv[slot].GetClassname());
			inv[slot].Kill();
		}
	}
	
	::Left4Utils.RemoveInventoryItem <- function (player, itemclass)
	{
		local inv = {};
		GetInvTable(player, inv);
		foreach(slot, item in inv)
		{
			if (item.GetClassname() == itemclass)
			{
				// Without the DropItem, the vanilla AI will bug out and will still think that the item is in the inventory (or something like that)
				// This bug can be seen by removing the medkit from the bots (Kill without DropItem), give them a defib and hurt them enough to make them heal. They will try to heal with the defib and get stuck
				player.DropItem(itemclass);
				item.Kill();
			}
		}
	}
	
	::Left4Utils.GetMaxAmmo <- function (ammoType)
	{
		switch (ammoType)
		{
			case 1: // weapon_pistol
			case 2: // weapon_pistol_magnum
				return Convars.GetStr("ammo_pistol_max").tointeger();
			case 3: // weapon_rifle_ak47, weapon_rifle, weapon_rifle_desert, weapon_rifle_sg552
				return Convars.GetStr("ammo_assaultrifle_max").tointeger();
			case 4: // ???
				return Convars.GetStr("ammo_minigun_max").tointeger();
			case 5: // weapon_smg_silenced, weapon_smg, weapon_smg_mp5
				return Convars.GetStr("ammo_smg_max").tointeger();
			case 6: // weapon_rifle_m60
				return Convars.GetStr("ammo_m60_max").tointeger();
			case 7: // weapon_pumpshotgun, weapon_shotgun_chrome
				return Convars.GetStr("ammo_shotgun_max").tointeger();
			case 8: // weapon_shotgun_spas, weapon_autoshotgun
				return Convars.GetStr("ammo_autoshotgun_max").tointeger();
			case 9: // weapon_hunting_rifle
				return Convars.GetStr("ammo_huntingrifle_max").tointeger();
			case 10: // weapon_sniper_military, weapon_sniper_awp, weapon_sniper_scout
				return Convars.GetStr("ammo_sniperrifle_max").tointeger();
			case 11: // ???
				return Convars.GetStr("ammo_ammo_pack_max").tointeger();
			case 12: // weapon_pipe_bomb
				return Convars.GetStr("ammo_pipebomb_max").tointeger();
			case 13: // weapon_molotov
				return Convars.GetStr("ammo_molotov_max").tointeger();
			case 14: // weapon_vomitjar
				return Convars.GetStr("ammo_vomitjar_max").tointeger();
			case 15: // weapon_pain_pills
				return Convars.GetStr("ammo_painpills_max").tointeger();
			case 16: // weapon_first_aid_kit, weapon_defibrillator, weapon_upgradepack_incendiary, weapon_upgradepack_explosive
				return Convars.GetStr("ammo_firstaid_max").tointeger();
			case 17: // weapon_grenade_launcher
				return Convars.GetStr("ammo_grenadelauncher_max").tointeger();
			case 18: // weapon_adrenaline
				return Convars.GetStr("ammo_adrenaline_max").tointeger();
			case 19: // weapon_chainsaw
				return Convars.GetStr("ammo_chainsaw_max").tointeger();
			case 20: // weapon_fireworkcrate, weapon_oxygentank, weapon_propanetank, weapon_gascan
				return 0; // TODO?
		}
		
		return 0;
	}

	::Left4Utils.GetPrimaryAmmoPercent <- function (survivor)
	{
		if (!survivor || !survivor.IsValid())
			return 0.0;
		
		local w = Left4Utils.GetInventoryItemInSlot(survivor, INV_SLOT_PRIMARY);
		if (!w || !w.IsValid())
			return 0.0;
		
		local ammoType = NetProps.GetPropInt(w, "m_iPrimaryAmmoType");
		local max = Left4Utils.GetMaxAmmo(ammoType) + w.GetMaxClip1();
		local ammo = NetProps.GetPropIntArray(survivor, "m_iAmmo", ammoType) + w.Clip1();
		return ((100.0 / max) * ammo);
	}

	::Left4Utils.DamageContains <- function (damageType, containsType)
	{
		return (damageType & containsType) != 0;
	}
	
	::Left4Utils.GetHorizontalVelocity <- function (player)
	{
		local vel = player.GetVelocity();
		return (abs(vel.x) + abs(vel.y)); // x,y = horizontal coords - z = vertical
	}
	
	::Left4Utils.FindGroundFrom <- function (pos, maxHeight = FINDGROUND_MAXHEIGHT, minFraction = FINDGROUND_MINFRACTION)
	{
		local start = pos;
		local end = start - Vector(0, 0, maxHeight);
		
		local traceTable = { start = start, end = end, mask = TRACE_MASK_SOLID };
		TraceLine(traceTable);
		
		local valid = false;
		if (traceTable.hit && traceTable.fraction >= minFraction)
			valid = true;
		
		return { pos = traceTable.pos, valid = valid };
	}
	
	::Left4Utils.FindGround <- function (origin, angles, degrees, debugShow = false, debugShowTime = 10)
	{
		local yaw = angles.Yaw() + degrees;
		if (yaw > 360)
			yaw -= 360;
		
		local forward = QAngle(angles.Pitch(), yaw, 0).Forward();
		
		local _pos = origin + (forward * 35);
		local _p1 = origin + (forward * 10);
		local _p2 = origin + (forward * 55);
		
		local traceTable = { start = _p1, end = _p2, mask = TRACE_MASK_DEFAULT };
		TraceLine(traceTable);
		if (traceTable.hit)
			return null;
	
		local pos = Left4Utils.FindGroundFrom(_pos, FINDGROUND_MAXHEIGHT, FINDGROUND_MINFRACTION);
		local p1 = Left4Utils.FindGroundFrom(_p1, FINDGROUND_MAXHEIGHT, FINDGROUND_MINFRACTION);
		local p2 = Left4Utils.FindGroundFrom(_p2, FINDGROUND_MAXHEIGHT, FINDGROUND_MINFRACTION);
		
		local color = Vector(255, 255, 0);
		if (pos.valid && p1.valid && p2.valid)
			color = Vector(0, 255, 0);
			
		if (debugShow)
		{
			if (pos.valid)
				DebugDrawLine_vCol(_pos, pos.pos, color, true, debugShowTime);
			else
				DebugDrawLine_vCol(_pos, pos.pos, Vector(255, 0, 0), true, debugShowTime);
				
			if (p1.valid)
				DebugDrawLine_vCol(_p1, p1.pos, color, true, debugShowTime);
			else
				DebugDrawLine_vCol(_p1, p1.pos, Vector(255, 0, 0), true, debugShowTime);
				
			if (p2.valid)
				DebugDrawLine_vCol(_p2, p2.pos, color, true, debugShowTime);
			else
				DebugDrawLine_vCol(_p2, p2.pos, Vector(255, 0, 0), true, debugShowTime);
			
			DebugDrawLine_vCol(origin, _p2, color, true, debugShowTime);
		}
		
		if (pos.valid && p1.valid && p2.valid)
			return pos.pos;
		
		return null;
	}
	
	::Left4Utils.AltitudeDiff <- function (source, dest)
	{
		return abs(source.GetOrigin().z - dest.GetOrigin().z);
	}
	
	// Returns true if the 'source' player can trace to the 'dest' entity with the given trace 'mask' and whithin 'maxDist', false otherwise
	// Alternatively can also return true if the trace hits an entity of class 'altClass' (if non null)
	::Left4Utils.CanTraceTo <- function (source, dest, mask = TRACE_MASK_DEFAULT, maxDist = 0, altClass = null)
	{
		/*
		// Note: Doing "end = dest.GetOrigin()" doesn't work when the object is lying on it's side with a certain angle because the trace ends right next to the object itself so i add a little offset towards the object's Up.
		//       Apparently the bot's internal AI is also affected by this bug, it often happens with medkits and pills the bot refuses to pick up.
		
		local traceTable = { start = source.EyePosition(), end = dest.GetOrigin() + (dest.GetAngles().Up() * 2), ignore = source, mask = mask };
		*/
		
		// 15 jun 2021 update added the GetCenter() function to CBaseEntity which should solve the issue described above
		
		local start = source.EyePosition();
		local end = dest.GetCenter();
		local traceTable = { start = start, end = end + (end - start), ignore = source, mask = mask }; // end = end + (end - start) <- If i stop to the item's center, depending on the item's model, it is possible that the trace doesn't reach it
		
		TraceLine(traceTable);
		
		if (!traceTable.hit || !traceTable.enthit || (traceTable.enthit != dest && (!altClass || traceTable.enthit.GetClassname() != altClass)))
			return false;
		
		if (maxDist && (traceTable.pos - start).Length() > maxDist)
			return false;
		
		return true;
	}
	
	::Left4Utils.CanTraceToEntPos <- function (source, dest, pos, mask = TRACE_MASK_DEFAULT, maxDist = 0)
	{
		local start = source.EyePosition();
		local end = pos;
		local traceTable = { start = start, end = end + (end - start), ignore = source, mask = mask };
		
		TraceLine(traceTable);
		
		if (!traceTable.hit || traceTable.enthit != dest)
			return false;
		
		if (maxDist && (traceTable.pos - start).Length() > maxDist)
			return false;
		
		return true;
	}
	
	::Left4Utils.CanTraceToPos <- function (source, pos, mask = TRACE_MASK_DEFAULT)
	{
		local traceTable = { start = source.EyePosition(), end = pos, ignore = source, mask = mask };
		TraceLine(traceTable);
		
		if (traceTable.hit || traceTable.fraction < 0.9)
			return false;
		
		return true;
	}
	
	// Returns: null = no looking position, (Vector) = looking position
	::Left4Utils.GetLookingPosition <- function (player, mask = TRACE_MASK_DEFAULT)
	{
		local start = player.EyePosition();
		local end = start + player.EyeAngles().Forward().Scale(999999);
		
		local m_trace = { start = start, end = end, ignore = player, mask = mask };
		TraceLine(m_trace);
		
		if (!m_trace.hit || m_trace.enthit == player)
			return null;

		return m_trace.pos;
	}
	
	// Returns: null = no looking target, (Entity) = target entity, (Vector) = target position if no entity was looked at
	::Left4Utils.GetLookingTarget <- function (player, mask = TRACE_MASK_DEFAULT)
	{
		local start = player.EyePosition();
		local end = start + player.EyeAngles().Forward().Scale(999999);
		
		local m_trace = { start = start, end = end, ignore = player, mask = mask };
		TraceLine(m_trace);
		
		if (!m_trace.hit || m_trace.enthit == player)
			return null;

		if (!m_trace.enthit.IsValid() || m_trace.enthit.GetClassname() == "worldspawn")
			return m_trace.pos;
		
		return m_trace.enthit;
	}
	
	// Returns: null = no looking target, { pos (Vector) = hit position, ent (Entity) = hit entity }
	::Left4Utils.GetLookingTargetEx <- function (player, mask = TRACE_MASK_DEFAULT)
	{
		local ret = { pos = null, ent = null };
		
		local start = player.EyePosition();
		local end = start + player.EyeAngles().Forward().Scale(999999);
		
		local m_trace = { start = start, end = end, ignore = player, mask = mask };
		TraceLine(m_trace);
		
		if (!m_trace.hit || m_trace.enthit == player)
			return null;

		ret["pos"] <- m_trace.pos;
		if (m_trace.enthit.IsValid() && m_trace.enthit.GetClassname() != "worldspawn")
			ret["ent"] <- m_trace.enthit;
		
		return ret;
	}
	
	::Left4Utils.VectorAngles <- function (forwardVector)
	{
		local pitch = 0;
		local yaw = 0;
		
		if (forwardVector.y == 0 && forwardVector.x == 0)
		{
			if (forwardVector.z > 0)
				pitch = 270;
			else
				pitch = 90;
		}
		else
		{
			yaw = (atan2(forwardVector.y, forwardVector.x) * 180 / 3.14159265359);
			if (yaw < 0)
				yaw += 360;

			local tmp = sqrt((forwardVector.x * forwardVector.x) + (forwardVector.y * forwardVector.y));
			pitch = atan2(-forwardVector.z, tmp) * 180 / 3.14159265359;
			if (pitch < 0)
				pitch += 360;
		}
		
		return QAngle(pitch, yaw, 0);
	}

	::Left4Utils.GetDiffAngle <- function (angle1, angle2)
	{
		local phi = abs(angle1 - angle2) % 360;
		local d = phi > 180 ? 360 - phi : phi;
		local s = ((angle1 - angle2) >= 0 && (angle1 - angle2) <= 180) || ((angle1 - angle2) <= -180 && (angle1 - angle2) >= -360) ? 1.0 : -1.0;
		
		return (d * s);
	}

	// target can be either a vector or an entity
	// deltaPitch: >0 = down - <0 = up
	// deltaYaw: >0 = ? - <0 = ?
	::Left4Utils.BotLookAt <- function (bot, target = null, deltaPitch = 0, deltaYaw = 0)
	{
		local angles = bot.EyeAngles();
		local position = null;
		if (target != null)
		{
			if ((typeof target) == "instance" && target.IsValid())
				position = target.GetOrigin();
			else if ((typeof target) == "Vector")
				position = target;
		}
		
		if (position != null)
		{
			local v = position - bot.EyePosition();
			v.Norm();
			angles = Left4Utils.VectorAngles(v);
		}
		
		if (deltaPitch != 0 || deltaYaw != 0)
			angles = RotateOrientation(angles, QAngle(deltaPitch, deltaYaw, 0));
		
		bot.SnapEyeAngles(angles);
	}
	
	::Left4Utils.BotGetFarthestPathablePos <- function (bot, radius)
	{
		local ret = null;
		local maxDist = 0;
		for (local i = 0; i < 6; i++)
		{
			local p = bot.TryGetPathableLocationWithin(radius);
			local dist = (p - bot.GetOrigin()).Length();
			if (dist > maxDist && Left4Utils.CanTraceToPos(bot, p))
			{
				ret = p;
				maxDist = dist;
			}
		}
		return ret;
	}
	
	::Left4Utils.GetActorFromSurvivor <- function (survivor)
	{
		if (!survivor || !survivor.IsValid() || !("GetPlayerUserId" in survivor))
			return "Unknown";
		
		foreach (name, handle in rr_GetResponseTargets())
		{
			if (handle && handle.IsValid() && ("GetPlayerUserId" in handle) && handle.GetPlayerUserId() == survivor.GetPlayerUserId())
				return name;
		}
		return "Unknown";
	}
	
	::Left4Utils.GetSurvivorFromActor <- function (actor)
	{
		if (actor == "None")
			return null;
		
		foreach (name, handle in rr_GetResponseTargets())
		{
			if (actor == name)
				return handle;
		}
		
		return null;
	}

	::Left4Utils.IsFinale <- function ()
	{
		local tpm = Entities.FindByClassname(null, "terror_player_manager");
		if (!tpm)
			return false;
		
		return (NetProps.GetPropInt(tpm, "m_isFinale") != 0);
	}

	::Left4Utils.RestartChapter <- function ()
	{
		local info_director = Entities.FindByClassname(null, "info_director");
		if (!info_director)
			return false;
		
		DirectorScript.GetDirectorOptions().A_CustomFinale_StageCount <- 1;
		DirectorScript.GetDirectorOptions().A_CustomFinale1 <- 8;
		DirectorScript.GetDirectorOptions().A_CustomFinaleValue1 <- 0;
		
		DoEntFire("!self", "ScriptedPanicEvent", "", 0, null, info_director);
	}

	::Left4Utils.StartFinale <- function ()
	{
		local tf = Entities.FindByClassname(null, "trigger_finale");
		if (!tf)
			return;
		
		DoEntFire("!self", "ForceFinaleStart", "", 0, null, tf);
	}

	::Left4Utils.StartRescue <- function ()
	{
		local tf = Entities.FindByClassname(null, "trigger_finale");
		if (!tf)
			return;
		
		DoEntFire("!self", "FinaleEscapeStarted", "", 0, null, tf);
		EntFire("relay_car_ready", "Trigger");
		NavMesh.UnblockRescueVehicleNav();
	}

	::Left4Utils.EndCampaign <- function ()
	{
		local trigger_finale = g_ModeScript.CreateSingleSimpleEntityFromTable({ classname = "trigger_finale", origin = Vector(0, 0, 0), angles = QAngle(0, 0, 0), disableshadows = "1", model = "models/props/terror/hamradio.mdl", skin = "0", VersusTravelCompletion = "0.2" });
		local env_fade = g_ModeScript.CreateSingleSimpleEntityFromTable({ classname = "env_fade", origin = Vector(0, 0, 0), angles = QAngle(0, 0, 0), duration = "0", holdtime = "0", renderamt = "255", rendercolor = "0 0 0", spawnflags = "8" });
		local outtro_stats = g_ModeScript.CreateSingleSimpleEntityFromTable({ classname = "env_outtro_stats", origin = Vector(0, 0, 0), angles = QAngle(0, 0, 0) });
		
		Left4Utils.GenerateGameEvent("gameinstructor_nodraw");
		
		Left4Utils.StopDirector();
		
		foreach(infected in ::Left4Utils.GetBotInfected())
			DoEntFire("!self", "Kill", "", 0, null, infected);
			
		DoEntFire("!self", "Alpha", "255", 0, null, env_fade);
		DoEntFire("!self", "Fade", "", 0, null, env_fade);
		
		DoEntFire("!self", "FinaleEscapeFinished", "", 0, null, trigger_finale);
		DoEntFire("!self", "FinaleEscapeForceSurvivorPositions", "", 0, null, trigger_finale);
		
		DoEntFire("!self", "RollStatsCrawl", "", 0.1, null, outtro_stats);
	}

	::Left4Utils.GenerateGameEvent <- function (eventName)
	{
		local igep = g_ModeScript.CreateSingleSimpleEntityFromTable({ classname = "info_game_event_proxy", origin = Vector(0, 0, 0), angles = QAngle(0, 0, 0), event_name = eventName, range = "0", spawnflags = "0", targetname = "L4UEvent_" + UniqueString() });
		if (!igep)
			return;
		
		DoEntFire("!self", "GenerateGameEvent", "", 0, null, igep);
		DoEntFire("!self", "Kill", "", 0.1, null, igep);
	}
	
	::Left4Utils.EscapeString <- function (str)
	{
		return Left4Utils.StringReplace(Left4Utils.StringReplace(str, @"\\", "\\\\"), "\"", "\\\"");
	}
	
	::Left4Utils.PrintTable <- function (table, indent = 0, isArray = false)
	{
		local function GetIndentString(indentNum)
		{
			local ret = "";
			for (local i = 0; i < indentNum; i++)
				ret += "\t";
			return ret;
		}
		
		if (isArray)
			print(GetIndentString(indent) + "[\n");
		else
			print(GetIndentString(indent) + "{\n");
		
		foreach (k, v in table)
		{
			if (typeof v == "table")
				print(GetIndentString(indent + 1) + k + " = \n" + Left4Utils.PrintTable(v, indent + 1, false));
			else if (typeof v == "array")
				print(GetIndentString(indent + 1) + k + " = \n" + Left4Utils.PrintTable(v, indent + 1, true));
			else
				print(GetIndentString(indent + 1) + k + " = " + v + "\n");
		}
		
		if (isArray)
			print(GetIndentString(indent) + "]\n");
		else
			print(GetIndentString(indent) + "}\n");
	}

	::Left4Utils.LoadTable <- function (fileName)
	{
		local contents = FileToString(fileName);
		if (!contents)
			return null;
		
		return Left4Utils.DeserializeTable(contents);
	}
	
	::Left4Utils.SaveTable <- function (tbl, fileName)
	{
		local contents = Left4Utils.SerializeTable(tbl);
		if (!contents)
			return false;
		
		return StringToFile(fileName, contents);
	}

	::Left4Utils.SerializeArray <- function (arr)
	{
		local ret = "[ ";
		foreach (item in arr)
		{
			local valType = typeof item;
			if (valType == "instance" || valType == "class" || valType == "function")
				continue;
			
			if (valType == "table")
				ret += Left4Utils.SerializeTable(item);
			else if (valType == "array")
				ret += Left4Utils.SerializeArray(item);
			else if (valType == "string")
				ret += "\"" + Left4Utils.EscapeString(item) + "\"";
			else
				ret += item;
			
			ret += ", ";
		}
		ret += " ]";
		
		return ret;
	}

	::Left4Utils.SerializeTable <- function (tbl)
	{
		local ret = "{ ";
		foreach (key, val in tbl)
		{
			local valType = typeof val;
			if (valType == "instance" || valType == "class" || valType == "function")
				continue;
			
			ret += key + " = ";
			if (valType == "table")
				ret += Left4Utils.SerializeTable(val);
			else if (valType == "array")
				ret += Left4Utils.SerializeArray(val);
			else if (valType == "string")
				ret += "\"" + Left4Utils.EscapeString(val) + "\"";
			else
				ret += val;
			
			ret += ", ";
		}
		ret += " }";
		
		return ret;
	}

	::Left4Utils.DeserializeTable <- function (str)
	{
		return compilestring( "return " + str )();
	}

	::Left4Utils.IsPlayerHeld <- function (player)
	{
		//return (NetProps.GetPropEntity(player, "m_pounceAttacker") != null || NetProps.GetPropEntity(player, "m_jockeyAttacker") != null || NetProps.GetPropEntity(player, "m_tongueOwner") != null || NetProps.GetPropEntity(player, "m_pummelAttacker") != null || NetProps.GetPropEntity(player, "m_carryAttacker") != null);
		return (NetProps.GetPropInt(player, "m_pounceAttacker") > 0 || NetProps.GetPropInt(player, "m_jockeyAttacker") > 0 || NetProps.GetPropInt(player, "m_tongueOwner") > 0 || NetProps.GetPropInt(player, "m_pummelAttacker") > 0 || NetProps.GetPropInt(player, "m_carryAttacker") > 0);
	}

	::Left4Utils.GetCurrentAttacker <- function (player)
	{
		local ent = NetProps.GetPropEntity(player, "m_pounceAttacker");
		if (ent)
			return ent;
		
		ent = NetProps.GetPropEntity(player, "m_jockeyAttacker");
		if (ent)
			return ent;
		
		ent = NetProps.GetPropEntity(player, "m_tongueOwner");
		if (ent)
			return ent;
		
		ent = NetProps.GetPropEntity(player, "m_pummelAttacker");
		if (ent)
			return ent;
		
		ent = NetProps.GetPropEntity(player, "m_carryAttacker");
		if (ent)
			return ent;
	}

	::Left4Utils.SpawnWeapon <- function (weapon, pos = Vector(0, 0, 0), ang = QAngle(0, 0, 90), count = 1, ammo = 999, spawnflags = 0, keyvalues = {})
	{
		if (weapon.find("weapon_") == null)
			weapon = "weapon_" + weapon;
		
		local tbl = { classname = weapon, origin = pos, angles = ang, ammo = ammo, count = count, spawnflags = spawnflags };
		foreach (k, v in keyvalues)
			tbl[k] <- v;
		
		return g_ModeScript.CreateSingleSimpleEntityFromTable(tbl);
	}

	::Left4Utils.SpawnAmmo <- function (mdl = "models/props/terror/ammo_stack.mdl", pos = Vector(0, 0, 0), ang = QAngle(0, 0, 0), keyvalues = {})
	{
		Left4Utils.PrecacheModel(mdl);
		
		local tbl = { classname = "weapon_ammo_spawn", origin = pos, angles = ang, model = mdl, count = 5, solid = 6, spawnflags = 2 };
		foreach (k, v in keyvalues)
			tbl[k] <- v;

		return g_ModeScript.CreateSingleSimpleEntityFromTable(tbl);
	}

	::Left4Utils.SpawnFuelBarrel <- function (pos, ang = QAngle(0, 0, 0), keyvalues = {})
	{
		Left4Utils.PrecacheModel("models/props_industrial/barrel_fuel.mdl");
		
		local tbl = { classname = "prop_fuel_barrel", origin = pos, angles = ang, model = "models/props_industrial/barrel_fuel.mdl", BasePiece = "models/props_industrial/barrel_fuel_partb.mdl", DetonateParticles = "weapon_pipebomb", DetonateSound = "BaseGrenade.Explode", fademindist = "-1", fadescale = "1", FlyingParticles = "barrel_fly", FlyingPiece01 = "models/props_industrial/barrel_fuel_parta.mdl" };
		foreach (k, v in keyvalues)
			tbl[k] <- v;
		
		return g_ModeScript.CreateSingleSimpleEntityFromTable(tbl);
	}

	::Left4Utils.SpawnMinigun <- function (pos, ang = QAngle(0, 0, 0), keyvalues = {})
	{
		Left4Utils.PrecacheModel("models/w_models/weapons/50cal.mdl");
		
		local tbl = { classname = "prop_minigun", origin = pos, angles = ang, model = "models/w_models/weapons/50cal.mdl", body = "0", fademindist = "-1", fadescale = "1", MaxAnimTime = "10", MaxPitch = "50", MaxYaw = "65", MinAnimTime = "5", MinPitch = "-25", spawnflags = "0", StartDisabled = "false" };
		foreach (k, v in keyvalues)
			tbl[k] <- v;
		
		return g_ModeScript.CreateSingleSimpleEntityFromTable(tbl);
	}

	::Left4Utils.SpawnL4D1Minigun <- function (pos, ang = QAngle(0, 0, 0), keyvalues = {})
	{
		Left4Utils.PrecacheModel("models/w_models/weapons/w_minigun.mdl");
		
		local tbl = { classname = "prop_minigun_l4d1", origin = pos, angles = ang, model = "models/w_models/weapons/w_minigun.mdl", body = "0", fademindist = "-1", fadescale = "1", MaxAnimTime = "10", MaxPitch = "50", MaxYaw = "65", MinAnimTime = "5", MinPitch = "-25", spawnflags = "0", StartDisabled = "false" };
		foreach (k, v in keyvalues)
			tbl[k] <- v;
		
		return g_ModeScript.CreateSingleSimpleEntityFromTable(tbl);
	}

	::Left4Utils.SpawnInfected <- function (infectedType, pos = null, ang = QAngle(0, 0, 0), offerTank = false, victim = null)
	{
		if ((typeof infectedType) == "integer" )
		{
			if (!pos && infectedType == Z_MOB)
				pos = Vector(0, 0, 0);
			
			return ZSpawn({ type = infectedType, pos = pos, ang = ang });
		}
		else
		{
			local ent = g_ModeScript.CreateSingleSimpleEntityFromTable({ classname = "info_zombie_spawn", origin = pos, angles = ang, population = infectedType, offer_tank = offerTank.tointeger() });
			DoEntFire("!self", "SpawnZombie", "", 0, null, ent);
			if (victim)
				DoEntFire("!self", "StartleZombie", "", 0.1, victim, ent);
			
			DoEntFire("!self", "Kill", "", 0.2, null, ent);
		}
	}

	::Left4Utils.SpawnLeaker <- function (pos = null, ang = QAngle(0, 0, 0))
	{
		local function RestoreLeakerChance(oldChance)
		{
			Convars.SetValue("boomer_leaker_chance", oldChance);
		}
		
		local old_boomer_leaker_chance = Convars.GetFloat("boomer_leaker_chance");
		Convars.SetValue("boomer_leaker_chance", 100);
		
		Left4Timers.AddTimer(null, 0.3, @(params) RestoreLeakerChance(params.chance), { chance = old_boomer_leaker_chance }, false);
		
		return Left4Utils.SpawnInfected(Z_BOOMER, pos, ang);
	}

	::Left4Utils.SpawnL4D1Survivor <- function (char, pos = Vector(0, 0, 0), ang = QAngle(0, 0, 0), l4d1behavior = false)
	{
		local function RestoreL4D1Behavior(oldBehavior)
		{
			Convars.SetValue("sb_l4d1_survivor_behavior", oldBehavior);
		}
		
		local function FakeZoeyResponses(args)
		{
			local zoey = Left4Utils.GetPlayerFromName("Zoey");
			if (!zoey)
				zoey = Left4Utils.GetPlayerFromName("Survivor");
			
			if (zoey)
				DoEntFire("!self", "AddContext", "who:TeenGirl:0", 0, null, zoey);
		}
		
		if (char == 4)
			Left4Utils.PrecacheModel("models/survivors/survivor_namvet.mdl");
		else if (char == 5)
			Left4Utils.PrecacheModel("models/survivors/survivor_teenangst.mdl");
		else if (char == 6)
			Left4Utils.PrecacheModel("models/survivors/survivor_biker.mdl");
		else if (char == 7)
			Left4Utils.PrecacheModel("models/survivors/survivor_manager.mdl");
		
		local old_sb_l4d1_survivor_behavior = Convars.GetFloat("sb_l4d1_survivor_behavior").tointeger();
		if (l4d1behavior)
			Convars.SetValue("sb_l4d1_survivor_behavior", 1);
		else
			Convars.SetValue("sb_l4d1_survivor_behavior", 0);
			
		Left4Timers.AddTimer(null, 0.3, @(params) RestoreL4D1Behavior(params.behavior), { behavior = old_sb_l4d1_survivor_behavior }, false);
		
		local spawner = g_ModeScript.CreateSingleSimpleEntityFromTable({ classname = "info_l4d1_survivor_spawn", origin = pos, angles = ang, character = char });
		if (!spawner)
			return false;
		
		DoEntFire("!self", "SpawnSurvivor", "", 0, null, spawner);
		DoEntFire("!self", "Kill", "", 0.1, null, spawner);
		
		if (char == 5)
			Left4Timers.AddTimer(null, 0.1, FakeZoeyResponses, { }, false);
		
		return true;
	}

	::Left4Utils.SpeakScene <- function (player, scene, actor = null)
	{
		if (!player || !player.IsValid())
			return false;
		
		local Actor = actor;
		if (!Actor)
			Actor = Left4Utils.GetActorFromSurvivor(player);

		if (!Actor)
			return false;

		local Scene = scene;
		if (!Scene)
			return false;
		
		if (Scene.find("scenes") == null)
			Scene = "scenes/" + Actor + "/" + Scene;
		
		if (Scene.find(".vcd") == null)
			Scene += ".vcd";
		
		//Scene = Scene.tolower();
		
		local criterion = [::g_rr.Criterion("Concept", "L4UScene", "L4UScene"), ::g_rr.Criterion("Coughing", 0, 0), ::g_rr.Criterion("Who", Actor, Actor)];
		local responses = [ ::g_rr.ResponseSingle(3, Scene, null, null, { scenename = Scene }) ];
		local group_params = ::g_rr.RGroupParams({ permitrepeats = true, sequential = false, norepeat = false, matchonce = false });

		local r = ::g_rr.RRule("L4UScene", criterion, responses, group_params);
		r.responses[0].rule = r;

		//Decider().AddRule(r);

		if (!rr_AddDecisionRule(r))
			return false;

		QueueSpeak(player, "L4UScene", 0.0, "");
		
		return true;
	}

	::Left4Utils.FreezePlayer <- function (player)
	{
		if (player && player.IsValid())
			NetProps.SetPropInt(player, "m_fFlags", NetProps.GetPropInt(player, "m_fFlags") | (1 << 5)); // set FL_FROZEN
	}

	::Left4Utils.UnfreezePlayer <- function (player)
	{
		if (player && player.IsValid())
			NetProps.SetPropInt(player, "m_fFlags", NetProps.GetPropInt(player, "m_fFlags") & ~(1 << 5)); // unset FL_FROZEN
	}

	::Left4Utils.PlayerForceButton <- function (player, button)
	{
		NetProps.SetPropInt(player, "m_afButtonForced", NetProps.GetPropInt(player, "m_afButtonForced") | button);
	}
	
	::Left4Utils.PlayerUnForceButton <- function (player, button)
	{
		NetProps.SetPropInt(player, "m_afButtonForced", NetProps.GetPropInt(player, "m_afButtonForced") & (~button));
	}
	
	::Left4Utils.IsButtonForced <- function (player, button)
	{
		return (NetProps.GetPropInt(player, "m_afButtonForced") & button) != 0;
	}
	
	::Left4Utils.PlayerDisableButton <- function (player, button)
	{
		NetProps.SetPropInt(player, "m_afButtonDisabled", NetProps.GetPropInt(player, "m_afButtonDisabled") | button);
	}
	
	::Left4Utils.PlayerEnableButton <- function (player, button)
	{
		NetProps.SetPropInt(player, "m_afButtonDisabled", NetProps.GetPropInt(player, "m_afButtonDisabled") & (~button));
	}

	::Left4Utils.IsButtonDisabled <- function (player, button)
	{
		return (NetProps.GetPropInt(player, "m_afButtonDisabled") & button) != 0;
	}

	// Force the given player to hold down the given button for holdTime seconds
	// destination can be either an entity or a vector and it's where the player will look at while pressing the button, with a pitch/yaw delta given by deltaPitch and deltaYaw
	// lockLook = true means that the player will be frozen for a duration of holdTime+unlockLookDelay seconds to make sure it will keep the given lookat direction for the entire button press duration
	::Left4Utils.PlayerPressButton <- function (player, button, holdTime = 0.05, destination = null, deltaPitch = 0, deltaYaw = 0, lockLook = false, unlockLookDelay = 0)
	{
		if (!player || !player.IsValid())
			return;
		
		if (lockLook)
		{
			NetProps.SetPropInt(player, "m_fFlags", NetProps.GetPropInt(player, "m_fFlags") | (1 << 5)); // set FL_FROZEN
			Left4Timers.AddTimer(null, holdTime + unlockLookDelay, @(params) Left4Utils.UnfreezePlayer(params.player), { player = player });
		}
		
		if (destination != null || deltaPitch != 0 || deltaYaw != 0)
			Left4Utils.BotLookAt(player, destination, deltaPitch, deltaYaw);
		
		Left4Utils.PlayerForceButton(player, button);
		
		Left4Timers.AddTimer(null, holdTime, @(params) Left4Utils.PlayerUnForceButton(params.player, params.button), { player = player, button = button });
	}

	// Returns the command and fills outArgs. If something is wrong returns null
	::Left4Utils.FormatCommand <- function (outArgs, inArgs, chatTrig = "")
	{
		local cmd = strip(inArgs[0]).tolower();
		if (!cmd || cmd == "")
			return null;
			
		if (chatTrig && chatTrig != "")
		{
			local idx = cmd.find(chatTrig);
			if (idx != 0)
				return null; // if a chatTrig has been provided, the cmd must start with that, otherwise it's considered invalid
			
			cmd = cmd.slice(1); // chatTrig is removed so both chat and console commands will be the same
		}
		
		local i = 0;
		foreach (k, v in inArgs)
		{
			if (k > 0)
				outArgs[i++] <- strip(v);
		}
		return cmd;
	}

	::Left4Utils.PrecacheModel <- function (modelName)
	{
		//PrecacheEntityFromTable({ classname = "prop_dynamic", model = modelName });
		if (!IsModelPrecached(modelName))
			::PrecacheModel(modelName);
	}

	::Left4Utils.PrecacheSound <- function (soundName)
	{
		if (!IsSoundPrecached(soundName))
			::PrecacheSound(soundName);
	}

	::Left4Utils.GetAllAdjacentAreas <- function (area, table)
	{
		//local NORTH = 0;
		//local EAST = 1;
		//local SOUTH = 2;
		//local WEST = 3;
		
		if (!area)
			return;
		
		for (local dir = 0; dir < 4; dir++)
		{
			local a = {};
			area.GetAdjacentAreas(dir, a);
			
			// Merge with main table
			foreach (key, val in a)
				table[val.GetID()] <- val;
		}
	}

	::Left4Utils.GetAllLaddersOfArea <- function (area, table)
	{
		if (!area)
			return;
		
		for (local dir = 0; dir < 4; dir++)
		{
			local a = {};
			area.GetLadders(dir, a);
			
			// Merge with main table
			foreach (key, val in a)
				table[val.GetID()] <- val;
		}
	}

	::Left4Utils.FindMapAreas <- function (table)
	{
		local function HasAdjacentESCAPE_ROUTE(adjacentareas)
		{
			foreach (k, adjacent in adjacentareas)
			{
				if (adjacent.HasSpawnAttributes(NAVAREA_SPAWNATTR_ESCAPE_ROUTE))
					return true;
			}
			return false;
		}

		table["checkpointA"] <- null;
		table["checkpointB"] <- null;
		table["finale"] <- null;
		table["rescueVehicle"] <- null;

		local checkpointAflow = 99999;
		local checkpointBflow = -99999;
		local finaleflow = -99999;
		local rescueVehicleflow = -99999;
		
		local areas = {};
		NavMesh.GetAllAreas(areas);
		
		foreach (area in areas)
		{
			if (((area.HasSpawnAttributes(NAVAREA_SPAWNATTR_CHECKPOINT) || area.HasSpawnAttributes(NAVAREA_SPAWNATTR_PLAYER_START) || (area.HasSpawnAttributes(NAVAREA_SPAWNATTR_FINALE) && area.HasSpawnAttributes(NAVAREA_SPAWNATTR_ESCAPE_ROUTE))) && !area.IsBlocked(TEAM_SURVIVORS, true)) || area.HasSpawnAttributes(NAVAREA_SPAWNATTR_RESCUE_VEHICLE))
			{
				local areaflow = GetFlowDistanceForPosition(area.GetCenter());  // TODO: better use GetFlowPercentForPosition
				local adjacentareas = {};
				Left4Utils.GetAllAdjacentAreas(area, adjacentareas);
				
				if (area.HasSpawnAttributes(NAVAREA_SPAWNATTR_CHECKPOINT) || area.HasSpawnAttributes(NAVAREA_SPAWNATTR_PLAYER_START))
				{
					if (HasAdjacentESCAPE_ROUTE(adjacentareas) && (table["checkpointA"] == null || areaflow < checkpointAflow))
					{
						table["checkpointA"] <- area;
						checkpointAflow = areaflow;
					}
				}
				
				if (area.HasSpawnAttributes(NAVAREA_SPAWNATTR_CHECKPOINT))
				{
					foreach (k, adjacent in adjacentareas)
					{
						local adjacentflow = GetFlowDistanceForPosition(adjacent.GetCenter());
						if (!adjacent.HasSpawnAttributes(NAVAREA_SPAWNATTR_CHECKPOINT) && adjacent.HasSpawnAttributes(NAVAREA_SPAWNATTR_ESCAPE_ROUTE) && (table["checkpointB"] == null || adjacentflow > checkpointBflow))
						{
							table["checkpointB"] <- adjacent;
							checkpointBflow = adjacentflow;
						}
					}
				}
				
				if (area.HasSpawnAttributes(NAVAREA_SPAWNATTR_FINALE) && area.HasSpawnAttributes(NAVAREA_SPAWNATTR_ESCAPE_ROUTE))
				{
					if (table["finale"] == null || areaflow > finaleflow)
					{
						table["finale"] <- area;
						finaleflow = areaflow;
					}
				}
				
				if (area.HasSpawnAttributes(NAVAREA_SPAWNATTR_RESCUE_VEHICLE))
				{
					foreach (k, adjacent in adjacentareas)
					{
						local adjacentflow = GetFlowDistanceForPosition(adjacent.GetCenter());
						if (!adjacent.HasSpawnAttributes(NAVAREA_SPAWNATTR_RESCUE_VEHICLE) && (table["rescueVehicle"] == null || adjacentflow > rescueVehicleflow))
						{
							table["rescueVehicle"] <- adjacent;
							rescueVehicleflow = adjacentflow;
						}
					}
				}
			}
		}
		
		/*
		//local ent = Entities.FindByClassname(null, "info_player_start");
		local ent = Entities.FindByClassname(null, "info_survivor_position");
		if (ent)
		{
			local area = NavMesh.GetNearestNavArea(ent.GetOrigin(), 100, false, true);
			if (area)
				table["checkpointA"] <- area;
		}
		*/
		
		local changelevel = Entities.FindByClassname(null, "info_changelevel");
		if (!changelevel)
			table["checkpointB"] <- null;
	}
	
	// Returns the nearest nav area, with the ESCAPE_ROUTE spawn flag, from the given survivor
	::Left4Utils.GetNearestEscapeRouteArea <- function (survivor)
	{
		local survFlow = GetFlowPercentForPosition(survivor.GetOrigin(), false);
		local nearestArea = null;
		local nearestFlow = 10000000;
		
		local areas = {};
		NavMesh.GetAllAreas(areas);
		foreach (area in areas)
		{
			if (area.HasSpawnAttributes(NAVAREA_SPAWNATTR_ESCAPE_ROUTE))
			{
				local flow = abs(GetFlowPercentForPosition(area.GetCenter(), false) - survFlow);
				if (flow < nearestFlow)
				{
					nearestFlow = flow;
					nearestArea = area;
				}
			}
		}
		return nearestArea;
	}
	
	// Returns the next area (following the map's flow) connected to the given area
	// checkGround = true to perform an additional trace check on the ground
	::Left4Utils.GetNextAreaInFlow <- function (area, ignoreAreaID = 0, checkGround = false, includeBlocked = false)
	{
		local nextArea = null;
		local nextFlow = GetFlowPercentForPosition(area.GetCenter(), false);
		for (local dir = 0; dir < 4; dir++)
		{
			local areas = {};
			area.GetAdjacentAreas(dir, areas);
			foreach (a in areas)
			{
				if (ignoreAreaID == 0 || a.GetID() != ignoreAreaID)
				{
					local flow = GetFlowPercentForPosition(a.GetCenter(), false);
					
					// func_nav_blockers with affectflow param will make all the affected areas have the same flow, so in that case we'll follow the escape route
					if ((flow > nextFlow || (flow == nextFlow && a.HasSpawnAttributes(NAVAREA_SPAWNATTR_ESCAPE_ROUTE))) && (includeBlocked || !a.IsBlocked(TEAM_SURVIVORS, false)) && (!checkGround || Left4Utils.FindGroundFrom(a.GetCenter() + Vector(0, 0, 20), 240, 0).valid) && CheckAreasZDiff(area, a)) // Avoid areas that are too high or too low to jump on
					{
						nextFlow = flow;
						nextArea = a;
					}
				}
			}
		}
		return nextArea;
	}
	
	// Returns the next area (following the map's flow) connected to the given area via ladder
	// checkGround = true to perform an additional trace check on the ground
	::Left4Utils.GetNextLadderAreaInFlow <- function (area, ignoreAreaID = 0, checkGround = false, includeBlocked = false)
	{
		local areaID = area.GetID();
		local nextArea = null;
		local areaFlow = GetFlowPercentForPosition(area.GetCenter(), false);
		local nextFlow = areaFlow
		for (local dir = 0; dir < 4; dir++)
		{
			local ladders = {};
			area.GetLadders(dir, ladders);
			foreach (ladder in ladders)
			{
				if (ladder.IsUsableByTeam(TEAM_SURVIVORS))
				{
					// Apparently GetTopArea and GetBottomArea can be null
					//local otherArea = ladder.GetTopArea();
					//if (!otherArea || otherArea.GetID() == areaID)
					//	otherArea = ladder.GetBottomArea();
					
					local otherArea = Left4Utils.GetNearestLadderArea(ladder, false);
					if (!otherArea || otherArea.GetID() == areaID)
						otherArea = Left4Utils.GetNearestLadderArea(ladder, true);
					
					if (otherArea && (ignoreAreaID == 0 || otherArea.GetID() != ignoreAreaID) && otherArea.GetID() != areaID)
					{
						local flow = GetFlowPercentForPosition(otherArea.GetCenter(), false);
						
						// func_nav_blockers with affectflow param will make all the affected areas have the same flow, so in that case we'll follow the escape route
						if ((flow > nextFlow || (flow == nextFlow && otherArea.HasSpawnAttributes(NAVAREA_SPAWNATTR_ESCAPE_ROUTE))) && (includeBlocked || !otherArea.IsBlocked(TEAM_SURVIVORS, false)) && (!checkGround || Left4Utils.FindGroundFrom(otherArea.GetCenter() + Vector(0, 0, 20), 240, 0).valid))
						{
							nextFlow = flow;
							nextArea = otherArea;
						}
					}
				}
			}
		}
		return nextArea;
	}
	
	// Search the area, connected to the given ladder, which is closer to the top (top = true) or bottom (top = false) of the ladder
	::Left4Utils.GetNearestLadderArea <- function (ladder, top = false)
	{
		local function HasLadderWithID(area, ladderID)
		{
			for (local dir = 0; dir < 4; dir++)
			{
				local ladders = {};
				area.GetLadders(dir, ladders);
				foreach (ladder in ladders)
				{
					if (ladder.GetID() == ladderID)
						return true;
				}
			}
			return false;
		}
		
		local area = null;
		if (top)
			area = ladder.GetTopArea();
		else
			area = ladder.GetBottomArea();

		if (area)
			return area; // We're lucky, we can just use GetTopArea/GetBottomArea

		local orig = null;
		if (top)
			orig = ladder.GetTopOrigin();
		else
			orig = ladder.GetBottomOrigin();
		
		local ret = null;
		local minZDiff = 1000000;
		local areas = {};
		NavMesh.GetNavAreasInRadius(orig, 200, areas);
		foreach (area in areas)
		{
			if (HasLadderWithID(area, ladder.GetID()))
			{
				// Nearest area is calculated on the Z axis (height) only
				local zDiff = abs(orig.z - area.GetCenter().z);
				if (zDiff < minZDiff)
				{
					ret = area;
					minZDiff = zDiff;
				}
			}
		}
		
		return ret;
	}
	
	// Find the 2 closest corners of the given adjacent nav areas and calculate the height difference between the 2 points.
	// Returns whether the height difference is not too much in order for a survivor to be able to jump on it or to drop from it without damage.
	// maxClimbHeight = 66 and maxDropHeight = 240 defaults are the same defaults of the nav_flow_max_survivor_climb_height and nav_flow_max_survivor_drop_height cvars
	::Left4Utils.CheckAreasZDiff <- function (areaFrom, areaTo, maxClimbHeight = 66, maxDropHeight = 240)
	{
		local closestCornerFrom = null;
		local closestCornerTo = null;
		local closestDist = 100000000;
		
		for (local c1 = 0; c1 < 4; c1++)
		{
			local cornerFrom = areaFrom.GetCorner(c1);
			for (local c2 = 0; c2 < 4; c2++)
			{
				local cornerTo = areaTo.GetCorner(c2);
				local d = (cornerTo - cornerFrom).Length();
				
				if (d < closestDist)
				{
					closestCornerFrom = cornerFrom;
					closestCornerTo = cornerTo;
					closestDist = d;
				}
			}
		}
		
		local zDiff = closestCornerTo.z - closestCornerFrom.z;
		return (zDiff <= maxClimbHeight && zDiff >= -maxDropHeight);
	}
	
	// Returns the farthest (in the map's flow) pathable position
	// limitDistance > 0 to limit the calculated path (and so the returned farthest position) to this max (roughly) distance from the survivor's current position
	// dontStopOnDamaging = true to avoid returning the position of a DAMAGING nav area but to return the first non DAMAGING after that
	// detourMaxDistance > 0 to try calc an alternative route to get past currently blocked nav areas (this will be the max distance of the detour)
	// checkGround = true to perform an additional trace check on the ground
	// debugDrawDuration > 0 to draw the entire calculated path on screen (only visible to the host) for the given amount of time
	::Left4Utils.GetFarthestPathableFlowPos <- function (survivor, limitDistance = 0, dontStopOnDamaging = false, detourMaxDistance = 0, checkGround = false, debugDrawDuration = 0)
	{
		local ret = null;
		local distance = 0;
		local prevAreaID = 0;
		local endAreaID = 0;
		//local startArea = Left4Utils.GetNearestEscapeRouteArea(survivor);
		//local startArea = NavMesh.GetNavArea(survivor.GetOrigin(), 30);
		//local startArea = NavMesh.GetNearestNavArea(survivor.GetOrigin(), 200, true, true);
		local startArea = survivor.GetLastKnownArea();
		if (!startArea)
		{
			// This shouldn't happen, tho
			if (debugDrawDuration > 0)
				DebugDrawCircle(survivor.GetOrigin(), Vector(255, 0, 0), 255, 10, true, debugDrawDuration);
			
			return survivor.GetOrigin();
		}
		local currentArea = startArea;
		
		local debugAreas = [];
		if (debugDrawDuration > 0)
			debugAreas.append({ id = currentArea.GetID(), pos = currentArea.GetCenter(), blocked = false }); // The first will be drawn as start area

		if (detourMaxDistance > 0)
		{
			// Here we'll try to calculate an alternate path to get past the blocked areas

			local nextArea = Left4Utils.GetNextAreaInFlow(currentArea, prevAreaID, checkGround, true);
			if (!nextArea)
				nextArea = Left4Utils.GetNextLadderAreaInFlow(currentArea, prevAreaID, checkGround, true);
			
			local preBlocked = null;
			local isBlocked = false;
			while (nextArea)
			{
				isBlocked = nextArea.IsBlocked(TEAM_SURVIVORS, false);
				if (!preBlocked && isBlocked)
					preBlocked = currentArea; // Save the non blocked area prior the first blocked one
				
				if (debugDrawDuration > 0)
					debugAreas.append({ id = nextArea.GetID(), pos = nextArea.GetCenter(), blocked = isBlocked });
				
				prevAreaID = currentArea.GetID();
				distance += (nextArea.GetCenter() - currentArea.GetCenter()).Length();
				currentArea = nextArea;
				
				if (!isBlocked && limitDistance > 0 && distance >= limitDistance && (!dontStopOnDamaging || !currentArea.IsDamaging()))
					nextArea = null; // Stop when distance > limitDistance and we are not over a blocked (or damaging) area
				else
				{
					nextArea = Left4Utils.GetNextAreaInFlow(currentArea, prevAreaID, checkGround, true);
					if (!nextArea)
						nextArea = Left4Utils.GetNextLadderAreaInFlow(currentArea, prevAreaID, checkGround, true);
				}
			}
			
			if (preBlocked)
			{
				endAreaID = preBlocked.GetID();
				
				if (!isBlocked)
				{
					// We got through blocked areas, let's see if we can calculate a valid alternate path
					local detourEndPos = Left4Utils.GetFarthestPathableDetourPos(startArea, currentArea, detourMaxDistance, checkGround, debugDrawDuration);
					if (detourEndPos)
						ret = detourEndPos; // We got a valid detour, return it's end (area with highest flow)
					else
						ret = preBlocked.GetCenter(); // No valid detour, return the position of the last normal area before the first blocked one
				}
				else
					ret = preBlocked.GetCenter(); // For some reason we couldn't find a non blocked area after the blocked ones, return the position of the last normal area before the first blocked one
			}
			else
			{
				// There was no blocked area at all
				endAreaID = currentArea.GetID();
				ret = currentArea.GetCenter();
			}
		}
		else
		{
			// Here we'll stop at the area prior the first blocked area
			
			local nextArea = Left4Utils.GetNextAreaInFlow(currentArea, prevAreaID, checkGround, false);
			if (!nextArea)
				nextArea = Left4Utils.GetNextLadderAreaInFlow(currentArea, prevAreaID, checkGround, false);
			
			while (nextArea)
			{
				if (debugDrawDuration > 0)
					debugAreas.append({ id = nextArea.GetID(), pos = nextArea.GetCenter(), blocked = false });
				
				prevAreaID = currentArea.GetID();
				distance += (nextArea.GetCenter() - currentArea.GetCenter()).Length();
				currentArea = nextArea;
				
				if (limitDistance > 0 && distance >= limitDistance && (!dontStopOnDamaging || !nextArea.IsDamaging()))
					nextArea = null; // Stop when distance > limitDistance (and we are not over a damaging area)
				else
				{
					nextArea = Left4Utils.GetNextAreaInFlow(currentArea, prevAreaID, checkGround, false);
					if (!nextArea)
						nextArea = Left4Utils.GetNextLadderAreaInFlow(currentArea, prevAreaID, checkGround, false);
				}
			}
			
			endAreaID = currentArea.GetID();
			ret = currentArea.GetCenter();
		}
		
		if (debugDrawDuration > 0)
		{
			for (local i = 0; i < debugAreas.len(); i++)
			{
				if (debugAreas[i].id == endAreaID)
					DebugDrawCircle(debugAreas[i].pos, Vector(255, 0, 0), 255, 10, true, debugDrawDuration); // End area
				else if (i == 0)
					DebugDrawCircle(debugAreas[i].pos, Vector(0, 255, 0), 255, 10, true, debugDrawDuration); // Start area
				else if (debugAreas[i].blocked)
					DebugDrawCircle(debugAreas[i].pos, Vector(255, 255, 0), 255, 10, true, debugDrawDuration); // Blocked area
				else
					DebugDrawCircle(debugAreas[i].pos, Vector(0, 255, 255), 255, 10, true, debugDrawDuration); // Normal area
				
				if (i > 0)
					DebugDrawLine_vCol(debugAreas[i-1].pos, debugAreas[i].pos, Vector(255, 255, 255), true, debugDrawDuration); // Connecting line
			}
		}
		
		return ret;
	}
	
	// Builds a path from startArea to endArea which must be within maxDetourDistance. If a path exists, it checks whether the path is actually traversable by a survivor
	// If a survivor can actually path from starArea to endArea, the position of the area (of the built path) with the highest flow is returned, otherwise null
	::Left4Utils.GetFarthestPathableDetourPos <- function (startArea, endArea, maxDetourDistance = 10000, checkGround = false, debugDrawDuration = 0)
	{
		// GetNavAreasFromBuildPath isn't usable. It returns the path in a table which doesn't keep the correct order
		if (!NavMesh.NavAreaBuildPath(startArea, endArea, endArea.GetCenter(), maxDetourDistance, TEAM_SURVIVORS, false))
			return null;
		
		// Read the path from the end area to the start
		local detour = [];
		local area = endArea;
		while (area)
		{
			detour.append(area);
			area = area.GetParent();
		}
		
		local ret = null;
		local endAreaID = 0;
		local prevArea = null;
		local endFlow = GetFlowPercentForPosition(startArea.GetCenter(), false);
		local debugAreas = [];
		
		for (local i = detour.len() - 1; i >= 0; i--)
		{
			local area = detour[i];
			if (prevArea)
			{
				// Can survivors actually get from prevArea to area?
				if (area.IsBlocked(TEAM_SURVIVORS, false) || (checkGround && !Left4Utils.FindGroundFrom(area.GetCenter() + Vector(0, 0, 20), 240, 0).valid) || !CheckAreasZDiff(prevArea, area))
					return null; // No
				
				if (debugDrawDuration > 0)
					debugAreas.append({ id = area.GetID(), pos = area.GetCenter() });
				
				// Get the aera with the highest flow along the detour
				local flow = GetFlowPercentForPosition(area.GetCenter(), false);
				if (flow > endFlow)
				{
					endFlow = flow;
					endAreaID = area.GetID();
					ret = area.GetCenter();
				}
				
				prevArea = area;
			}
			else
				prevArea = area;
		}
		
		if (debugDrawDuration > 0)
		{
			for (local i = 0; i < debugAreas.len(); i++)
			{
				if (i > 0)
					DebugDrawLine_vCol(debugAreas[i-1].pos, debugAreas[i].pos, Vector(255, 255, 255), true, debugDrawDuration); // Connecting line
				
				if (debugAreas[i].id == endAreaID)
				{
					DebugDrawCircle(debugAreas[i].pos, Vector(255, 0, 0), 255, 10, true, debugDrawDuration); // Draw circle for detour end area
					break;
				}
				else
					DebugDrawCircle(debugAreas[i].pos, Vector(255, 0, 255), 255, 10, true, debugDrawDuration); // Draw circle for detour normal area
			}			
		}
		
		// If we are here it means that the detour was fully pathable and, if everything went right, ret contains the position of the area with the highest flow along the detour
		return ret;
	}
	
	// Basically it's NavMesh.GetNavAreasFromBuildPath but instead of having a table with randomically ordered areas it uses an array (outReversedPath)
	// The areas in the array will be in reverse order (from endArea to startArea)
	// dbgDrawDuration > 0 to draw the path on screen (only visible to the host) for this amount of time
	::Left4Utils.GetNavAreasFromBuildPath <- function (startArea, endArea, goalPos, flMaxPathLength, teamID, ignoreNavBlockers, outReversedPath, dbgDrawDuration = 0)
	{
		if (!NavMesh.NavAreaBuildPath(startArea, endArea, goalPos, flMaxPathLength, teamID, ignoreNavBlockers))
			return false;

		local prev = null;
		local area = endArea;
		while (area)
		{
			// outReversedPath.insert(0, area); // DON'T DO IT!!! A for loop from outReversedPath.len()-1 down to 0 is a lot better than a "Script terminated by SQQuerySuspend"
			outReversedPath.append(area);
			
			if (dbgDrawDuration > 0)
			{
				if (prev)
				{
					if (area.GetParent())
						DebugDrawCircle(area.GetCenter(), Vector(0, 255, 255), 255, 10, true, dbgDrawDuration); // Middle area
					else
					{
						DebugDrawCircle(area.GetCenter(), Vector(0, 255, 0), 255, 10, true, dbgDrawDuration); // It's the startArea
						DebugDrawText(area.GetCenter(), "START", false, dbgDrawDuration);
					}
					
					// Connecting line
					DebugDrawLine_vCol(prev.GetCenter(), area.GetCenter(), Vector(255, 255, 255), true, dbgDrawDuration);
					//DebugDrawBoxDirection(prev.GetCenter(), Vector(-10, -10, -10), Vector(10, 10, 10), (area.GetCenter() - prev.GetCenter()), Vector(255, 0, 0), 255, dbgDrawDuration);
				}
				else
				{
					// The first is endArea
					DebugDrawCircle(area.GetCenter(), Vector(255, 0, 0), 255, 10, true, dbgDrawDuration);
					DebugDrawText(area.GetCenter(), "END", false, dbgDrawDuration);
				}
				
				//local how = area.GetParentHow();
				//DebugDrawText(area.GetCenter(), "how: " + how, false, dbgDrawDuration);
			}
			
			prev = area;
			area = area.GetParent();
		}
		
		return true;
	}
	
	::Left4Utils.PrintStackTrace <- function ()
	{
		Left4Utils.PrintTable(getstackinfos(2));
	}
	
	::Left4Utils.GetMaxIncapCount <- function ()
	{
		if (("SurvivorMaxIncapacitatedCount" in DirectorScript.GetDirectorOptions()) && DirectorScript.GetDirectorOptions().SurvivorMaxIncapacitatedCount != null)
			return DirectorScript.GetDirectorOptions().SurvivorMaxIncapacitatedCount;

		return Convars.GetFloat("survivor_max_incapacitated_count");
	}
	
	::Left4Utils.IncapacitatePlayer <- function (player, dmgType = 0, attacker = null)
	{
		if (!player || !player.IsValid())
			return;
		
		local h = player.GetHealth();
		if ("GetHealthBuffer" in player)
			h += player.GetHealthBuffer();
		
		if (!attacker)
			attacker = Entities.FindByClassname(null, "worldspawn");
		if (!attacker)
			attacker = player;

		player.TakeDamage(h, dmgType, attacker);
	}
	
	::Left4Utils.KillPlayer <- function (player, dmgType = 0, attacker = null)
	{
		if (!player || !player.IsValid())
			return;
		
		if ("IsSurvivor" in player && player.IsSurvivor())
			player.SetReviveCount(Left4Utils.GetMaxIncapCount());
		
		Left4Utils.IncapacitatePlayer(player, dmgType, attacker);
	}
	
	::Left4Utils.RescueSurvivor <- function (survivor)
	{
		if (!survivor || !survivor.IsValid() || !("IsSurvivor" in survivor) || !survivor.IsSurvivor())
			return false;
		
		local ent = null;
		while (ent = Entities.FindByClassname(ent, "info_survivor_rescue"))
		{
			local surv = NetProps.GetPropEntity(ent, "m_survivor");
			if (surv && surv.IsValid() && surv.GetEntityIndex() == survivor.GetEntityIndex())
			{
				DoEntFire("!self", "Rescue", "", 0, null, ent);
				return true;
			}
		}
		return false;
	}
	
	::Left4Utils.ClientCommand <- function (player, command)
	{
		if (!player || !player.IsValid())
			return;
		
		local pc = g_ModeScript.CreateSingleSimpleEntityFromTable({ classname = "point_clientcommand", origin = Vector(0, 0, 0), angles = QAngle(0, 0, 0) });
		if (!pc)
			return;
		
		DoEntFire("!self", "Command", command, 0, player, pc);
		DoEntFire("!self", "Kill", "", 0.1, null, pc);
	}

	::Left4Utils.StopDirector <- function ()
	{
		if (Left4Utils.DirectorStopped)
			return;

		Left4Utils.DirectorStopCVARS["director_no_bosses"] <- Convars.GetStr("director_no_bosses");
		Left4Utils.DirectorStopCVARS["director_no_mobs"] <- Convars.GetStr("director_no_mobs");
		Left4Utils.DirectorStopCVARS["director_no_specials"] <- Convars.GetStr("director_no_specials");
		Left4Utils.DirectorStopCVARS["director_ready_duration"] <- Convars.GetStr("director_ready_duration");
		Left4Utils.DirectorStopCVARS["z_common_limit"] <- Convars.GetStr("z_common_limit");
		Left4Utils.DirectorStopCVARS["z_mega_mob_size"] <- Convars.GetStr("z_mega_mob_size");
		
		Convars.SetValue("director_no_bosses", 1);
		Convars.SetValue("director_no_mobs", 1);
		Convars.SetValue("director_no_specials", 1);
		Convars.SetValue("director_ready_duration", 0);
		Convars.SetValue("z_common_limit", 0);
		Convars.SetValue("z_mega_mob_size", 1);
		
		Left4Utils.DirectorStopped = true;
	}

	::Left4Utils.StartDirector <- function ()
	{
		if (!Left4Utils.DirectorStopped)
			return;

		Convars.SetValue("director_no_bosses", Left4Utils.DirectorStopCVARS["director_no_bosses"]);
		Convars.SetValue("director_no_mobs", Left4Utils.DirectorStopCVARS["director_no_mobs"]);
		Convars.SetValue("director_no_specials", Left4Utils.DirectorStopCVARS["director_no_specials"]);
		Convars.SetValue("director_ready_duration", Left4Utils.DirectorStopCVARS["director_ready_duration"]);
		Convars.SetValue("z_common_limit", Left4Utils.DirectorStopCVARS["z_common_limit"]);
		Convars.SetValue("z_mega_mob_size", Left4Utils.DirectorStopCVARS["z_mega_mob_size"]);
		
		Left4Utils.DirectorStopped = false;
	}
	
	::Left4Utils.ServerCommand <- function (command)
	{
		local ps = g_ModeScript.CreateSingleSimpleEntityFromTable({ classname = "point_servercommand" });
		if (!ps)
			return false;

		DoEntFire("!self", "Command", command, 0, null, ps);
		DoEntFire("!self", "Kill", "", 0.1, null, ps);
		
		return true;
	}
	
	/*
		There is also a way to get the game's internal (C++) picker entity (but you can't filter by class):
		
		::DoNothing <- function ()
		{
		}

		::GetPicker <- function ()
		{
			printl("self: " + self.GetClassname()); 			// self is the picker entity
			printl("activator: " + activator.GetPlayerName());	// activator is the player entity
			
			// Do your stuff with self and activator
		}

		DoEntFire("!picker", "CallScriptFunction", "DoNothing", 0, player, player); // This is needed because the first time you call GetPicker on an entity, sometimes the activator variable doesn't exist yet
		DoEntFire("!picker", "CallScriptFunction", "GetPicker", 0, player, player);
		
	*/
	::Left4Utils.GetPickerEntity <- function (player, radius = 999999, threshold = 0.95, visibleOnly = true, entClass = null)
	{
		if (!player || !player.IsValid())
			return null;
		
		local start = player.EyePosition();
		local end = start + player.EyeAngles().Forward().Scale(radius);
			
		local m_trace = { start = start, end = end, ignore = player, mask = TRACE_MASK_DEFAULT };
		TraceLine(m_trace);
			
		if (m_trace.hit && m_trace.enthit && m_trace.enthit.IsValid() && m_trace.enthit != player && m_trace.enthit.GetClassname() != "worldspawn" && (entClass == null || m_trace.enthit.GetClassname() == entClass))
			return m_trace.enthit;

		local bestDot = threshold;
		local bestEnt = null;
		local ent = null;
		if (entClass == null)
		{
			while (ent = Entities.FindInSphere(ent, player.GetOrigin(), radius))
			{
				local facing = player.EyeAngles().Forward();
				local toEnt = ent.GetCenter() - player.GetCenter();
				toEnt.Norm();
				local dot = facing.Dot(toEnt);
				if (dot > bestDot)
				{
					if (NetProps.GetPropInt(ent, "m_hOwner") <= 0 && ent.GetModelName() != "" && ent.GetClassname() != "worldspawn" && (!visibleOnly || Left4Utils.CanTraceTo(player, ent)))
					{
						bestDot = dot;
						bestEnt = ent;
					}
				}
			}
		}
		else
		{
			while (ent = Entities.FindByClassnameWithin(ent, entClass, player.GetOrigin(), radius))
			{
				local facing = player.EyeAngles().Forward();
				local toEnt = ent.GetCenter() - player.GetCenter();
				toEnt.Norm();
				local dot = facing.Dot(toEnt);
				if (dot > bestDot)
				{
					if (NetProps.GetPropInt(ent, "m_hOwner") && (!visibleOnly || Left4Utils.CanTraceTo(player, ent)))
					{
						bestDot = dot;
						bestEnt = ent;
					}
				}
			}
		}
		return bestEnt;
	}
	
	::Left4Utils.SetItemSkin <- function (params)
	{
		local player = params["player"];
		if (!player || !player.IsValid())
			return;
		
		local itemClass = params["itemClass"];
		local item = Left4Utils.GetInventoryItem(player, itemClass);
		if (!item || !item.IsValid())
			return;
		
		local skinNumber = params["skinNumber"];
		NetProps.SetPropInt(item, "m_nSkin", skinNumber);
	}
	
	::Left4Utils.GiveItemWithSkin <- function (player, itemClass, skinNumber)
	{
		if (!player || !player.IsValid())
			return;
		
		//player.GiveItemWithSkin(itemClass, skinNumber);
		
		player.GiveItem(itemClass);
		Left4Timers.AddTimer(null, 0.2, Left4Utils.SetItemSkin, { player = player, itemClass = itemClass, skinNumber = skinNumber }, false);
	}

	::Left4Utils.GetMeleeIdByModel <- function (modelName)
	{
		local mdl = Left4Utils.StringReplace(modelName, "models/weapons/melee/", "");
		mdl = Left4Utils.StringReplace(mdl, "models/w_models/weapons/", "");
		mdl = Left4Utils.StringReplace(mdl, ".mdl", "");
		if (mdl in Left4Utils.MeleeWeaponModels)
			return Left4Utils.MeleeWeaponModels[mdl];
		else
			return Left4Utils.MeleeWeaponModels.none;
	}

	::Left4Utils.GetWeaponId <- function (weaponent)
	{
		local id = Left4Utils.WeaponId.none;
		//if (!weaponent || !weaponent.IsValid())
		//	return id;
		
		local className = weaponent.GetClassname();
		//printl("Left4Utils.GetWeaponId - className: " + className);
		
		if (className.find("weapon_") != null)
		{
			// weapon_*
			
			local isSpawn = className.find("_spawn");
			if (isSpawn)
			{
				// weapon_*_spawn
				
				if (NetProps.GetPropInt(weaponent, "m_itemCount") <= 0)
				{
					//printl("Left4Utils.GetWeaponId - m_itemCount <= 0");
					return Left4Utils.WeaponId.none;
				}
				
				id = NetProps.GetPropInt(weaponent, "m_weaponID");
			}

			if (id <= Left4Utils.WeaponId.none)
			{
				if (isSpawn)
					className = Left4Utils.StringReplace(className, "_spawn", "");

				if (className in Left4Utils.WeaponId)
					id = Left4Utils.WeaponId[className];
			}
			
			if (id == Left4Utils.WeaponId.weapon_melee)
			{
				// weapon_melee*
				
				if (isSpawn)
					className = NetProps.GetPropString(weaponent, "m_iszMeleeWeapon"); // This can also be "Any"
				else
					className = NetProps.GetPropString(weaponent, "m_strMapSetScriptName");
				
				//printl("Left4Utils.GetWeaponId - melee: " + className);
				
				if (className in Left4Utils.MeleeWeaponId)
					id = Left4Utils.MeleeWeaponId[className];
				else
					id = Left4Utils.GetMeleeIdByModel(weaponent.GetModelName());
			}
		}
		else if (className in Left4Utils.UpgradeWeaponId)
		{
			// upgrade_*
			
			if (NetProps.GetPropInt(weaponent, "m_itemCount") <= 0)
			{
				//printl("Left4Utils.GetWeaponId - m_itemCount <= 0 (upgrade)");
				return Left4Utils.UpgradeWeaponId.none;
			}
			
			id = Left4Utils.UpgradeWeaponId[className];
		}
		
		//printl("Left4Utils.GetWeaponId - id: " + id);
		
		return id;
	}

	::Left4Utils.GetWeaponIdByName <- function (weaponName)
	{
		if (weaponName in Left4Utils.WeaponId)
			return Left4Utils.WeaponId[weaponName];
		
		if ("weapon_" + weaponName in Left4Utils.WeaponId)
			return Left4Utils.WeaponId["weapon_" + weaponName];
		
		if (weaponName in Left4Utils.MeleeWeaponId)
			return Left4Utils.MeleeWeaponId[weaponName];
		
		if (weaponName in Left4Utils.UpgradeWeaponId)
			return Left4Utils.UpgradeWeaponId[weaponName];

		if ("upgrade_" + weaponName in Left4Utils.UpgradeWeaponId)
			return Left4Utils.UpgradeWeaponId["upgrade_" + weaponName];
		
		Left4Utils.WeaponId.none;
	}

	// Returns the inventory slot number (0 to 4) for the weapon with the given id
	// Will also return 5 for hold items (gascan, propanetank, oxygentank, gnome, cola_bottles, fireworkcrate) or -1 if unhandled weapon
	::Left4Utils.GetWeaponSlotById <- function (weaponId)
	{
		switch (weaponId)
		{
			case 2:
			case 3:
			case 4:
			case 5:
			case 6:
			case 7:
			case 8:
			case 9:
			case 10:
			case 11:
			case 21:
			case 26:
			case 33:
			case 34:
			case 35:
			case 36:
			case 37:
				return 0;
				break;
			
			case 1:
			case 19:
			case 20:
			case 32:
			case 101:
			case 102:
			case 103:
			case 104:
			case 105:
			case 106:
			case 107:
			case 108:
			case 109:
			case 110:
			case 111:
			case 112:
			case 113:
			case 114:
				return 1;
				break;

			case 13:
			case 14:
			case 25:
				return 2;
			
			case 12:
			case 24:
			case 30:
			case 31:
				return 3;
				break;
			
			case 15:
			case 23:
				return 4;
				break;
			
			case 16:
			case 17:
			case 18:
			case 27:
			case 28:
			case 29:
				return 5;
				break;
			
			default:
				return -1;
		}
	}

	::Left4Utils.HasWeaponId <- function (player, weaponid)
	{
		local slot = Left4Utils.GetWeaponSlotById(weaponid);
		if (slot >= 0)
		{
			local weapon = Left4Utils.GetInventoryItemInSlot(player, slot);
			return (weapon != null && weapon.IsValid() && Left4Utils.GetWeaponId(weapon) == weaponid);
		}
		
		local inv = {};
		GetInvTable(player, inv);
		foreach (weapon in inv)
		{
			if (weapon != null && weapon.IsValid() && Left4Utils.GetWeaponId(weapon) == weaponid)
				return true;
		}
		return false;
	}

	::Left4Utils.GetAmmoPercent <- function (weaponent)
	{
		if (!("Clip1" in weaponent))
			return 100.0; // Assume it's a weapon spawn
		
		local ammoType = NetProps.GetPropInt(weaponent, "m_iPrimaryAmmoType");
		local maxAmmo = Left4Utils.GetMaxAmmo(ammoType) + weaponent.GetMaxClip1();
		local owner = NetProps.GetPropEntity(weaponent, "m_hOwner");
		if (owner && owner.IsPlayer())
			return (100.0 / maxAmmo) * (NetProps.GetPropIntArray(owner, "m_iAmmo", ammoType) + weaponent.Clip1());
		else
		{
			local ammo = NetProps.GetPropInt(weaponent, "m_iExtraPrimaryAmmo");
			if (ammo < 0)
				ammo = 0;
			return (100.0 / maxAmmo) * (ammo + weaponent.Clip1());
		}
	}

	// Returns true if the survivor with the given character id can use the given deployed upgrade pack, false if can't (likely already used it)
	// Note: upgrade_laser_sight seem to keep m_iUsedBySurvivorsMask to 0, so the survivors can always reuse it
	// Note2: extra (manually spawned with charid > 3) survivor bots don't seem to set their flag when using the upgrade but they still affect the use count, so they can keep reuse the same upgrade as long as it's count is > 0
	// Note3: survivor bots don't seem to use incediary/explosive ammo upgrades if they already have at least 1 upgraded bullet in their weapon
	::Left4Utils.CanUseUpgrade <- function (charid, upgradeent)
	{
		return (NetProps.GetPropInt(upgradeent, "m_iUsedBySurvivorsMask") & (1 << charid)) == 0;
	}

	//
}