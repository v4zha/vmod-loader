import Test.Framework ()
import Test.Framework.Providers.HUnit ()
import Test.HUnit
import qualified Vloader as V

repHomeTest :: Test.HUnit.Test
repHomeTest = TestCase (assertEqual "Replace ~ " ("/home/v4zha/.config/vmod") (V.replaceHome "/home/v4zha" "~/.config/vmod"))

sanLuaTest :: Test.HUnit.Test
sanLuaTest = TestCase (assertEqual "Replace .lua" (Just "vazha") (V.sanitizeLua "vazha.lua"))

sanPathTest :: Test.HUnit.Test
sanPathTest = TestCase (assertEqual "Replace / in path End" (Just mockModRes) (V.sanitizePath mockMod))

mockMod :: V.ModConfig
mockMod = V.ModConfig "/vazha/" "./vmod.lua" ["plugin,vazha"]

mockModRes :: V.ModConfig
mockModRes = V.ModConfig "/vazha" "./vmod" ["plugin,vazha"]

sanModTestA :: Test.HUnit.Test
sanModTestA = TestCase (assertEqual "Replace modName with EmptyString and ModHeader to ModPrefix with tailing `.` removed if modName= '.' " (("v4zha", "")) (V.sanitizeMod "v4zha." "."))

sanModTestB :: Test.HUnit.Test
sanModTestB = TestCase (assertEqual "if modName/=`.` then the ModPrefix is ignored and ModName is returned with tailing `.`" (("plugin", "plugin.")) (V.sanitizeMod "v4zha." "plugin"))

modPrefixTest :: Test.HUnit.Test
modPrefixTest = TestCase (assertEqual "get Mod prefix by appending folders with `.` from lua folder path is till end for Neovim recognition" ("v4zha.modules.") (V.getModPrefix "/nvim/lua/v4zha/modules"))

modGenTest :: Test.HUnit.Test
modGenTest =
  TestCase
    ( assertEqual
        "Modules to be written in file "
        ("-- ==============================\n--    MOD : v4zha\n-- ==============================\nrequire(\"v4zha.keymap\")\nrequire(\"v4zha.config\")")
        (V.modGen "v4zha." "." ["keymap.lua", "config.lua", "info.txt"])
    )

main :: IO Counts
main = runTestTT (test [repHomeTest, sanLuaTest, sanPathTest, sanModTestA, sanModTestB, modPrefixTest, modGenTest])