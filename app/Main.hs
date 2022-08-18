{-# LANGUAGE BlockArguments #-}

module Main where

import Control.Exception (try)
import Data.Maybe (fromJust)
import Options.Applicative (execParser)
import Vbanner (vModBanner)
import Vloader
  ( Config (conf_file),
    ModConfig (ModConfig, mod_path, modules, res_file),
    fromMaybeConfig,
    fromMaybeMod,
    getConfig,
    getMods,
    getOpts,
    sanitizePath,
    writeMods,
  )

main :: IO ()
main = greeter =<< execParser opts
  where
    opts = getOpts
    greeter :: Config -> IO ()
    greeter config =
      do
        putStrLn vModBanner
        mod_ls <- sanitizePath <$> getConfig (conf_file config)
        let mod_conf = fromMaybeConfig mod_ls
        putStrLn "[*] : Getting Modules : "
        mapM_ (putStrLn . ("   >> " ++)) . modules $mod_conf
        lua_mods <- mapM (getMods $mod_path mod_conf) . modules $mod_conf
        putStrLn $ "[*] : Writing to file : " ++ res_file mod_conf ++ ".lua"
        writeMods lua_mods $res_file mod_conf