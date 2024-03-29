//------------------------------------------------------
//     Author : smilzo
//     https://steamcommunity.com/id/smilz0
//------------------------------------------------------
/*
	Handles timed function calls and custom Think functions.
	
	NOTE: ::Left4Timers isn't available until another addon includes this script.
	
	To use add:
		IncludeScript("left4lib_timers");
	on top of your script.
	
	Then:
		Left4Timers.AddTimer(timername, delay, yourfunction, params = {}, repeat = false);
	to register a timer called 'timername' that calls 'yourfunction' after 'delay' passing it 'params'.
	If repeat is true, 'yourfunction' will be called each 'delay' until you unregister the timer with:
		Left4Timers.RemoveTimer(timername);
	
	For repeating tasks you can also use:
		Left4Timers.AddThinker(thinkername, delay, yourfunction, params = {});
	'yourfunction' will be called each 'delay' until you unregister the thinker with:
		Left4Timers.RemoveThinker(thinkername);
	The difference is that in this case 'yourfunction' will run in the context of a separate entity that is spawned just to run your thinker function.
*/

IncludeScript("left4lib_consts");

if (!("Left4Timers" in getroottable()))
{
	::Left4Timers <-
	{
		DummyEnt = null
		Timers = {}
		Thinkers = {}
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
					error("[Left4Timers][ERROR] Exception in timer '" + timerName + "': " + exception + " (" + timer.DbgInfo + ") - Params:\n");
					error("[Left4Timers][ERROR] {\n");
					foreach (k, v in timer.params)
					{
						if (typeof v == "table")
							error("[Left4Timers][ERROR]   " + k + " = (table)\n");
						else if (typeof v == "array")
							error("[Left4Timers][ERROR]   " + k + " = (array)\n");
						else
							error("[Left4Timers][ERROR]   " + k + " = " + v + "\n");
					}
					error("[Left4Timers][ERROR] }\n");
				}
			}
		}
		
		return 0.01;
	}
	
	::Left4Timers.AddThinker <- function(name, delay, func, params = {})
	{
		if (!name || name == "")
			name = UniqueString();
		else if (name in ::Left4Timers.Thinkers)
		{
			error("[Left4Timers][WARN] AddThinker - A thinker with this name already exists: " + name + "\n");
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
		
		local thinkerEnt = SpawnEntityFromTable("info_target", { targetname = "left4timers_" + name });
		if (!thinkerEnt || !thinkerEnt.IsValid())
		{
			error("[Left4Timers][ERROR] Failed to spawn thinker entity for thinker '" + name + "'!\n");
			return false;
		}
		
		thinkerEnt.ValidateScriptScope();
		local scope = thinkerEnt.GetScriptScope();
		scope.ThinkerName <- name;
		scope.ThinkerDelay <- delay;
		scope.ThinkerFunc <- func;
		scope.ThinkerParams <- params;
		scope.ThinkerDbgInfo <- dbgInfo;
		scope["ThinkerThinkFunc"] <- ::Left4Timers.ThinkerThinkFunc;
		AddThinkToEnt(thinkerEnt, "ThinkerThinkFunc");
			
		local thinker = { Delay = delay, Func = func, params = params, Ent = thinkerEnt, DbgInfo = dbgInfo };
		::Left4Timers.Thinkers[name] <- thinker;
		
		return true;
	}
	
	::Left4Timers.RemoveThinker <- function(name)
	{
		if (!(name in ::Left4Timers.Thinkers))
		{
			//error("[Left4Timers][WARN] RemoveThinker - A thinker with this name does not exist: " + name + "\n");
			return false;
		}
		
		local thinkerEnt = ::Left4Timers.Thinkers[name].Ent;
		if (thinkerEnt && thinkerEnt.IsValid())
			thinkerEnt.Kill();
		else
			error("[Left4Timers][WARN] RemoveThinker - Thinker '" + name + "' had no valid entity\n");
		
		delete ::Left4Timers.Thinkers[name];
		
		return true;
	}
	
	::Left4Timers.ThinkerThinkFunc <- function()
	{
		try
		{
			ThinkerFunc(ThinkerParams);
		}
		catch(exception)
		{
			error("[Left4Timers][ERROR] Exception in thinker '" + ThinkerName + "': " + exception + " (" + ThinkerDbgInfo + ")\n");
		}
		
		return ThinkerDelay;
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
