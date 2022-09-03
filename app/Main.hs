module Main where

import Control.Exception (try)
import Data.Maybe (fromJust)
import Options.Applicative (execParser)
import System.Directory (getHomeDirectory)
import Text.Termcolor (format)
import qualified Text.Termcolor.Foreground as F
import Text.Termcolor.Style (bold)
import Vbanner (vModBanner)
import Vloader
  ( Config (confFile, version),
    ModConfig (ModConfig, modPath, modules, resFile),
    config,
    fromMaybeConfig,
    fromMaybeMod,
    getConfig,
    getMods,
    getOpts,
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
        putStrLn . format . bold $ read vModBanner
        getVersion $version config
        home <- getHomeDirectory
        modLs <- sanitizePath <$> getConfig (confFile config)
        let modConf = fromMaybeConfig modLs
        let [res, mods] = replaceHome home <$> [resFile modConf, modPath modConf]
        putStrLn . format . bold . F.yellow . read $ "[*] : Getting Modules : "
        mapM_ (putStrLn . format . bold . F.cyan . read . ("   >> " ++) . fst . sanitizeMod "<.> ") . modules $modConf
        luaMods <- mapM (getMods mods) . modules $modConf
        putStrLn . format . bold . F.green . read $ "[*] : Writing to file : " ++ res ++ ".lua"
        writeMods luaMods res