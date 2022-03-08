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


local descEN = [[
Prints events to console (and, by consequence, to stdout.txt).

The file `stdout.txt` should be found at `[userdata]/crash_dump/stdout.txt`.
`[userdata]` can be found ingame, in the: settings menu -> advanced (tab) -> "OPEN USERDATA FOLDER" (button)

Only useful for mod development purposes, to keep track of the available events for exploration purposes or analysis

Settings are available in the files at res/scripts/devConfig/
Documentation on how to use them is set as lua comments in themselves.

[hr][/hr]
[b]Open-source:[/b]
This mod is open-source. You can find the source code at https://github.com/brunoais/Transport-fever-event-log
If you are here but don't use steam, there's a README there explaining the mod.


[hr][/hr]

[b]Bug reporting / Feature requests[/b]

Due to how all notifications get jumbled up on steam and how I don't get notifications pushed to me from here in separate from all other notifications, I may miss if you post on this workshop item's discussion or comments. If that happens, feel free to contact me on github by issueing an issue at:

https://github.com/brunoais/Transport-fever-event-log/issues

[hr][/hr]
[b]Acknowledgements:[/b]
This product includes "module reload", developed by brunoais, available at https://github.com/brunoais/lua-module-reload.

Description image made using:
Settings icons created by Freepik - Flaticon
Clipboard icons created by Freepik - Flaticon

]]

function data()
    return {
        en = {
            MOD_NAME = "Event log",
            MOD_DESC = descEN,
        },
    }
end
