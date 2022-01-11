//------------------------------------------------------
//     Author : smilzo
//     https://steamcommunity.com/id/smilz0
//------------------------------------------------------

IncludeScript("rulescript_base");

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
		permitrepeats = false;
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
		foreach (key, func in ::ConceptsHub.Handlers)
		{
			try
			{
				func(query.concept, query);
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
	local group_params = ConceptsHub.GroupParams({ permitrepeats = false, sequential = false, norepeat = false, matchonce = false });

	local rule = RRule("ConceptsHub", criterion, responses, group_params);

	//if (Decider.AddRule(rule))
	if (rr_AddDecisionRule(rule))
		printl("[ConceptsHub][INFO] ConceptsHub created");
	else
		error("[ConceptsHub][ERROR] Failed to add decision rule!!!\n");
}



