{- |
Module      : Tarefa1_2021li1g099
Description : Validação de um potencial mapa
Copyright   : Rui Pedro Cerqueira <a100537@alunos.uminho.pt>;
            : Diogo Matos <a100741@alunos.uminho.pt>;

Módulo para a realização da Tarefa 1 do projeto de LI1 em 2021/22.
-}

module Tarefa1_2021li1g099 where

import LI12122

{-

validaPotencialMapa :: [(Peca, Coordenadas)] -> Bool
validaPotencialMapa [] = False
validaPotencialMapa x = validaPosicoes x && validaPorta x && validaVazios x && validaCaixas x x

-}

-- 1

validaPosicoes :: [(Peca, Coordenadas)] -> Bool
validaPosicoes [] = True
validaPosicoes ((p,c):t) = validaC (p,c) t && validaPosicoes t

validaC :: (Peca, Coordenadas) -> [(Peca, Coordenadas)] -> Bool
validaC _ [] = True
validaC a@(p,(x1,y1)) ((p1,(x2,y2)):t) | x1 == x2 && y1 == y2 = False
                                       | otherwise = validaC a t

-- 2 & 4

validaPorta :: [(Peca,Coordenadas)] -> Bool
validaPorta l = (contaPecas Porta 0 l) == 1

validaVazios :: [(Peca,Coordenadas)] -> Bool -- precisa de modificações para englobar as coordenadas não declaradas
validaVazios l = (contaPecas Vazio 0 l) >= 1

contaPecas :: Peca -> Int -> [(Peca,Coordenadas)] -> Int
contaPecas peca acc [] = acc
contaPecas peca acc ((p,c):t) | p == peca = contaPecas peca (acc+1) t
                              | otherwise = contaPecas peca acc t

-- 3

validaCaixas :: [(Peca,Coordenadas)] -> [(Peca,Coordenadas)] -> Bool
validaCaixas [] _ = True
validaCaixas l1@((p,c):t) l2 | p == Caixa && not (on c l2) = False
                             | p == Caixa && on c l2 = validaCaixas t l2
                             | otherwise = validaCaixas t l2

on :: Coordenadas -> [(Peca,Coordenadas)] -> Bool
on _ [] = True
on (x,y) l | elem (Bloco,(x,y+1)) l = True
           | elem (Caixa,(x,y+1)) l = True
           | otherwise = False

-- 5

{- work in progress

validaChao :: [(Peca,Coordenadas)] -> Bool
validaChao l = exists (filter aux l) (xMax l)
      where aux (_,(_,y)) = y == yMax l

validaChao l = all (filter aux l)
      where aux (_,(_,y)) = y == yMax l

exists :: [(Peca,Coordenadas)] -> Int -> Bool
exists [] _ = False
exists l@((p,(x,y)):t) acc | acc >= 0 = if ((elem (Bloco,(acc,y)) l) && (exists l (acc-1))) then True else False
                           | otherwise = True

xMax :: [(Peca,Coordenadas)] -> Int
xMax [(_,(x,_))] = x
xMax ((_,(x,_)):t) = max x (xMax t)

yMax :: [(Peca,Coordenadas)] -> Int
yMax [(_,(_,y))] = y
yMax ((_,(_,y)):t) = max y (yMax t)

-}