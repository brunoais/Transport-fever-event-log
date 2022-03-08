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

local event_report = modules.tryRequire("event_report")


local state = {
	guiQueue = {}
}


local function errorInCall(msg)
	print("Error happened trying to call", toString(msg))
end


local script = {
	save = function()
		return state
	end,
	load = function(data)
		if data then
			state.use = data.use or false
			state.spacing = data.spacing
			state.nTracks = data.nTracks
		end
		return state
	end,
	handleEvent = function(src, id, name, param)
		xpcall(event_report.handleEvent, errorInCall, src, id, name, param)
	end,
	guiUpdate = function()
		for _, fn in ipairs(state.guiQueue) do fn() end
		state.guiQueue = {}
	end,
	guiHandleEvent = function(src, name, param)
		xpcall(event_report.guiHandleEvent, errorInCall, src, name, param)
	end
}


-- function data()
return script
-- end
