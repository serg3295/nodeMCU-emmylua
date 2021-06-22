# Emmy Lua annotations for NodeMCU ESP8266 & ESP32.

NodeMCU function annotations for autocomplete in
- Visual Studio Code
- Neovim
- IntelliJ IDEA
- ZeroBrane Studio

<img src="./images/nodemcu_emmy1.gif" style="max-width:100%;">

<img src="./images/nodemcu_emmy2.gif" style="max-width:100%;">

## Install

### VS Code and Neovim

If you use VSCode or Neovim, then you have to first install **[sumneko lua-language-server](https://github.com/sumneko/lua-language-server)** extension.

Then create directories and copy files from this repository into them as shown in the example below.<br>
*Note*. Files for esp32 and for esp8266 must be located in different directories.

Here is an example of a directory structure:
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

You will need to convert files from the sumneko format to the IDEA format by running **sumn2idea.lua** script from the `tools` directory.

### ZeroBrane Studio

To get auto-complete functions in **[ZeroBrane Studio](https://studio.zerobrane.com/)** you have to convert the NodeMCU API descriptions to ZeroBrane Studio format by running **sumn2zbs.lua** script.

The script requires ZeroBrane Studio already installed to run.

1. copy script `sumn2zbs.lua` to `ZBS/api/lua` folder

2. copy `esp8266` and `esp32` folders with module.lua files to `ZBS/api/lua` folder

  *Note*.
  'bme280_c_module.lua' is deprecated. You must delete this file from `esp8266` folder
  before converting, otherwise, the conversion will fail with an error.
  If you want to use bme280 C module instead of Lua module bme280.lua you could add lines

  ```lua

  ---@class bme280
  bme280 = {}

  ```
  in file 'bme280_c_module.lua' and delete file 'bme280.lua'.

3. run as "../../bin/lua sumn2zbs.lua "srcDir" >outputFile.lua" from `ZBS/api/lua` folder. If no "srcDir" is given, script uses ./esp8266 directory;

  `lua sumn2zbs.lua >nodemcu.lua`

   otherwise, the argument is directory's name and script uses ./"arg" directory.

  `lua sumn2zbs.lua esp32 >nodemcu32.lua`

4. launch the IDE with setting -> `api = {'nodemcu'}` or `api = {'nodemcu32'}` to confirm it's loading without issues.

<img src="./images/zbs.png" style="max-width:100%;">
