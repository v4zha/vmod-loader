module Main where

import Control.Exception (try)
import Data.Maybe (fromJust)
import Options.Applicative (execParser)
import System.Directory (getHomeDirectory)
import Text.Termcolor (format)
import qualified Text.Termcolor.Foreground as F
import Text.Termcolor.Style (bold)
import Vloader
  ( Config (allMod, confFile, quiet, version),
    ModConfig (ModConfig, modPath, modules, resFile),
    config,
    fromMaybeConfig,
    fromMaybeMod,
    getBanner,
    getConfig,
    getMods,
    getOpts,
    getReqMods,
    getVersion,
    replaceHome,
    sanitizeMod,
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
        getBanner $quiet config
        getVersion (version config) (quiet config)
        home <- getHomeDirectory
        modLs <- sanitizePath <$> getConfig (confFile config)
        let modConf = fromMaybeConfig modLs
            [res, modP] = replaceHome home <$> [resFile modConf, modPath modConf]
        putStrLn . format . bold . F.yellow . read $ "[*] : Getting Modules : "
        reqMods <- getReqMods (allMod config) modP (modules modConf)
        mapM_ (putStrLn . format . bold . F.cyan . read . ("   >> " ++) . fst . sanitizeMod "<.> ") reqMods
        luaMods <- mapM (getMods modP) reqMods
        putStrLn . format . bold . F.green . read $ "[*] : Writing to file : " ++ res ++ ".lua"
        writeMods luaMods res