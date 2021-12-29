{- |
Module      : Tarefa6_2021li1g099
Description : Resolução de um puzzle

Módulo para a realização da Tarefa 6 do projeto de LI1 em 2021/22.
-}

module Tarefa6_2021li1g099 where

import LI12122
import Tarefa1_2021li1g099
import Tarefa2_2021li1g099
import Tarefa4_2021li1g099

resolveJogo :: Int -> Jogo -> Maybe [Movimento]
resolveJogo i j@(Jogo m jogador) | not (validaPotencialMapa (desconstroiMapa m)) = Nothing
                                 | filter aux (desconstroiMapa m) == [] = Just (resolveSemCaixas i (desconstroiMapa m) (desconstroiMapa m) jogador)
                                 | otherwise = Nothing
                                 where aux (p,(_,_)) = p == Caixa

--

resolveSemCaixas :: Int -> [(Peca,Coordenadas)] -> [(Peca,Coordenadas)] -> Jogador -> [Movimento]
resolveSemCaixas _ [] _ _ = []
resolveSemCaixas i (m:ms) mapa j@(Jogador (x,y) d b)
    | p1 == x && p2 == y = []
    | ((p1 - x) > 0) && b = 
        if (notElem (Bloco,(x+1,y)) mapa || notElem (Bloco,(x+1,y-1)) mapa)
        then AndarDireita : (resolveSemCaixas i ms mapa (Jogador (x+1,y) d b))
        else if d /= Este
        then [AndarDireita,Trepar] ++ (resolveSemCaixas i ms mapa (Jogador (x+1,y-1) d b))
        else Trepar : (resolveSemCaixas i ms mapa (Jogador (x+1,y-1) d b))
    | ((p1 - x) < 0) && b = 
        if (notElem (Bloco,(x-1,y)) mapa || notElem (Bloco,(x-1,y-1)) mapa)
        then AndarEsquerda : (resolveSemCaixas i ms mapa (Jogador (x-1,y) d b))
        else if d /= Oeste
        then [AndarEsquerda,Trepar] ++ (resolveSemCaixas i ms mapa (Jogador (x-1,y-1) d b))
        else Trepar : (resolveSemCaixas i ms mapa (Jogador (x-1,y-1) d b))
    | (p1 - x) > 0 = 
        if (notElem (Bloco,(x+1,y)) mapa)
        then AndarDireita : (resolveSemCaixas i ms mapa (Jogador (x+1,y) d b))
        else if d /= Este
        then [AndarDireita,Trepar] ++ (resolveSemCaixas i ms mapa (Jogador (x+1,y-1) d b))
        else Trepar : (resolveSemCaixas i ms mapa (Jogador (x+1,y-1) d b))
    | (p1 - x) < 0 =
        if (notElem (Bloco,(x-1,y)) mapa)
        then AndarEsquerda : (resolveSemCaixas i ms mapa (Jogador (x-1,y) d b))
        else if d /= Oeste
        then [AndarEsquerda,Trepar] ++ (resolveSemCaixas i ms mapa (Jogador (x-1,y-1) d b))
        else Trepar : (resolveSemCaixas i ms mapa (Jogador (x-1,y-1) d b))
    | otherwise = []
    where (p1,p2) = givePorta (filter aux mapa)
          aux (p,(_,_)) = p == Porta

givePorta :: [(Peca,Coordenadas)] -> Coordenadas
givePorta ((_,(a,b)):t) = (a,b)

--

