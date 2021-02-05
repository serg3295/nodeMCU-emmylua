<h1>Emmy Lua annotations for NodeMCU ESP8266 & ESP32.</h1>

for Auto Completion of nodemcu functions

<img src="https://github.com/serg3295/nodeMCU-emmy/blob/main/images/nodemcu_emmy1.gif" style="max-width:100%;">


Works with VS Code extension **[Sumneko lua-language-server](https://github.com/sumneko/lua-language-server)**

<h2>Install</h2>

Set path to the file **nodemcu_emmy_32.lua**, or **nodemcu_emmy.lua** in parameter:

```json
"Lua.workspace.library": {
    "c:/users/..../": true
}
```

Declarations can also be placed in workspace subdirectory

Important!

**nodemcu_emmy_32.lua** and **nodemcu_emmy.lua** files must be located in different folders.

To perform the autocomplete of the ucg and u8g2 functions, place the **plugin.lua** file in any directory
 and specify the path to this file in the parameter

```json
 "Lua.runtime.plugin": "c:/PATH/plugin.lua"
```
