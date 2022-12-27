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

local modules = require "lib.brunoais.modules"

local MAIN_MODULE = "event_log"

local mainLoaded = modules.tryRequire(MAIN_MODULE)

modules.defaultAllReload()

local backupSave = {
	data = {
		count = 0,
	}
}

local script = {
	handleEvent = function(src, id, name, param)
		return mainLoaded and mainLoaded.handleEvent(src, id, name, param)
	end,
	save = function()
		backupSave.data.count = backupSave.data.count + 1
		return (mainLoaded and mainLoaded.save()) or backupSave.data
	end,
	load = function(data)
		backupSave = {
			data = data or backupSave.data
		}
		backupSave.data.count = backupSave.data.count or 0
		return mainLoaded and mainLoaded.load(data)
	end,
	guiUpdate = function()
		return mainLoaded and mainLoaded.guiUpdate()
	end,
	guiHandleEvent = function(src, name, param)
		-- Reload when user opens the game menu
		local doreload = src == "ingameMenu.quitButton" and name == "visibilityChange"
		if doreload or not mainLoaded then
			mainLoaded = modules.tryRequire(MAIN_MODULE)
		end
		if mainLoaded then
			mainLoaded.guiHandleEvent(src, name, param)
		end

	end
}

function data()
	print("Eventlog request for data")
	return script
end
