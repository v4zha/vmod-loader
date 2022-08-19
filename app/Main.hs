{-# LANGUAGE BlockArguments #-}

module Main where

import Control.Exception (try)
import Data.Maybe (fromJust)
import Options.Applicative (execParser)
import System.Directory (getHomeDirectory)
import Vbanner (vModBanner)
import Vloader
  ( Config (conf_file),
    ModConfig (ModConfig, modPath, modules, resFile),
    fromMaybeConfig,
    fromMaybeMod,
    getConfig,
    getMods,
    getOpts,
    replaceHome,
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
        home <- getHomeDirectory
        modLs <- sanitizePath <$> getConfig (conf_file config)
        let modConf = fromMaybeConfig modLs
        let [res, mods] = replaceHome home <$> [resFile modConf, modPath modConf]
        putStrLn "[*] : Getting Modules : "
        mapM_ (putStrLn . ("   >> " ++)) . modules $modConf
        lua_mods <- mapM (getMods mods) . modules $modConf
        putStrLn $ "[*] : Writing to file : " ++ res ++ ".lua"
        writeMods lua_mods res