<h1>Emmy Lua annotations for NodeMCU ESP8266 & ESP32.</h1>

for Auto Completion of nodeMCU functions

<img src="https://github.com/serg3295/nodeMCU-emmy/blob/main/images/nodemcu_emmy1.gif" style="max-width:100%;">


<img src="https://github.com/serg3295/nodeMCU-emmy/blob/main/images/nodemcu_emmy2.gif" style="max-width:100%;">

Only works with VS Code extension **[sumneko lua-language-server](https://github.com/sumneko/lua-language-server)**

<h2>Install</h2>

Firstly install VS Code extension **sumneko.lua**

Then create directories and put files from this repository into them as shown in the example below.<br>
Note. Files for esp32 and for esp8266 must be located in different directories.

This is an example of a directory structure:
```
nodeMCU
|  plugin.lua  # script
|
|___esp32
|   | *.lua   # files with functions definitions for esp32 (e.g. nodemcu_emmy_32.lua)
|
|___esp8266
    | *.lua   # files with functions definitions for esp8266  (e.g. nodemcu_emmy.lua)
```

**sumneko.Lua** extension provides a number of parameters that are stored in .vscode/settings.json.

Now you have to set the path to the files with functions definitions for esp32 **OR** for esp8266 in the setting ```"Lua.workspace.library"```.
```json
"Lua.workspace.library": [
      "path"
    ]
```

To perform the autocomplete of the ucg and u8g2 functions, place the **plugin.lua** file in any directory
 and specify the path to this file in the setting:
```json
 "Lua.runtime.plugin": "PATH/plugin.lua"
```

The script **plugin.lua** is common for both projects.


<h2>Changes</h2>

Starting from version 1.18.0 of sumneko.lua extension, you have to use the ```"Lua.workspace.library": [ path ]``` instead of ```{path}: true```

```json
//now
"Lua.workspace.library": [
      "path"
    ]
```

```json
//instead of
"Lua.workspace.library": {
    "c:/users/..../": true
}
```
