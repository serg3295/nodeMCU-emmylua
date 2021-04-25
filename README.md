# Emmy Lua annotations for NodeMCU ESP8266 & ESP32.

NodeMCU function annotations for autocomplete in Visual Studio Code, Neovim and IntelliJ IDEA

<img src="./images/nodemcu_emmy1.gif" style="max-width:100%;">


<img src="./images/nodemcu_emmy2.gif" style="max-width:100%;">

## Install

### VS Code and Neovim

If you use VSCode or Neovim, then you have to first install **[sumneko lua-language-server](https://github.com/sumneko/lua-language-server)** extension.

Then create directories and put files from this repository into them as shown in the example below.<br>
Note. Files for esp32 and for esp8266 must be located in different directories.

This is an example of a directory structure:
```
nodeMCU
| plugin.lua  # script
|
|___esp32
|   | *.lua   # files with functions definitions for esp32 (e.g. nodemcu_emmy_32.lua)
|
|___esp8266
    | *.lua   # files with functions definitions for esp8266  (e.g. nodemcu_emmy.lua)
```

The **sumneko.Lua** extension provides a number of parameters that are stored in .vscode/settings.json.

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

### IntelliJ IDEA

You have to install the **[IntelliJ-EmmyLua ](https://github.com/EmmyLua/IntelliJ-EmmyLua)** plugin. The auto-completion capabilities of this plugin differ from those of the sumneko extension. Therefore, some of the advanced features will not be supported.

You will need to convert files from the sumneko format to the IDEA format by running a script **sumn2idea.lua** from the `tools` directory.
