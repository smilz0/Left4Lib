//------------------------------------------------------
//     Author : smilzo
//     https://steamcommunity.com/id/smilz0
//------------------------------------------------------
/*
	Allows your script to receive the game concepts.
	
	NOTE: ::ConceptsHub isn't available until another addon includes this script.
	
	To use add:
		IncludeScript("left4lib_concepts");
	on top of your script.
	
	Then:
		ConceptsHub.SetHandler(key, yourfunction);
	to register an handler identified by 'key' and 'yourfunction' as function.
	You can do this in the 'OnGameEvent_round_start' event for example (or anywhere else).
	
	Stop receiving concepts by unregistering your handler with:
		ConceptsHub.RemoveHandler(key);
	
	Your handler's 'key' must be an unique key that identifies your addon/script (for example i use 'L4F' in Left 4 Fun, 'L4B' in Left 4 Bots and so on).
	
	Handler's function should look like this:
		::YourOnConcept <- function (concept, query)
		{
			// concept is the plain concept name (for example: PlayerEmphaticGo)
			// query is a table with the full concept's query
		}
*/

IncludeScript("rulescript_base");
IncludeScript("left4lib_consts");

if (!("ConceptsHub" in getroottable()))
{
	::ConceptsHub <-
	{
		Handlers = {}
	}

	class ::ConceptsHub.GroupParams
	{
		constructor(parms = {})
		{
			if ("permitrepeats" in parms && parms.permitrepeats)
				permitrepeats = true;
			if ("sequential" in parms && parms.sequential)
				sequential = true;
			if ("norepeat" in parms && parms.norepeat)
				norepeat = true;
			if ("matchonce" in parms && parms.matchonce)
				matchonce = true;
		}
		permitrepeats = true;
		sequential = false;
		norepeat = false;
		matchonce = false;
	}

	::ConceptsHub.SetHandler <- function (key, func)
	{
		::ConceptsHub.Handlers[key] <- func;
	}
	
	::ConceptsHub.RemoveHandler <- function (key)
	{
		if (key in ::ConceptsHub.Handlers)
			delete ::ConceptsHub.Handlers[key];
	}
	
	::ConceptsHub.ConceptFunc <- function (query)
	{
		local concept = "";
		foreach(key, val in query)
		{
			if (key.tolower() == "concept")
			{
				concept = val == null ? null : val.tostring();
				break;
			}
		}
		
		foreach (key, func in ::ConceptsHub.Handlers)
		{
			try
			{
				func(concept, query);
			}
			catch(exception)
			{
				error("[ConceptsHub][ERROR] Exception in handler '" + key + "': " + exception + "\n");
			}
		}
		
		return false;
	}
	
	local criterion = [ CriterionFunc("ConceptsHub", ConceptsHub.ConceptFunc) ];
	local responses = [ { scenename = "" } ];
	local group_params = ConceptsHub.GroupParams({ permitrepeats = true, sequential = false, norepeat = false, matchonce = false });

	local rule = RRule("ConceptsHub", criterion, responses, group_params);

	//if (Decider.AddRule(rule))
	if (rr_AddDecisionRule(rule))
		printl("[ConceptsHub][INFO] ConceptsHub created");
	else
		error("[ConceptsHub][ERROR] Failed to add decision rule!!!\n");
}
