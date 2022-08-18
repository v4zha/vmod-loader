{-# LANGUAGE BlockArguments #-}

module Main where

import Control.Exception (try)
import Data.Maybe (fromJust)
import System.Directory (getHomeDirectory)
import Vbanner (vModBanner)
import Vloader
  ( ModConfig (ModConfig, mod_path, modules, res_file),
    fromMaybeConfig,
    fromMaybeMod,
    getConfig,
    getMods,
    sanitizePath,
    writeMods,
  )

main :: IO ()
main = do
  putStrLn vModBanner
  home <- getHomeDirectory
  mod_ls <- sanitizePath <$> getConfig (home ++ "/.vmod/vmod.yml")
  let mod_conf = fromMaybeConfig mod_ls
  putStrLn "[*] : Getting Modules : "
  mapM_ (putStrLn . ("   >> " ++)) . modules $mod_conf
  lua_mods <- mapM (getMods $mod_path mod_conf) . modules $mod_conf
  putStrLn $ "[*] : Writing to file : " ++ res_file mod_conf ++ ".lua"
  writeMods lua_mods $res_file mod_conf