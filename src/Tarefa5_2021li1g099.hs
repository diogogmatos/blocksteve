{- |
Module      : Tarefa5_2021li1gXXX
Description : Aplicação Gráfica

Módulo para a realização da Tarefa 5 do projeto de LI1 em 2021/22.
-}

module Main where

import LI12122
import ListaJogos
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
    Just p15 <- loadJuicy "titlep.png"
    Just p16 <- loadJuicy "cont.png"
    Just p17 <- loadJuicy "conts.png"
    Just p18 <- loadJuicy "menu.png"
    Just p19 <- loadJuicy "menus.png"
    Just p20 <- loadJuicy "help.png"
    Just p21 <- loadJuicy "background.png"
    Just p22 <- loadJuicy "gamebackground.png"
    play janela corFundo fr (estadoInicial (p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,p20,p21,p22)) draw reage (\_ e -> e)

fr = 60
janela = FullScreen

corFundo :: Color
corFundo = white

data Estado = E EstadoMenu EstadoJogo EstadoPausa
type Texturas = (Picture, Picture, Picture, Picture, Picture, Picture, Picture,
                 Picture, Picture, Picture, Picture, Picture, Picture, Picture,
                 Picture, Picture, Picture, Picture, Picture, Picture, Picture,
                 Picture)

estadoInicial :: Texturas -> Estado
estadoInicial (p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,p20,p21,p22) =
    E (Menu Jogar (p1,p2,p3,p4,p5,p21) False) (0, world, j1, (p6,p7,p8,p9,p10,p11,p12,p13,p14,p20,p22), False) (Pausa Continuar (p15,p16,p17,p18,p19,p21) True)

draw :: Estado -> Picture
draw (E (Menu Jogar _ True) ej (Pausa Continuar _ True)) = drawJogo ej
draw (E (Menu Jogar _ True) ej ep@(Pausa Continuar _ False)) = drawPausa ep
draw (E (Menu Jogar _ True) ej@(n, j, ja, t, h) ep@(Pausa VoltarAoMenu _ False)) = drawPausa ep
draw (E (Menu Jogar e True) ej (Pausa VoltarAoMenu _ True)) = drawMenu (Menu Jogar e False)
draw (E em _ _) = drawMenu em

reage :: Event -> Estado -> Estado
reage (EventKey (Char 'p') Down _ _) (E em@(Menu Jogar e True) ej (Pausa Continuar t True)) = E em ej (Pausa Continuar t False)
reage e (E em@(Menu Jogar _ True) ej ep@(Pausa Continuar _ False)) = E em ej (reagePausa e ep)
reage e (E em@(Menu Jogar _ True) ej@(n, j, ja, t, _) ep@(Pausa VoltarAoMenu _ False)) = E em ej (reagePausa e ep)
reage e (E em@(Menu Jogar t1 True) (n, _, _, t, h) ep@(Pausa VoltarAoMenu t2 True)) = E (reageMenu e (Menu Jogar t1 False)) (0, world, j1, t, h) (Pausa Continuar t2 True)
reage e (E em@(Menu Jogar _ True) ej ep@(Pausa Continuar _ True)) = E em (reageJogo e ej) ep
reage e (E em ej ep) = E (reageMenu e em) ej ep

-- MENU --

data EstadoMenu = Menu Opcao Elementos Bool
    deriving Eq

data Opcao = Jogar
           | Sair
           deriving Eq

type Elementos = (Picture, Picture, Picture, Picture, Picture, Picture)

reageMenu :: Event -> EstadoMenu -> EstadoMenu
reageMenu (EventKey (SpecialKey KeyUp) Down _ _) (Menu o e s) | o == Jogar = Menu Sair e False
                                                              | otherwise = Menu Jogar e False
reageMenu (EventKey (SpecialKey KeyDown) Down _ _) (Menu o e s) | o == Jogar = Menu Sair e False
                                                                | otherwise = Menu Jogar e False
reageMenu (EventKey (SpecialKey KeyEnter) Down _ _) (Menu o e s) | o == Jogar = Menu Jogar e True
                                                                 | otherwise = undefined
reageMenu _ m = m

drawMenu :: EstadoMenu -> Picture
drawMenu (Menu o (title, jogartxt, jogartxts, sairtxt, sairtxts, background) s) =
    if o == Jogar then Pictures $ [background] ++ [Translate 0 300 title, jogartxts, Translate 0 (-200) sairtxt]
    else Pictures $ [background] ++ [Translate 0 300 title, jogartxt, Translate 0 (-200) sairtxts]

-- PAUSA --

data EstadoPausa = Pausa OpcaoP Elementos Bool

data OpcaoP = Continuar
            | VoltarAoMenu
            deriving Eq

reagePausa :: Event -> EstadoPausa -> EstadoPausa
reagePausa (EventKey (SpecialKey KeyUp) Down _ _) (Pausa o e s) | o == Continuar = Pausa VoltarAoMenu e False
                                                                | otherwise = Pausa Continuar e False
reagePausa (EventKey (SpecialKey KeyDown) Down _ _) (Pausa o e s) | o == Continuar = Pausa VoltarAoMenu e False
                                                                  | otherwise = Pausa Continuar e False
reagePausa (EventKey (SpecialKey KeyEnter) Down _ _) (Pausa o e s) | o == Continuar = Pausa Continuar e True
                                                                   | otherwise = Pausa VoltarAoMenu e True
reagePausa _ p = p

drawPausa :: EstadoPausa -> Picture
drawPausa (Pausa o (title, cont, conts, menu, menus, background) s) =
    if o == Continuar then Pictures $ [background] ++ [Translate 0 280 title, Translate 50 (-100) conts, Translate 50 (-300) menu]
    else Pictures $ [background] ++ [Translate 0 280 title, Translate 50 (-100) cont, Translate 50 (-300) menus]

-- JOGO --

type EstadoJogo = (Int, [Jogo], Jogo, ElementosJogo, Bool)
type ElementosJogo = (Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture)
type TexturasJogo = (Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture)

-- mapa --

world :: [Jogo]
world = [j1,j2,j3]

-- drawJogo --

drawJogo :: EstadoJogo -> Picture
drawJogo (n, j, ja, (p6,p7,p8,p9,p10,p11,p12,p13,p14,p20,p22), h) | h == False = Pictures $ [p22] ++ [drawJogo' (ja, (p6,p7,p8,p9,p10,p11,p12,p13,p14))]
                                                                  | otherwise = p20

drawJogo' :: (Jogo, TexturasJogo) -> Picture
drawJogo' ((Jogo m j@(Jogador (x,y) d b)), t) = mapToPicture (desconstroiMapa m) j t
 
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
reageJogo (EventKey (SpecialKey KeyLeft) Down _ _) (n, j, ja, t, False) | n == (nextLevel n (moveJogador ja AndarEsquerda)) = (n, j, moveJogador ja AndarEsquerda, t, False)
                                                                        | otherwise = (n+1, j, j !! (n+1), t, False)
reageJogo (EventKey (SpecialKey KeyRight) Down _ _) (n, j, ja, t, False) | n == (nextLevel n (moveJogador ja AndarDireita)) = (n, j, moveJogador ja AndarDireita, t, False)
                                                                         | otherwise = (n+1, j, j !! (n+1), t, False)
reageJogo (EventKey (SpecialKey KeyUp) Down _ _) (n, j, ja, t, False) | n == (nextLevel n (moveJogador ja Trepar)) = (n, j, moveJogador ja Trepar, t, False)
                                                                      | otherwise = (n+1, j, j !! (n+1), t, False)
reageJogo (EventKey (SpecialKey KeyDown) Down _ _) (n, j, ja, t, False) | n == (nextLevel n (moveJogador ja InterageCaixa)) = (nextLevel n (moveJogador ja InterageCaixa), j, moveJogador ja InterageCaixa, t, False)
                                                                        | otherwise = (n+1, j, j !! (n+1), t, False)
reageJogo (EventKey (Char 'r') Down _ _) (n, j, ja, t, h) = (n, j, world !! n, t, False)
reageJogo (EventKey (Char 'a') Down _ _) (n, j, ja, t, h) = (n-1, j, world !! (n-1), t, h)
reageJogo (EventKey (Char 'd') Down _ _) (n, j, ja, t, h) = (n+1, j, world !! (n+1), t, h)
reageJogo (EventKey (Char 'h') Down _ _) (n, j, ja, t, h) = if h == False then (n, j, ja, t, True)
                                                            else (n, j, ja, t, False)
reageJogo _ j = j

--

nextLevel :: Int -> Jogo -> Int
nextLevel n (Jogo m (Jogador (x1,y1) _ _)) | x1 == x2 && y1 == y2 = n+1
                                           | otherwise = n
                                           where aux (p,(_,_)) = p == Porta
                                                 (x2,y2) = giveCoordinates $ head $ filter aux $ desconstroiMapa m

giveCoordinates :: (Peca,Coordenadas) -> Coordenadas
giveCoordinates (p,c) = c