{-# LANGUAGE OverloadedStrings #-}

module Main where

import System.Environment (getArgs)

import Data.String (fromString)
import qualified Network.Wai.Handler.Warp as Warp
import qualified Network.Wai as Wai
import qualified Network.Wai.Application.Static as Static
import Data.Maybe (fromJust)
import WaiAppStatic.Types (toPieces)

main :: IO ()
main = do
  host:port:root:_ <- getArgs
  Warp.runSettings (
    Warp.setHost (fromString host) $
    Warp.setPort (read port) $
    Warp.defaultSettings
    ) $ staticApp root

staticApp :: String -> Wai.Application
staticApp root = Static.staticApp $ settings { Static.ssIndices = indices }
  where
    settings = Static.defaultWebAppSettings root
    indices = fromJust $ toPieces ["main.html"] -- default content
