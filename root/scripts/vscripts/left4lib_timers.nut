//------------------------------------------------------
//     Author : smilzo
//     https://steamcommunity.com/id/smilz0
//------------------------------------------------------

if (!("Left4Timers" in getroottable()))
{
	::Left4Timers <-
	{
		DummyEnt = null
		Timers = {}
	}

	::Left4Timers.AddTimer <- function(name, delay, func, params = {}, repeat = false)
	{
		if (!name || name == "")
			name = UniqueString();
		else if (name in ::Left4Timers.Timers)
		{
			error("[Left4Timers][WARN] AddTimer - A timer with this name already exists: " + name + "\n");
			return false;
		}
		
		local si = getstackinfos(2);
		local f = "";
		local s = "";
		local l = "";
		if ("func" in si)
			f = si.func;
		if ("src" in si)
			s = si.src;
		if ("line" in si)
			l = si.line;
		local dbgInfo = "Func: " + f + " - Src: " + s + " - Line: " + l;
		
		local timer = { Delay = delay, Func = func, params = params, Repeat = repeat, LastTime = Time(), DbgInfo = dbgInfo };
		::Left4Timers.Timers[name] <- timer;
		
		return true;
	}

	::Left4Timers.RemoveTimer <- function(name)
	{
		if (!(name in ::Left4Timers.Timers))
		{
			//error("[Left4Timers][WARN] RemoveTimer - A timer with this name does not exist: " + name + "\n");
			return false;
		}
		
		delete ::Left4Timers.Timers[name];
		
		return true;
	}

	::Left4Timers.ThinkFunc <- function()
	{
		local curtime = Time();
		
		foreach (timerName, timer in ::Left4Timers.Timers)
		{
			if ((curtime - timer.LastTime) >= timer.Delay)
			{
				if (timer.Repeat)
					timer.LastTime = curtime;
				else
					delete ::Left4Timers.Timers[timerName];
				
				try
				{
					timer.Func(timer.params);
				}
				catch(exception)
				{
					error("[Left4Timers][ERROR] Exception in timer '" + timerName + "': " + exception + " (" + timer.DbgInfo + ")\n");
				}
			}
		}
		
		return 0.01;
	}
}

if (!::Left4Timers.DummyEnt || !::Left4Timers.DummyEnt.IsValid())
{
	::Left4Timers.DummyEnt = SpawnEntityFromTable("info_target", { targetname = "left4timers" });
	if (::Left4Timers.DummyEnt)
	{
		::Left4Timers.DummyEnt.ValidateScriptScope();
		local scope = ::Left4Timers.DummyEnt.GetScriptScope();
		scope["L4TThinkFunc"] <- ::Left4Timers.ThinkFunc;
		AddThinkToEnt(::Left4Timers.DummyEnt, "L4TThinkFunc");
			
		printl("[Left4Timers][DEBUG] Spawned dummy entity");
	}
	else
		error("[Left4Timers][ERROR] Failed to spawn dummy entity!\n");
}
else
	printl("[Left4Timers][DEBUG] Dummy entity already spawned");
