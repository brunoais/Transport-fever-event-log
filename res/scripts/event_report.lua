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

modules.tryRequire("lib.brunoais.extensions.string")
local blacklists = modules.tryRequire("devConfig.blacklists")
local modifications = modules.tryRequire("devConfig.modifications")



local function hierarchyEvaluate(bl, tests)

	local blLevel = bl
	for _, value in ipairs(tests) do
		local splitted = string.split(value, ".")


		-- print(value, toString(splitted), join('.', splitted[1], splitted[2]) .. '.')
		blLevel = blLevel[value] or blLevel[splitted[1] .. '.'] or blLevel[string.join('.', splitted[1], splitted[2]) .. '.'] or blLevel[true]
		if blLevel == nil then
			return false
		elseif type(blLevel) == "function" then
			return blLevel(table.unpack(tests))
		elseif type(blLevel) == "boolean" then
			return blLevel
		end
	end

end


local function handleEvent(src, id, name, param)
	if hierarchyEvaluate(blacklists.eventSrcIdName, {src, id, name, param}) then
		return
	end

	local logParam = hierarchyEvaluate(modifications.eventSrcIdName, {src, id, name, param})

	if type(logParam) == "boolean" or logParam == nil then
		logParam = param
	end


	print("")
	print("-------- EVENT ------------")
	print("src: ", src)
	print("id: ", id)
	print("name: ", name)
	print("param: ", toString(logParam))
	print("-------- /EVENT ------------")
	print("")

end



local function guiHandleEvent(src, name, param)
	if hierarchyEvaluate(blacklists.guiSrcName, {src, name, param}) then
		return
	end

	local logParam = hierarchyEvaluate(modifications.guiSrcName, {src, name, param})

	if type(logParam) == "boolean" or logParam == nil then
		logParam = param
	end



	-- local logParam = param
	-- if name == "builder.apply" then
	-- 	logParam = "{ ... }"
	-- end

	print("")
	print("-------- GUI EVENT ------------")
	print("src: ", src)
	print("name: ", name)
	print("param: ", toString(logParam))
	print("-------- /GUI EVENT ------------")
	print("")


end

return {
	handleEvent = handleEvent,
	guiHandleEvent = guiHandleEvent,
}
