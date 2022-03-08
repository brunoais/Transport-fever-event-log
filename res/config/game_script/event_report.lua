--[[--
	Copyright 2022 brunoais

	Licensed under the Apache License with acknowledgement, Version 1.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

		https://github.com/brunoais/Transport-fever-event-log/blob/master/License

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.
]]

require "serialize"

local modules = require "utils.modules"

local MAIN_MODULE = "main"

local mainLoaded = modules.tryRequire(MAIN_MODULE)

modules.defaultAllReload()


local script = {
	handleEvent = function(src, id, name, param)
		return mainLoaded.handleEvent(src, id, name, param)
	end,
	save = function()
		return mainLoaded.save()
	end,
	load = function(data)
		return mainLoaded.load(data)
	end,
	guiUpdate = function()
		return mainLoaded.guiUpdate()
	end,
	guiHandleEvent = function(src, name, param)
		-- Reload when user opens the game menu
		local doreload = src == "ingameMenu.quitButton" and name == "visibilityChange"
		if doreload then
			mainLoaded = modules.tryRequire(MAIN_MODULE)
		end

		mainLoaded.guiHandleEvent(src, name, param)

	end
}

function data()
	print("Eventlog request for data")
	return script
end
