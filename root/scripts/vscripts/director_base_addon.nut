if ("L4LSecondRun" in getroottable())
{
	printl("[L4L] Second Run");
	
	if ("HooksHub" in getroottable())
	{
		::HooksHub.Init();
		::HooksHub.DbgPrintFuncs();
		
		delete ::L4LSecondRun;
	}
}
else
{
	printl("[L4L] First Run");
	::L4LSecondRun <- 1;
}

