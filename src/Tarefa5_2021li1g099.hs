{- |
Module      : Tarefa5_2021li1gXXX
Description : Aplicação Gráfica

Módulo para a realização da Tarefa 5 do projeto de LI1 em 2021/22.
-}

module Main where

import LI12122
import Tarefa1_2021li1g099
import Tarefa2_2021li1g099
import Tarefa4_2021li1g099
import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import Graphics.Gloss.Data.Bitmap
import Graphics.Gloss.Juicy (loadJuicy)

main = do
    Just p1 <- loadJuicy "title.png"
    Just p2 <- loadJuicy "jogar.png"
    Just p3 <- loadJuicy "jogars.png"
    Just p4 <- loadJuicy "sair.png"
    Just p5 <- loadJuicy "sairs.png"
    Just p6 <- loadJuicy "grass.png"
    Just p7 <- loadJuicy "dirt.png"
    Just p8 <- loadJuicy "box.png"
    Just p9 <- loadJuicy "boxe.png"
    Just p10 <- loadJuicy "boxmiddle.png"
    Just p11 <- loadJuicy "boxup.png"
    Just p12 <- loadJuicy "door.png"
    Just p13 <- loadJuicy "dudeRight.png"
    Just p14 <- loadJuicy "dudeLeft.png"
    play janela corFundo fr (estadoInicial (p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14)) draw reage (\_ e -> e)

fr = 60
janela = FullScreen

corFundo :: Color
corFundo = white

data Estado = E EstadoMenu EstadoJogo
type Texturas = (Picture, Picture, Picture, Picture, Picture, Picture, Picture,
                 Picture, Picture, Picture, Picture, Picture, Picture, Picture)

estadoInicial :: Texturas -> Estado
estadoInicial (p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14) =
    E (Menu Jogar (p1,p2,p3,p4,p5) False) (world, (p6,p7,p8,p9,p10,p11,p12,p13,p14))

draw :: Estado -> Picture
draw (E (Menu Jogar _ True) ej) = drawJogo ej
draw (E em _) = drawMenu em

reage :: Event -> Estado -> Estado
reage e (E em@(Menu Jogar _ True) ej) = E em (reageJogo e ej)
reage e (E em ej) = E (reageMenu e em) ej

-- MENU --

data EstadoMenu = Menu Opcao Elementos Bool
    deriving Eq

data Opcao = Jogar
           | Sair
           deriving Eq

type Elementos = (Picture, Picture, Picture, Picture, Picture)

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

type EstadoJogo = (Jogo, TexturasJogo)
type TexturasJogo = (Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture)

-- mapa --

world :: Jogo
world = j1

j1 :: Jogo
j1 = Jogo [[Vazio,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],
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

j2 :: Jogo
j2 = Jogo [[Vazio,Vazio,Vazio,Vazio,Vazio,Bloco,Bloco,Bloco,Vazio,Vazio,Vazio,Vazio,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Vazio],
           [Vazio,Bloco,Bloco,Bloco,Bloco,Vazio,Vazio,Vazio,Bloco,Bloco,Bloco,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco],
           [Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco],
           [Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco],
           [Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco],
           [Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco],
           [Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco],
           [Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco,Caixa,Caixa,Caixa,Caixa,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco],
           [Bloco,Porta,Vazio,Vazio,Vazio,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco],
           [Bloco,Bloco,Vazio,Bloco,Bloco,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco,Bloco,Vazio,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Caixa,Bloco],
           [Vazio,Bloco,Vazio,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco,Vazio,Bloco,Bloco,Vazio,Vazio,Vazio,Caixa,Caixa,Caixa,Bloco],
           [Vazio,Bloco,Vazio,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco,Vazio,Bloco,Bloco,Vazio,Vazio,Caixa,Caixa,Caixa,Caixa,Bloco],
           [Vazio,Bloco,Bloco,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco,Vazio,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco],
           [Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco,Bloco,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio]]
          (Jogador (9,6) Oeste False)

-- drawJogo --

drawJogo :: EstadoJogo -> Picture
drawJogo ((Jogo m j@(Jogador (x,y) d b)), t) = Pictures $ [figure] ++ [mapToPicture (desconstroiMapa m) j t]
    where figure = let c = light black
                   in Color c $ rectangleSolid (fromIntegral 1920) (fromIntegral 1080)
 
mapToPicture :: [(Peca,Coordenadas)] -> Jogador -> TexturasJogo -> Picture
mapToPicture m j t = translatemap m (Pictures (jogadorCaixa j t ++ pecasToPicture m m t))

translatemap :: [(Peca,Coordenadas)] -> Picture -> Picture
translatemap m p = Translate dx dy p
    where dx = ((fromIntegral (xMax m)) * (-960)) / 30
          dy = ((fromIntegral (yMax m)) * 540) / 17

jogadorCaixa :: Jogador -> TexturasJogo -> [Picture]
jogadorCaixa (Jogador (c,l) d b) (grass, dirt, box, boxe, boxmiddle, boxup, door, dudeE, dudeO)
    | d == Este && b == True = [jEste, Translate (fromIntegral x) (fromIntegral y+64) box]
    | d == Oeste && b == True = [jOeste, Translate (fromIntegral x) (fromIntegral y+64) box]
    | d == Este = [jEste]
    | d == Oeste = [jOeste]
    where (x,y) = converteCoordenada (c,l)
          jEste = Translate (fromIntegral x) (fromIntegral y) dudeE
          jOeste = Translate (fromIntegral x) (fromIntegral y) dudeO

pecasToPicture :: [(Peca,Coordenadas)] -> [(Peca,Coordenadas)] -> TexturasJogo -> [Picture]
pecasToPicture [] _ _ = []
pecasToPicture (x:xs) m t = pecaToPicture x t m : pecasToPicture xs m t

pecaToPicture :: (Peca,Coordenadas) -> TexturasJogo -> [(Peca,Coordenadas)] -> Picture
pecaToPicture (p,(c,l)) (grass, dirt, box, boxe, boxmiddle, boxup, door, dudeE, dudeO) m
    | p == Bloco = if elem (Bloco,(c,l-1)) m then Translate (fromIntegral x) (fromIntegral y) dirt else Translate (fromIntegral x) (fromIntegral y) grass
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

--
{-
nextLevel :: Int -> Jogo -> Int
nextLevel n (Jogo m (Jogador (x1,y1) _ _)) | x1 == x2 && y1 == y2 = n+1
                                           | otherwise = n
    where aux (p,(_,_)) = p == Porta
          (x2,y2) = giveCoordinates $ head $ filter aux $ desconstroiMapa m

giveCoordinates :: (Peca,Coordenadas) -> Coordenadas
giveCoordinates (p,c) = c
-}