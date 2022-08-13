# Vazha Mod Loader

**Vazha Mod Loader** 
is a module bundler to bundle neovim config files written in lua<br>
Vazha Mod Loader provides a fast bundler which looks for modules descibed in the configuration file and bundles all the modules with path namespace in a single lua script.

<br><br>
![v4zha](assets/v_mod.png)

## Current Features
  
- Provides Configuration file to change config and rebundle.<br>

## Todo 

- Provide custom config path , as of now the config file should be in the same dir as the binary and should have file name of `config.yml` .
 <br>

## Installation
- Download from release<br>

## Build   
- Requires cabal,ghc and necessary build tools.
- Configure cabal build using cabal. configure 
```bash
  cabal build
```
