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

local event_report = modules.tryRequire("event_report")


local state = {
	count = 0,
}


local function errorInCall(msg)
	print("Error happened trying to call", toString(msg))
end



local waiting = 80


local function adocUpdate()

	waiting = waiting - 1
	if waiting == 0 then
		-- waiting = 100
		-- print("eventlog working")

	end
end


local script = {
	save = function()
		state.count = state.count + 1
		return state
	end,
	load = function(data)
		if data then
			state.count = data.count or state.count
		end
	end,
	handleEvent = function(src, id, name, param)
		xpcall(event_report.handleEvent, errorInCall, src, id, name, param)
	end,
	guiUpdate = function()
		xpcall(adocUpdate, errorInCall)
	end,
	guiHandleEvent = function(src, name, param)
		xpcall(event_report.guiHandleEvent, errorInCall, src, name, param)
	end
}


-- function data()
return script
-- end
