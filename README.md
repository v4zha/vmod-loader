# Vazha Mod Loader

**Vazha Mod Loader** 
is a module bundler to bundle neovim config files written in lua<br>
Vazha Mod Loader provides a fast bundler which looks for modules descibed in the configuration file and bundles all the modules with path namespace in a single lua script.

<br><br>
![v4zha](assets/v_mod.png)

![vmod](assets/v_mod1.png)


## Current Features
  
- Provides Configuration file to change config and rebundle.<br>

- Provides custom config path with the optional --cfg flag .

<br>

**Eg:**

 ```bash
  #Displays Vmod version

    vmod -v

    vmod --version
 ```

 ```bash
  #Reads config file

    vmod --cfg ./v4zha.yml
    
    vmod -f ./v4zha.yml
 ```

- Default config location ~/.config/vmod/vmod.yml
- required config fields 

```yml
     #Path where Neovim lua modules are located
     #Eg : ~/.config/nvim/lua/v4zha
     mod_path: 
       ~/.config/nvim/lua/v4zha
     #PATH to the New module_bundled lua script 
     res_file: 
       ~/.config/nvim/init.lua
     #List the modules
     #Eg : 
     modules : 
       - general
       - plugins
       - plugin_config
       # reads the mod_path for lua scripts : )
       - .
```
<br>

## Installation
- Download from [releases](https://github.com/v4zha/vmod-loader/releases)<br>

## Build   
- Requires cabal,ghc and necessary build tools.
- Configure cabal build using cabal. configure 

```bash
  cabal build
```
to run the binary with arguments in cabal

```bash
  cabal run vmod -- --cfg /location/to/config.yml
  cabal run vmod -- -f /location/to/config.yml```