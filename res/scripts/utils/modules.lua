--[[--
	Copyright 2022 brunoais

	Licensed under the Apache License with acknowledgement, Version 1.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

		https://github.com/brunoais/lua-module-reload/blob/master/License

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.
]]

local modules = {}


modules.alwaysReload = {}
modules.lastImportResult = nil
modules.lastImportResultEnum = {
	LOADED = "LOADED",
	RELOADED = "RELOADED",
	FAIL_RECOVER = "FAIL_RECOVER",
	FAIL = "FAIL",
}
--[[--
Assign a function to receive a callback for every try to load. For example, for logging purposes

@param moduleName the name of the module requested to load
@param status One of `modules.lastImportResultEnum` based on the result
@param success Whether the next param has the module or an error message (equivalent to the first return of pcall)
@param moduleOrMessage the module or the error message when trying to require
]]
modules.loadingCallback = function (moduleName, status, success, moduleOrMessage) end


local function tryLoad(moduleName, reload)

	local previousVersion = package.loaded[moduleName]

	-- reload == false # NO!!
	-- reload == nil # modules.alwaysReload[moduleName]
	-- reload == true # YES

	modules.lastImportInfo = modules.lastImportResultEnum.LOADED
	if 		reload ~= false and
			(reload or modules.alwaysReload[moduleName])
		then
		modules.lastImportInfo = modules.lastImportResultEnum.RELOADED
		print("reloading", moduleName)
		package.loaded[moduleName] = nil
	end

	local function errorInImport(msg)
		require "serialize"
		print("import error (", moduleName, "): ", msg)
		if previousVersion then
			package.loaded[moduleName] = previousVersion
			modules.lastImportInfo = modules.lastImportResultEnum.FAIL_RECOVER
		else
			print("No previous module found for", moduleName)
			modules.lastImportInfo = modules.lastImportResultEnum.FAIL
		end
		modules.loadingCallback(moduleName, modules.lastImportInfo, false, msg)
		return previousVersion
	end

	local function load(moduleName)
		local loaded = require(moduleName)
		modules.loadingCallback(moduleName, modules.lastImportInfo, true, loaded)
		return loaded
	end

	local status, loaded = xpcall(load, errorInImport, moduleName)

	return loaded

end

--[[--
Registers a module on whether it always reloads when it tries to reload.

In other words, it can turn all calls to `modules.tryLoad` into `modules.tryReload` without the
need to set that for every lua file, if you want dynamic decision.

@param moduleName the name of the module to load
]]
function modules.registerReload(moduleName, yesNo)
	modules.alwaysReload[moduleName] = yesNo
end


local allReloadMetatable = {
	__index = function(t, key)
		return true
	end,
}

local noneReloadMetatable = {
	__index = function(t, key)
		return false
	end,
}

--[[--
Sets so all modules reload by default

In other words, it turns all calls to `modules.tryRequire` that don't explicitely tell to reload to reload
You can override this default with `modules.registerReload`
]]
function modules.defaultAllReload()
	setmetatable(modules.alwaysReload, allReloadMetatable)
end

--[[--
Sets so no modules reload by default

In other words, it turns all calls to `modules.tryRequire` that don't explicitely tell to reload to reload
You can override this default with `modules.registerReload`
]]
function modules.defaultNoneReload()
	setmetatable(modules.alwaysReload, noneReloadMetatable)
end


--[[--
Tries to reload a module. Return the same if it fails

Tell Lua to assume the module was never loaded then:

1. Load a new version of it.
2. If the loading fails, return the previously loaded module.
3. If no previously loaded module exists, return Nil

If 2 or 3 happen, an error is printed explaining the problem.

Additionally, `modules.lastImportResult` is updated with one of modules.lastImportResultEnum depending on the execution.

@param moduleName the name of the module to load
@param reload (optional) true to reload, false for not reload and nil (defaul) for the default set by `modules.default*Reload`
@return The returning value of the module (usually a table). Can either be the old module or the newly loaded module
@raise if couldn't load the module
]]
function modules.tryRequire(moduleName, ...)
	return tryLoad(moduleName, ({...})[1] )
end


-- By default, no reloads but can be overritten by `modules.defaultAllReload`
modules.defaultNoneReload()

return modules
