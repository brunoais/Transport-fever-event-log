# Game events logger for Transport Fever 2

This transport fever mod logs to console all events that happen in game, limited by its blocklist.

The file `stdout.txt` should be found at `[userdata]/crash_dump/stdout.txt`

# Installation

## Option 1: Steam workshop


## Option 2: Manual

#### Download the files

If you don't know how, you can download the files by:

1. Press the green "Code" button
2. Press "Download Zip"
3. Unzip to a directory of your choice
4. Copy the unzipped files to the directory explained in the next section


### Place the files in the right place

Copy the files from the mod to inside `[userdata]/mods/transport_fever_event_log_1`. If the directory doesn't exist, create it.

To know where `[userdata]` is located, you can find that through:

* Inside TF2 game ->
* "settings" menu ->
* "Advanced" tab ->
* "OPEN USERDATA FOLDER" button

It will open your file explorer with the relevant userdata directory


If in `[userdata]/mods/transport_fever_event_log_1` there's the files `mod.lua` and `strings.lua`, then the copy is successful.
Otherwise, you may need to move the contents of the only directory there (possibly called `brunoais_Transport-fever-event-log`) out of the directory and try again.

# Settings

This mod doesn't have in-game settings. Instead, the settings are represented in the files at `[userdata]/mods/transport_fever_event_log_1/res/scripts/devConfig/`

The explanation on how to edit them to your use are included as lua comments.  
Also, consider the files already included in this repo as examples.


# License

Code license is under a slightly modified Apache license 2.0. The slight modification legally binds you to give credit if you use the software.
