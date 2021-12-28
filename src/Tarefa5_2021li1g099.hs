{- |
Module      : Tarefa5_2021li1g099
Description : Aplicação Gráfica

Módulo para a realização da Tarefa 5 do projeto de LI1 em 2021/22.
-}

module Main where

import LI12122
import ListaJogos
import Tarefa1_2021li1g099
import Tarefa2_2021li1g099
import Tarefa4_2021li1g099
import Tarefa6_2021li1g099
import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import Graphics.Gloss.Data.Bitmap
import Graphics.Gloss.Juicy (loadJuicy)

main = do
    Just p1 <- loadJuicy "imagens/title.png"
    Just p2 <- loadJuicy "imagens/jogar.png"
    Just p3 <- loadJuicy "imagens/jogars.png"
    Just p4 <- loadJuicy "imagens/sair.png"
    Just p5 <- loadJuicy "imagens/sairs.png"
    Just p6 <- loadJuicy "imagens/grass.png"
    Just p7 <- loadJuicy "imagens/dirt.png"
    Just p8 <- loadJuicy "imagens/box.png"
    Just p9 <- loadJuicy "imagens/boxe.png"
    Just p10 <- loadJuicy "imagens/boxmiddle.png"
    Just p11 <- loadJuicy "imagens/boxup.png"
    Just p12 <- loadJuicy "imagens/door.png"
    Just p13 <- loadJuicy "imagens/dudeRight.png"
    Just p14 <- loadJuicy "imagens/dudeLeft.png"
    Just p15 <- loadJuicy "imagens/titlep.png"
    Just p16 <- loadJuicy "imagens/cont.png"
    Just p17 <- loadJuicy "imagens/conts.png"
    Just p18 <- loadJuicy "imagens/menu.png"
    Just p19 <- loadJuicy "imagens/menus.png"
    Just p20 <- loadJuicy "imagens/help.png"
    Just p21 <- loadJuicy "imagens/background.png"
    Just p22 <- loadJuicy "imagens/gamebackground.png"
    Just p23 <- loadJuicy "imagens/niveis.png"
    Just p24 <- loadJuicy "imagens/niveiss.png"
    Just p25 <- loadJuicy "imagens/n1.png"
    Just p26 <- loadJuicy "imagens/n2.png"
    Just p27 <- loadJuicy "imagens/n3.png"
    Just p28 <- loadJuicy "imagens/n4.png"
    Just p29 <- loadJuicy "imagens/n5.png"
    Just p30 <- loadJuicy "imagens/n6.png"
    Just p31 <- loadJuicy "imagens/n7.png"
    Just p32 <- loadJuicy "imagens/n8.png"
    Just p33 <- loadJuicy "imagens/n9.png"
    Just p34 <- loadJuicy "imagens/n10.png"
    Just p35 <- loadJuicy "imagens/botRight.png"
    Just p36 <- loadJuicy "imagens/botLeft.png"
    Just p37 <- loadJuicy "imagens/botErrorRight.png"
    Just p38 <- loadJuicy "imagens/botErrorLeft.png"
    play janela white fr (estadoInicial (p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,p20,p21,p22,p23,p24,p25,p26,p27,p28,p29,p30,p31,p32,p33,p34,p35,p36,p37,p38)) draw reage reageTempo

fr = 2
janela = FullScreen

data Estado = E EstadoMenu EstadoJogo EstadoPausa EstadoNiveis
type Texturas = (Picture, Picture, Picture, Picture, Picture, Picture, Picture,
                 Picture, Picture, Picture, Picture, Picture, Picture, Picture,
                 Picture, Picture, Picture, Picture, Picture, Picture, Picture,
                 Picture, Picture, Picture, Picture, Picture, Picture, Picture,
                 Picture, Picture, Picture, Picture, Picture, Picture, Picture,
                 Picture, Picture, Picture)

estadoInicial :: Texturas -> Estado
estadoInicial (p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,p20,p21,p22,p23,p24,p25,p26,p27,p28,p29,p30,p31,p32,p33,p34,p35,p36,p37,p38) =
    E
    (Menu Jogar (p1,p2,p3,p4,p5,p21,p23,p24) False)
    (0, length world, False, world, j1, (p6,p7,p8,p9,p10,p11,p12,p13,p14,p20,p22,p35,p36,p37,p38), False, (1,1), Bot False Nothing)
    (Pausa Continuar (p15,p16,p17,p18,p19,p21) True)
    (Nivel 1 False (p25,p26,p27,p28,p29,p30,p31,p32,p33,p34))

reage :: Event -> Estado -> Estado
reage e (E em (r1,r2,r3,r4,r5,r6,r7,r8,Bot True Nothing) ep en) =
    E em (r1,r2,r3,r4,r5,r6,r7,r8,Bot False Nothing) ep en
reage (EventKey (Char 'b') Down _ _) (E em@(Menu Jogar _ True) (n,nMax,v,j,ja,t,h,(s1,s2),Bot False Nothing) ep@(Pausa Continuar _ True) en) =
    reageTempo 1 (E em (n,nMax,v,j,ja,t,h,(s1,s2),Bot True (resolveJogo 10 ja)) ep en)
reage (EventKey (Char 'b') Down _ _) (E em@(Menu Jogar _ True) (n,nMax,v,j,ja,t,h,(s1,s2),Bot True _) ep@(Pausa Continuar _ True) en) =
    E em (n,nMax,v,j,ja,t,h,(s1,s2),Bot False Nothing) ep en
reage e es@(E _ (_,_,_,_,_,_,_,_,Bot True _) _ _) = es
reage (EventKey (Char 'p') Down _ _) (E em@(Menu Jogar e True) ej (Pausa Continuar t True) en) =
    E em ej (Pausa Continuar t False) en
reage e (E (Menu _ t1 _) (_, _, True, _, _, t2, _, _, _) (Pausa _ t3 _) (Nivel _ _ t4)) =
    E (Menu Jogar t1 False) (0, length world, False, world, j1, t2, False, (1,1), Bot False Nothing) (Pausa Continuar t3 True) (Nivel 1 False t4)
reage e (E em@(Menu Jogar _ True) ej ep@(Pausa Continuar _ False) en) =
    E em ej (reagePausa e ep) en
reage e (E em@(Menu Jogar _ True) ej ep@(Pausa VoltarAoMenu _ False) en) =
    E em ej (reagePausa e ep) en
reage e (E em@(Menu Jogar t1 True) (n, nMax, v, _, _, t, h, _, _) (Pausa VoltarAoMenu t2 True) (Nivel _ _ t3)) =
    E (reageMenu e (Menu Jogar t1 False)) (0, nMax, False, world, j1, t, h, (1,1), Bot False Nothing) (Pausa Continuar t2 True) (Nivel 1 False t3)
reage e (E em@(Menu Jogar _ True) ej ep@(Pausa Continuar _ True) en) =
    E em (reageJogo e ej) ep en
reage e (E em@(Menu Niveis t1 True) (_,_,_,_,_,t2,_,_,_) ep en@(Nivel n True _)) =
    E (Menu Jogar t1 True) (n - 1, n, False, world, world !! (n - 1), t2, False, (1,1), Bot False Nothing) ep en
reage e (E em@(Menu Niveis _ True) ej ep en) =
    E em ej ep (reageNiveis e en)
reage e (E em ej ep en) =
    E (reageMenu e em) ej ep en

draw :: Estado -> Picture
draw (E (Menu _ e _) (_, _, True, _, _, _, _, _, _) ep en) = drawMenu (Menu Jogar e False)
draw (E (Menu Jogar _ True) ej (Pausa Continuar _ True) en) = drawJogo ej
draw (E (Menu Jogar _ True) ej ep@(Pausa Continuar _ False) en) = drawPausa ep
draw (E (Menu Jogar _ True) ej ep@(Pausa VoltarAoMenu _ False) en) = drawPausa ep
draw (E (Menu Jogar e True) ej (Pausa VoltarAoMenu _ True) en) = drawMenu (Menu Jogar e False)
draw (E em@(Menu Niveis e True) ej ep en) = drawNiveis en
draw (E em _ _ _) = drawMenu em

-- MENU --

data EstadoMenu = Menu Opcao Elementos Bool
    deriving Eq

data Opcao = Jogar
           | Niveis
           | Sair
           deriving Eq

type Elementos = (Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture)

reageMenu :: Event -> EstadoMenu -> EstadoMenu
reageMenu (EventKey (SpecialKey KeyUp) Down _ _) (Menu o e s) | o == Jogar = Menu Sair e False
                                                              | o == Niveis = Menu Jogar e False
                                                              | otherwise = Menu Niveis e False
reageMenu (EventKey (SpecialKey KeyDown) Down _ _) (Menu o e s) | o == Jogar = Menu Niveis e False
                                                                | o == Niveis = Menu Sair e False
                                                                | otherwise = Menu Jogar e False
reageMenu (EventKey (SpecialKey KeyEnter) Down _ _) (Menu o e s) | o == Sair = undefined
                                                                 | otherwise = Menu o e True
reageMenu _ m = m

drawMenu :: EstadoMenu -> Picture
drawMenu (Menu o (title, jogartxt, jogartxts, sairtxt, sairtxts, background, niveistxt, niveistxts) s)
    | o == Jogar = Pictures $ background : [Translate 0 300 title, Translate 0 50 jogartxts, Translate 0 (-150) niveistxt, Translate 0 (-340) sairtxt]
    | o == Niveis = Pictures $ background : [Translate 0 300 title, Translate 0 50 jogartxt, Translate 0 (-150) niveistxts, Translate 0 (-340) sairtxt]
    | otherwise = Pictures $ background : [Translate 0 300 title, Translate 0 50 jogartxt, Translate 0 (-150) niveistxt, Translate 0 (-340) sairtxts]

-- NIVEIS --

data EstadoNiveis = Nivel Int Bool TexturasN

type TexturasN = (Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture)

reageNiveis :: Event -> EstadoNiveis -> EstadoNiveis
reageNiveis (EventKey (SpecialKey KeyRight) Down _ _) (Nivel n s t) | n == 10 = Nivel 1 s t
                                                                    | otherwise = Nivel (n+1) s t
reageNiveis (EventKey (SpecialKey KeyLeft) Down _ _) (Nivel n s t) | n == 1 = Nivel 10 s t
                                                                   | otherwise = Nivel (n-1) s t
reageNiveis (EventKey (SpecialKey KeyEnter) Down _ _) (Nivel n s t) = Nivel n True t
reageNiveis _ n = n

drawNiveis :: EstadoNiveis -> Picture
drawNiveis (Nivel n s (n1,n2,n3,n4,n5,n6,n7,n8,n9,n10))
    | n == 1 = n1
    | n == 2 = n2
    | n == 3 = n3
    | n == 4 = n4
    | n == 5 = n5
    | n == 6 = n6
    | n == 7 = n7
    | n == 8 = n8
    | n == 9 = n9
    | otherwise = n10

-- PAUSA --

data EstadoPausa = Pausa OpcaoP ElementosP Bool

type ElementosP = (Picture, Picture, Picture, Picture, Picture, Picture)

data OpcaoP = Continuar
            | VoltarAoMenu
            deriving Eq

reagePausa :: Event -> EstadoPausa -> EstadoPausa
reagePausa (EventKey (SpecialKey KeyUp) Down _ _) (Pausa o e s) | o == Continuar = Pausa VoltarAoMenu e False
                                                                | otherwise = Pausa Continuar e False
reagePausa (EventKey (SpecialKey KeyDown) Down _ _) (Pausa o e s) | o == Continuar = Pausa VoltarAoMenu e False
                                                                  | otherwise = Pausa Continuar e False
reagePausa (EventKey (SpecialKey KeyEnter) Down _ _) (Pausa o e s) = Pausa o e True
reagePausa _ p = p

drawPausa :: EstadoPausa -> Picture
drawPausa (Pausa o (title, cont, conts, menu, menus, background) s)
    | o == Continuar = Pictures $ background : [Translate 0 280 title, Translate 50 (-100) conts, Translate 50 (-300) menu]
    | otherwise = Pictures $ background : [Translate 0 280 title, Translate 50 (-100) cont, Translate 50 (-300) menus]

-- JOGO --

type EstadoJogo = (Int, Int, Bool, [Jogo], Jogo, ElementosJogo, Bool, (Float,Float), Bot)

type ElementosJogo = (Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture)

type TexturasJogo = (Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture)

-- mapa --

world :: [Jogo]
world = [j1,j2,j3,j4,j5,j6,j7,j8,j9,j10]

-- reageJogo --

reageJogo :: Event -> EstadoJogo -> EstadoJogo
reageJogo (EventKey (SpecialKey KeyLeft) Down _ _) (n, nMax, v, j, ja, t, False, (s1,s2), b)
    | nextLevel n (moveJogador ja AndarEsquerda) == nMax = (n, nMax, True, j, ja, t, False, (s1,s2), b)
    | n == nextLevel n (moveJogador ja AndarEsquerda) = (n, nMax, v, j, moveJogador ja AndarEsquerda, t, False, (s1,s2), b)
    | otherwise = (n+1, nMax, v, j, j !! (n+1), t, False, (s1,s2), b)
reageJogo (EventKey (SpecialKey KeyRight) Down _ _) (n, nMax, v, j, ja, t, False, (s1,s2), b)
    | nextLevel n (moveJogador ja AndarDireita) == nMax = (n, nMax, True, j, ja, t, False, (s1,s2), b)
    | n == nextLevel n (moveJogador ja AndarDireita) = (n, nMax, v, j, moveJogador ja AndarDireita, t, False, (s1,s2), b)
    | otherwise = (n+1, nMax, v, j, j !! (n+1), t, False, (s1,s2), b)
reageJogo (EventKey (SpecialKey KeyUp) Down _ _) (n, nMax, v, j, ja, t, False, (s1,s2), b)
    | nextLevel n (moveJogador ja Trepar) == nMax = (n, nMax, True, j, ja, t, False, (s1,s2), b)
    | n == nextLevel n (moveJogador ja Trepar) = (n, nMax, v, j, moveJogador ja Trepar, t, False, (s1,s2), b)
    | otherwise = (n+1, nMax, v, j, j !! (n+1), t, False, (s1,s2), b)
reageJogo (EventKey (SpecialKey KeyDown) Down _ _) (n, nMax, v, j, ja, t, False, (s1,s2), b)
    | nextLevel n (moveJogador ja InterageCaixa) == nMax = (n, nMax, True, j, ja, t, False, (s1,s2), b)
    | n == nextLevel n (moveJogador ja InterageCaixa) = (nextLevel n (moveJogador ja InterageCaixa), nMax, v, j, moveJogador ja InterageCaixa, t, False, (s1,s2), b)
    | otherwise = (n+1, nMax, v, j, j !! (n+1), t, False, (s1,s2), b)
reageJogo (EventKey (Char '+') Down _ _) (n, nMax, v, j, ja, t, h, (s1,s2), b)
    | s1 >= 1.9 = (n, nMax, v, j, ja, t, h, (s1,s2), b)
    | otherwise = (n, nMax, v, j, ja, t, h, (s1+0.1,s2+0.1), b)
reageJogo (EventKey (Char '-') Down _ _) (n, nMax, v, j, ja, t, h, (s1,s2), b)
    | s1 <= 0.6 = (n, nMax, v, j, ja, t, h, (s1,s2), b)
    | otherwise = (n, nMax, v, j, ja, t, h, (s1-0.1,s2-0.1), b)                         
reageJogo (EventKey (Char 'r') Down _ _) (n, nMax, v, j, ja, t, h, (s1,s2), b) = (n, nMax, v, j, world !! n, t, False, (s1,s2), b)
reageJogo (EventKey (Char 'a') Down _ _) (n, nMax, v, j, ja, t, h, (s1,s2), b) = (n-1, nMax, v, j, world !! (n-1), t, h, (s1,s2), b)
reageJogo (EventKey (Char 'd') Down _ _) (n, nMax, v, j, ja, t, h, (s1,s2), b) = (n+1, nMax, v, j, world !! (n+1), t, h, (s1,s2), b)
reageJogo (EventKey (Char 'h') Down _ _) (n, nMax, v, j, ja, t, h, (s1,s2), b) = if not h
                                                                                 then (n, nMax, v, j, ja, t, True, (s1,s2), b)
                                                                                 else (n, nMax, v, j, ja, t, False, (s1,s2), b)
reageJogo _ j = j

--

nextLevel :: Int -> Jogo -> Int
nextLevel n (Jogo m (Jogador (x1,y1) _ _)) | x1 == x2 && y1 == y2 = n+1
                                           | otherwise = n
                                           where aux (p,(_,_)) = p == Porta
                                                 (x2,y2) = giveCoordinates $ head $ filter aux $ desconstroiMapa m

giveCoordinates :: (Peca,Coordenadas) -> Coordenadas
giveCoordinates (p,c) = c

-- drawJogo --

drawJogo :: EstadoJogo -> Picture
drawJogo (n, nMax, v, j, ja, (p6,p7,p8,p9,p10,p11,p12,p13,p14,p20,p22,p35,p36,p37,p38), h, (s1,s2), Bot b l)
    | not h && b && (l == Nothing) = Pictures $ p22 : [Scale s1 s2 $ drawJogo' (ja, (p6,p7,p8,p9,p10,p11,p12,p37,p38))]
    | not h && b = Pictures $ p22 : [Scale s1 s2 $ drawJogo' (ja, (p6,p7,p8,p9,p10,p11,p12,p35,p36))]
    | not h = Pictures $ p22 : [Scale s1 s2 $ drawJogo' (ja, (p6,p7,p8,p9,p10,p11,p12,p13,p14))]
    | otherwise = p20

drawJogo' :: (Jogo, TexturasJogo) -> Picture
drawJogo' (Jogo m j@(Jogador (x,y) d b), t) = mapToPicture (desconstroiMapa m) j t

mapToPicture :: [(Peca,Coordenadas)] -> Jogador -> TexturasJogo -> Picture
mapToPicture m j t = translatemap m (Pictures (jogadorCaixa j t ++ pecasToPicture m m t))

translatemap :: [(Peca,Coordenadas)] -> Picture -> Picture
translatemap m = Translate dx dy
    where dx = (fromIntegral (xMax m) * (-960)) / 30
          dy = (fromIntegral (yMax m) * 540) / 17

jogadorCaixa :: Jogador -> TexturasJogo -> [Picture]
jogadorCaixa (Jogador (c,l) d b) (grass, dirt, box, boxe, boxmiddle, boxup, door, dudeE, dudeO)
    | d == Este && b = [jEste, Translate (fromIntegral x) (fromIntegral y+64) box]
    | d == Oeste && b = [jOeste, Translate (fromIntegral x) (fromIntegral y+64) box]
    | d == Este = [jEste]
    | d == Oeste = [jOeste]
    where (x,y) = converteCoordenada (c,l)
          jEste = Translate (fromIntegral x) (fromIntegral y) dudeE
          jOeste = Translate (fromIntegral x) (fromIntegral y) dudeO

pecasToPicture :: [(Peca,Coordenadas)] -> [(Peca,Coordenadas)] -> TexturasJogo -> [Picture]
pecasToPicture [] _ _ = []
pecasToPicture (x:xs) m t = pecaToPicture x t m : pecasToPicture xs m t

pecaToPicture :: (Peca,Coordenadas) -> TexturasJogo -> [(Peca,Coordenadas)] -> Picture
pecaToPicture (p,(c,l)) (grass, dirt, box, boxe, boxmiddle, boxup, door, _, _) m
    | p == Bloco = if elem (Bloco,(c,l-1)) m then Translate (fromIntegral x) (fromIntegral y) dirt else Translate (fromIntegral x) (fromIntegral y) grass
    | p == Caixa = if (elem (Caixa,(c,l+1)) m) && (elem (Caixa,(c,l-1)) m) then Translate (fromIntegral x) (fromIntegral y) boxmiddle
                   else if elem (Caixa,(c,l-1)) m then Translate (fromIntegral x) (fromIntegral y) boxe
                   else if elem (Caixa,(c,l+1)) m then Translate (fromIntegral x) (fromIntegral y) boxup
                   else Translate (fromIntegral x) (fromIntegral y) box
    | p == Porta = Translate (fromIntegral x) (fromIntegral y) door
    where (x,y) = converteCoordenada (c,l)

converteCoordenada :: (Int,Int) -> (Int,Int)
converteCoordenada (x,y) = (x*64,(-y)*64)

-- BOT --

data Bot = Bot Bool (Maybe [Movimento])

reageTempo :: Float -> Estado -> Estado
reageTempo _ (E em ej@(n,nMax,v,j,ja,t,h,(s1,s2),Bot True (Just (m:ms))) ep en)
    | m == AndarDireita = if ms == []
                          then E em (reageJogo (EventKey (SpecialKey KeyRight) Down a b) (n,nMax,v,j,ja,t,h,(s1,s2),Bot False Nothing)) ep en
                          else E em (reageJogo (EventKey (SpecialKey KeyRight) Down a b) (n,nMax,v,j,ja,t,h,(s1,s2),Bot True (Just ms))) ep en
    | m == AndarEsquerda = if ms == []
                           then E em (reageJogo (EventKey (SpecialKey KeyLeft) Down a b) (n,nMax,v,j,ja,t,h,(s1,s2),Bot False Nothing)) ep en
                           else E em (reageJogo (EventKey (SpecialKey KeyLeft) Down a b) (n,nMax,v,j,ja,t,h,(s1,s2),Bot True (Just ms))) ep en
    | m == Trepar = if ms == []
                    then E em (reageJogo (EventKey (SpecialKey KeyUp) Down a b) (n,nMax,v,j,ja,t,h,(s1,s2),Bot False Nothing)) ep en
                    else E em (reageJogo (EventKey (SpecialKey KeyUp) Down a b) (n,nMax,v,j,ja,t,h,(s1,s2),Bot True (Just ms))) ep en
    | m == InterageCaixa = if ms == []
                           then E em (reageJogo (EventKey (SpecialKey KeyDown) Down a b) (n,nMax,v,j,ja,t,h,(s1,s2),Bot False Nothing)) ep en
                           else E em (reageJogo (EventKey (SpecialKey KeyDown) Down a b) (n,nMax,v,j,ja,t,h,(s1,s2),Bot True (Just ms))) ep en
    | otherwise = E em ej ep en
    where a = Modifiers Down Down Down
          b = (1,1)
reageTempo _ e = e