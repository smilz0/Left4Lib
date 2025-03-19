//------------------------------------------------------
//     Author : smilzo
//     https://steamcommunity.com/id/smilz0
//------------------------------------------------------

Msg("Including left4lib_timers2...\n");

IncludeScript("left4lib_logger");

::Left4Timers2 <-
{
	Timers = {}
	
	GetTimer = function(name)
	{
		if (name in Timers)
			return Timers[name];
		return null;
	}
	
	AddTimer = function(name, ontimer_func, start_interval, repeat_interval)
	{
		Timers[name] <- Timer(name, ontimer_func, start_interval, repeat_interval);
		return Timers[name];
	}
	
	RemoveTimer = function(name)
	{
		if (!(name in Timers))
			return false;
		
		delete Timers[name];
	}
	
	Tick = function(name)
	{
		if (name in Timers)
			Timers[name].Tick();
	}
}

class ::Left4Timers2.Timer
{
	constructor(name, ontimer_func, start_interval = 1, repeat_interval = null)
	{
		_name = name;
		_ontimer_func = ontimer_func;
		_start_interval = start_interval;
		_repeat_interval = repeat_interval;
		_target_time = null;
		_ticks_waiting = 0;
	}
	
	function _typeof()
	{
		return "Left4Timers2.Timer";
	}
	
	function _tostring()
	{
		return typeof(this) + " { Name: " + _name + ", Start Interval: " + _start_interval + ", Repeat Interval: " + _repeat_interval + ", Target Time: " + _target_time + ", OnTimer Func: " + _ontimer_func;
	}
	
	_ontimer_func = null;
	_start_interval = 1;
	_repeat_interval = false;
	_name = null;
	_target_time = null;
	_ticks_waiting = 0;
	
	function Start()
	{
		if (this._target_time)
			return false; // Already started
		
		this._target_time = Time() + this._start_interval;
		if (this._ticks_waiting <= 0)
		{
			::Left4LibLogger.Debug("Left4Timers2 - DoEntFire");
			DoEntFire("worldspawn", "RunScriptCode", "::Left4Timers2.Tick(\"" + this._name + "\")", _start_interval, null, null);
			this._ticks_waiting++;
		}
	}
	
	function Stop()
	{
		if (!this._target_time)
			return false; // Already stopped
		
		this._target_time = null;
	}
	
	function Tick()
	{
		this._ticks_waiting--;
		if (!this._target_time)
			return; // Timer was stopped
		
		local remaining_time = this._target_time - Time();
		if (remaining_time > 0.03333)
		{
			::Left4LibLogger.Debug("Left4Timers2 - NOT YET " + this._target_time);
			if (this._ticks_waiting <= 0)
			{
				::Left4LibLogger.Debug("Left4Timers2 - DoEntFire");
				DoEntFire("worldspawn", "RunScriptCode", "::Left4Timers2.Tick(\"" + this._name + "\")", remaining_time, null, null);
				this._ticks_waiting++;
			}
			return;
		}
		
		::Left4LibLogger.Debug("Left4Timers2 - Tick -> " + this);
		::Left4LibLogger.Debug("Left4Timers2 - Ticks Waiting -> " + this._ticks_waiting);
		this._ontimer_func();
		
		if (this._repeat_interval)
		{
			this._target_time = Time() + this._repeat_interval;
			if (this._ticks_waiting <= 0)
			{
				::Left4LibLogger.Debug("Left4Timers2 - DoEntFire");
				DoEntFire("worldspawn", "RunScriptCode", "::Left4Timers2.Tick(\"" + this._name + "\")", _repeat_interval, null, null);
				this._ticks_waiting++;
			}
		}
	}
}
