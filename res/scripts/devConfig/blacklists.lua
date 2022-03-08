
--[[--


Edit these tables to your liking
With this tables, you can control what you want to see logged
These tables are searched in order of parameters
Set the value to a function to more fine grain control on whether it's blacklisted
Set/Return the value to "true" (like most are) to filter out. A value of "false" will make the content appear


After doing changes to this file, you need to reload these settings.
To reload the settings, just open the in game menu by pressing the button on the top right (which opens the menu with the exit button).
At this point, it's reloaded, you can now leave the menu.

]]



local eventSrcIdName = {
	["guidesystem.lua"] = {
		["saveevent"] = true
	},
	[""] = {
		["SimCargoSystem"] = {
			["OnToArriveAtDestination"] = true
		},

		["__missionCallback__"] = {
			['JOURNAL_ENTRY'] = function(src, id, name, param)
				return param.type == 'VEHICLE_MAINTENANCE'
			end,
		},
	}
}



local guiSrcName = {
	["bulldozer"] = {
		["builder.proposalCreate"] = true
	},
	["gameInfo."] = true,
	["inGameConsole"] = {
		["visibilityChange"] = true
	},
	["ingameMenu."] = true,
	["ingameMenu"] = true,
	["mainMenuTopBar"] = true,
	["mainMenuBottomBar"] = true,
	["mainView"] = true,
	["menu."] = true,
	["menu.fileMenuButton"] = true,
	["menu.speedButton0"] = true,
	["menu.speedButton1"] = true,
	["menu.speedButton2"] = true,
	["menu.speedButton3"] = true,
	["menu.warningsButton"] = true,
	["constructionBuilder"] = {
		["builder.proposalCreate"] = true,
		["builder.rotate"] = true,
	},
	["trackBuilder"] = {
		["builder.proposalCreate"] = true
	},
	["tsbi.toolTipContainer.toolTip"] = true,
	["townhudicon"] = true,
	["toolTipContainer."] = true,
	["streetBuilder"] = {
		["builder.proposalCreate"] = true
	},
	["streetTerminalBuilder"] = {
		["builder.proposalCreate"] = true
	},
	["vehicleWindow."] = true,
	["vehicleStore.item.model.vehicle"] = {
		["destroy"] = true,
	},
	["vehicleStore."] = {
		["idadded"] = true,
		["visibilityChange"] = true,
	},
	["window."] = true,

	-- CommonAPI UI
	["XCoTPF2."] = true,
	["mainMenuLeft.CommonAPI2Button."] = true,
}



return {
	eventSrcIdName = eventSrcIdName,
	guiSrcName = guiSrcName,
}
