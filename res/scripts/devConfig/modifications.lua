
--[[--


Edit these tables to your liking
With this tables, you can control what you want to see logged
These tables are searched in order of parameters
Set the value to a function to more fine grain control what data to be shown
You may use a function to do a more fine-grain filter process for cases the tables are too large
Function must return either types:
To ignore: boolean
To replace: string or table


After doing changes to this file, you need to reload these settings.
To reload the settings, just open the in game menu by pressing the button on the top right (which opens the menu with the exit button).
At this point, it's reloaded, you can now leave the menu.

]]


local eventSrcIdName = {}



local guiSrcName = {
	[true] = {
		["builder.apply"] = function(src, id, name, param)
			return "{ ... }"
		end,
	},
}



return {
	eventSrcIdName = eventSrcIdName,
	guiSrcName = guiSrcName,
}
