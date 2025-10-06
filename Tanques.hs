{-# LANGUAGE OverloadedStrings #-}

import Web.Scotty
import Data.Aeson (ToJSON, object, (.=))
import System.Random (randomRIO)
import Control.Monad.IO.Class (liftIO)

data Tanque = Tanque
  { nome    :: String
  , nacao   :: String
  , calibre :: String
  } deriving (Show)

instance ToJSON Tanque

baseDeTanques :: [Tanque]
baseDeTanques =
  [ Tanque "Tiger I" "Alemanha" "88mm"
  , Tanque "T-34" "União Soviética" "76.2mm"
  , Tanque "M4 Sherman" "Estados Unidos" "75mm"
  , Tanque "Churchill" "Reino Unido" "57mm"
  , Tanque "Panzer IV" "Alemanha" "75mm"
  , Tanque "IS-2" "União Soviética" "122mm"
  , Tanque "Panther A" "Alemanha" "88mm"
  , Tanque "SU-100" "União Soviética" "100mm"
  ]

getElementoAleatorio :: [a] -> IO a
getElementoAleatorio xs = do
  indice <- randomRIO (0, length xs - 1)
  return $ xs !! indice

getTanqueAleatorio :: IO Tanque
getTanqueAleatorio = getElementoAleatorio baseDeTanques

main :: IO ()
main = scotty 3000 $ do
  get "/tanque" $ do
    tanque <- liftIO getTanqueAleatorio
    json tanque