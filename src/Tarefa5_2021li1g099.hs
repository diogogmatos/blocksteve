{- |
Module      : Tarefa5_2021li1gXXX
Description : Aplicação Gráfica

Módulo para a realização da Tarefa 5 do projeto de LI1 em 2021/22.
-}

module Main where

import LI12122
import Tarefa2_2021li1g099
import Tarefa4_2021li1g099
import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import Graphics.Gloss.Data.Bitmap

type EstadoJogo = (Jogo, Texturas)
type Texturas = (Picture, Picture, Picture, Picture, Picture)

main = do
    bloco <- loadBMP "brick.bmp"
    caixa <- loadBMP "block.bmp"
    door <- loadBMP "door.bmp"
    dudeE <- loadBMP "dudeRight.bmp"
    dudeO <- loadBMP "dudeLeft.bmp"
    play janela white fr (estadoGloss (bloco, caixa, door, dudeE, dudeO)) worldToPicture reageEvento (\_ e -> e)

janela = FullScreen
fr = 60

reageEvento :: Event -> EstadoJogo -> EstadoJogo
reageEvento (EventKey (SpecialKey KeyLeft) Down _ _) (j, t) = (moveJogador j AndarEsquerda, t)
reageEvento (EventKey (SpecialKey KeyRight) Down _ _) (j, t) = (moveJogador j AndarDireita, t)
reageEvento (EventKey (SpecialKey KeyUp) Down _ _) (j, t) = (moveJogador j Trepar, t)
reageEvento (EventKey (SpecialKey KeyDown) Down _ _) (j, t) = (moveJogador j InterageCaixa, t)
reageEvento _ j = j

estadoGloss :: Texturas -> EstadoJogo
estadoGloss (bloco, caixa, door, dudeE, dudeO) = (world, (bloco, caixa, door, dudeE, dudeO))

world :: Jogo
world = Jogo [[Vazio,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],
              [Vazio,Bloco,Vazio,Vazio,Vazio,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Vazio],
              [Bloco,Vazio,Bloco,Vazio,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco],
              [Bloco,Vazio,Vazio,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco],
              [Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Caixa,Bloco],
              [Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Caixa,Caixa,Bloco],
              [Bloco,Vazio,Bloco,Bloco,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco,Caixa,Vazio,Bloco,Bloco,Vazio],
              [Bloco,Vazio,Bloco,Vazio,Bloco,Vazio,Vazio,Vazio,Vazio,Bloco,Vazio,Vazio,Bloco,Bloco,Bloco,Bloco,Bloco,Vazio,Vazio],
              [Bloco,Vazio,Bloco,Vazio,Bloco,Caixa,Caixa,Vazio,Bloco,Bloco,Vazio,Vazio,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],
              [Bloco,Porta,Bloco,Vazio,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Vazio,Bloco,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],
              [Bloco,Bloco,Bloco,Vazio,Bloco,Bloco,Vazio,Vazio,Vazio,Bloco,Bloco,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio]]
             (Jogador (3,5) Oeste True)

--

worldToPicture :: EstadoJogo -> Picture
worldToPicture ((Jogo m j@(Jogador (x,y) d b)), t) = mapToPicture (desconstroiMapa m) j t

mapToPicture :: [(Peca,Coordenadas)] -> Jogador -> Texturas -> Picture
mapToPicture m j t = Translate (fromIntegral (-450)) (fromIntegral 300) $ Pictures (jogadorCaixa j t ++ pecasToPicture m t)

jogadorCaixa :: Jogador -> Texturas -> [Picture]
jogadorCaixa (Jogador (c,l) d b) (bloco, caixa, door, dudeE, dudeO) | d == Este && b == True = [jEste, Translate (fromIntegral x) (fromIntegral y+50) caixa]
                                                                    | d == Oeste && b == True = [jOeste, Translate (fromIntegral x) (fromIntegral y+50) caixa]
                                                                    | d == Este = [jEste]
                                                                    | d == Oeste = [jOeste]
                                                                    where (x,y) = converteCoordenada (c,l)
                                                                          jEste = Translate (fromIntegral x) (fromIntegral y) dudeE
                                                                          jOeste = Translate (fromIntegral x) (fromIntegral y) dudeO

--

pecasToPicture :: [(Peca,Coordenadas)] -> Texturas -> [Picture]
pecasToPicture [] _ = []
pecasToPicture (x:xs) t = pecaToPicture x t : pecasToPicture xs t

pecaToPicture :: (Peca,Coordenadas) -> Texturas -> Picture
pecaToPicture (p,(c,l)) (bloco, caixa, door, dudeE, dudeO) | p == Bloco = Translate (fromIntegral x) (fromIntegral y) bloco
                                                           | p == Caixa = Translate (fromIntegral x) (fromIntegral y) caixa
                                                           | p == Porta = Translate (fromIntegral x) (fromIntegral y) door
                                                           where (x,y) = converteCoordenada (c,l)
--

converteCoordenada :: (Int,Int) -> (Int,Int)
converteCoordenada (x,y) = (x*50,(-y)*50)