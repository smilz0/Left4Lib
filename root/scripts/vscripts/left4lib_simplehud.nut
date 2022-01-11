//------------------------------------------------------
//     Author : smilzo
//     https://steamcommunity.com/id/smilz0
//------------------------------------------------------

if (!("Left4Hud" in getroottable()))
{
	::Left4Hud <-
	{
		Hud = { Fields = {} }
	}

	::Left4Hud.AddHud <- function (name, slot, flags)
	{
		if (name in ::Left4Hud.Hud.Fields)
			return false;
		
		Left4Hud.Hud.Fields[name] <- { slot = slot, flags = flags, datafunc = @() ::Left4Hud.GetHudText(name), text = "" };
		
		HUDSetLayout(Left4Hud.Hud);
		
		return true;
	}

	::Left4Hud.RemoveHud <- function (name)
	{
		if (!(name in ::Left4Hud.Hud.Fields))
			return false;
		
		delete ::Left4Hud.Hud.Fields[name];
		
		HUDSetLayout(Left4Hud.Hud);
		
		return true;
	}

	::Left4Hud.PlaceHud <- function (name, x, y, w, h)
	{
		if (!(name in ::Left4Hud.Hud.Fields))
			return false;
		
		HUDPlace(Left4Hud.Hud.Fields[name].slot, x, y, w, h);
		
		return true;
	}

	::Left4Hud.HudIsHidden <- function (name)
	{
		if (!(name in ::Left4Hud.Hud.Fields))
			return false;

		return (Left4Hud.Hud.Fields[name].flags & g_ModeScript.HUD_FLAG_NOTVISIBLE) != 0;
	}

	::Left4Hud.ShowHud <- function (name)
	{
		if (!(name in ::Left4Hud.Hud.Fields))
			return false;

		Left4Hud.Hud.Fields[name].flags = Left4Hud.Hud.Fields[name].flags & ~(g_ModeScript.HUD_FLAG_NOTVISIBLE);
		return true;
	}

	::Left4Hud.HideHud <- function (name)
	{
		if (!(name in ::Left4Hud.Hud.Fields))
			return false;

		Left4Hud.Hud.Fields[name].flags = Left4Hud.Hud.Fields[name].flags | g_ModeScript.HUD_FLAG_NOTVISIBLE;
		return true;
	}

	::Left4Hud.GetHudText <- function (name)
	{
		if (!(name in ::Left4Hud.Hud.Fields))
			return null;

		return Left4Hud.Hud.Fields[name].text;
	}

	::Left4Hud.SetHudText <- function (name, text)
	{
		if (!(name in ::Left4Hud.Hud.Fields))
			return false;

		Left4Hud.Hud.Fields[name].text = text;
		return true;
	}
}
