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
import Graphics.Gloss.Juicy (loadJuicy)

main = jogo

-- MENU --

data EstadoMenu = Menu Opcao Elementos Bool
    deriving Eq

data Opcao = Jogar
           | Sair
           deriving Eq

type Elementos = (Picture, Picture, Picture, Picture, Picture)

menu :: IO ()
menu = do
    Just title <- loadJuicy "title.png"
    Just jogartxt <- loadJuicy "jogar.png"
    Just jogartxts <- loadJuicy "jogars.png"
    Just sairtxt <- loadJuicy "sair.png"
    Just sairtxts <- loadJuicy "sairs.png"
    play janela corFundoM fr (Menu Jogar (title, jogartxt, jogartxts, sairtxt, sairtxts) False) drawMenu reageMenu (\_ e -> e)

fr = 60
janela = FullScreen

corFundoM :: Color
corFundoM = white

reageMenu :: Event -> EstadoMenu -> EstadoMenu
reageMenu (EventKey (SpecialKey KeyUp) Down _ _) (Menu o e s) | o == Jogar = Menu Sair e False
                                                              | otherwise = Menu Jogar e False
reageMenu (EventKey (SpecialKey KeyDown) Down _ _) (Menu o e s) | o == Jogar = Menu Sair e False
                                                                | otherwise = Menu Jogar e False
reageMenu (EventKey (SpecialKey KeyEnter) Down _ _) (Menu o e s) | o == Jogar = Menu Jogar e True
                                                                 | otherwise = undefined
reageMenu _ m = m

drawMenu :: EstadoMenu -> Picture
drawMenu (Menu o (title, jogartxt, jogartxts, sairtxt, sairtxts) s) =
    if o == Jogar then Pictures [Translate 0 300 title, jogartxts, Translate 0 (-200) sairtxt]
    else Pictures [Translate 0 300 title, jogartxt, Translate 0 (-200) sairtxts]

-- JOGO --

type EstadoJogo = (Jogo, Texturas)
type Texturas = (Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture)

jogo :: IO ()
jogo = do
    Just grass <- loadJuicy "grass.png"
    Just dirt <- loadJuicy "dirt.png"
    Just box <- loadJuicy "box.png"
    Just boxe <- loadJuicy "boxe.png"
    Just boxmiddle <- loadJuicy "boxmiddle.png"
    Just boxup <- loadJuicy "boxup.png"
    Just door <- loadJuicy "door.png"
    Just dudeE <- loadJuicy "dudeRight.png"
    Just dudeO <- loadJuicy "dudeLeft.png"
    play janela corFundoJ fr (estadoJogo (grass, dirt, box, boxe, boxmiddle, boxup, door, dudeE, dudeO)) worldToPicture reageJogo (\_ e -> e)

corFundoJ :: Color
corFundoJ = light black

estadoJogo :: Texturas -> EstadoJogo
estadoJogo (grass, dirt, box, boxe, boxmiddle, boxup, door, dudeE, dudeO) =
    (world, (grass, dirt, box, boxe, boxmiddle, boxup, door, dudeE, dudeO))

-- mapa --

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
             (Jogador (9,6) Oeste False)

-- worldToPicture --

worldToPicture :: EstadoJogo -> Picture
worldToPicture ((Jogo m j@(Jogador (x,y) d b)), t) = mapToPicture (desconstroiMapa m) j t

mapToPicture :: [(Peca,Coordenadas)] -> Jogador -> Texturas -> Picture
mapToPicture m j t = Translate (fromIntegral (-450)) (fromIntegral 300) $ Pictures (jogadorCaixa j t ++ pecasToPicture m m t)

jogadorCaixa :: Jogador -> Texturas -> [Picture]
jogadorCaixa (Jogador (c,l) d b) (grass, dirt, box, boxe, boxmiddle, boxup, door, dudeE, dudeO)
    | d == Este && b == True = [jEste, Translate (fromIntegral x) (fromIntegral y+64) box]
    | d == Oeste && b == True = [jOeste, Translate (fromIntegral x) (fromIntegral y+64) box]
    | d == Este = [jEste]
    | d == Oeste = [jOeste]
    where (x,y) = converteCoordenada (c,l)
          jEste = Translate (fromIntegral x) (fromIntegral y) dudeE
          jOeste = Translate (fromIntegral x) (fromIntegral y) dudeO

pecasToPicture :: [(Peca,Coordenadas)] -> [(Peca,Coordenadas)] -> Texturas -> [Picture]
pecasToPicture [] _ _ = []
pecasToPicture (x:xs) m t = pecaToPicture x t m : pecasToPicture xs m t

pecaToPicture :: (Peca,Coordenadas) -> Texturas -> [(Peca,Coordenadas)] -> Picture
pecaToPicture (p,(c,l)) (grass, dirt, box, boxe, boxmiddle, boxup, door, dudeE, dudeO) m
    | p == Bloco = if elem (Bloco,(c,l-1)) m then Translate (fromIntegral x) (fromIntegral y(elem (Caixa,(x-1,y+1)) m)) dirt else Translate (fromIntegral x) (fromIntegral y) grass
    | p == Caixa = if (elem (Caixa,(c,l+1)) m) && (elem (Caixa,(c,l-1)) m) then Translate (fromIntegral x) (fromIntegral y) boxmiddle
                   else if elem (Caixa,(c,l-1)) m then Translate (fromIntegral x) (fromIntegral y) boxe
                   else if elem (Caixa,(c,l+1)) m then Translate (fromIntegral x) (fromIntegral y) boxup
                   else Translate (fromIntegral x) (fromIntegral y) box
    | p == Porta = Translate (fromIntegral x) (fromIntegral y) door
    where (x,y) = converteCoordenada (c,l)

converteCoordenada :: (Int,Int) -> (Int,Int)
converteCoordenada (x,y) = (x*64,(-y)*64)

--

reageJogo :: Event -> EstadoJogo -> EstadoJogo
reageJogo (EventKey (SpecialKey KeyLeft) Down _ _) (j, t) = (moveJogador j AndarEsquerda, t)
reageJogo (EventKey (SpecialKey KeyRight) Down _ _) (j, t) = (moveJogador j AndarDireita, t)
reageJogo (EventKey (SpecialKey KeyUp) Down _ _) (j, t) = (moveJogador j Trepar, t)
reageJogo (EventKey (SpecialKey KeyDown) Down _ _) (j, t) = (moveJogador j InterageCaixa, t)
reageJogo (EventKey (SpecialKey KeySpace) Down _ _) (j, t) = (world, t)
reageJogo _ j = j