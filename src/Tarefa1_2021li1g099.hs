{- |
Module      : Tarefa1_2021li1g099
Description : Validação de um potencial mapa
Copyright   : Rui Pedro Cerqueira <a100537@alunos.uminho.pt>;
            : Diogo Matos <a100741@alunos.uminho.pt>;

Módulo para a realização da Tarefa 1 do projeto de LI1 em 2021/22.
-}

module Tarefa1_2021li1g099 where

import LI12122

validaPotencialMapa :: [(Peca, Coordenadas)] -> Bool
validaPotencialMapa [] = False
validaPotencialMapa x = validaPosicoes x && validaPorta x && validaVazios x && validaCaixas x x && validaChao x 0

-- 1

validaPosicoes :: [(Peca, Coordenadas)] -> Bool
validaPosicoes [] = True
validaPosicoes ((p,c):t) = validaC c t && validaPosicoes t

validaC :: Coordenadas -> [(Peca, Coordenadas)] -> Bool
validaC _ [] = True
validaC c@(x1,y1) ((p1,(x2,y2)):t) | x1 == x2 && y1 == y2 = False
                                   | otherwise = validaC c t

-- 2 & 4

validaPorta :: [(Peca,Coordenadas)] -> Bool
validaPorta l = (contaPecas Porta 0 l) == 1

validaVazios :: [(Peca,Coordenadas)] -> Bool
validaVazios l = ((contaPecas Vazio 0 l) >= 1) || (length l /= ((xMax l + 1) * (yMax l + 1)))

contaPecas :: Peca -> Int -> [(Peca,Coordenadas)] -> Int
contaPecas peca acc [] = acc
contaPecas peca acc ((p,c):t) | p == peca = contaPecas peca (acc+1) t
                              | otherwise = contaPecas peca acc t

xMax :: [(Peca,Coordenadas)] -> Int
xMax [(_,(x,_))] = x
xMax ((_,(x,_)):t) = max x (xMax t)

yMax :: [(Peca,Coordenadas)] -> Int
yMax [(_,(_,y))] = y
yMax ((_,(_,y)):t) = max y (yMax t)

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

validaChao :: [(Peca,Coordenadas)] -> Int -> Bool
validaChao l acc | not (elem (Bloco,(acc,yMax (filter aux1 l))) l) = False
                 | acc == xMax l = True
                 | (acc < xMax l) && validaLigacao (acc,yMax (filter aux1 l)) (acc+1, yMax (filter aux2 l)) l && validaChao l (acc+1) = True
                 | otherwise = False
                 where aux1 (_,(x,_)) = x == acc
                       aux2 (_,(x,_)) = x == acc+1

validaLigacao :: Coordenadas -> Coordenadas -> [(Peca,Coordenadas)] -> Bool
validaLigacao (x1,y1) b@(x2,y2) l | (x1 == x2) && (y1 == y2) = True
                                  | elem (Bloco,(x1,y1-1)) l && (abs (y2 - y1) >= abs (y2 - (y1-1))) = validaLigacao (x1,y1-1) b l
                                  | elem (Bloco,(x1+1,y1-1)) l && (abs (y2 - y1) >= abs (y2 - (y1-1))) && (abs (x2 - x1) >= abs (x2 - (x1+1))) = validaLigacao (x1+1,y1-1) b l
                                  | elem (Bloco,(x1+1,y1)) l && (abs (x2 - x1) >= abs (x2 - (x1+1))) = validaLigacao (x1+1,y1) b l
                                  | elem (Bloco,(x1+1,y1+1)) l && (abs (y2 - y1) >= abs (y2 - (y1+1))) && (abs (x2 - x1) >= abs (x2 - (x1+1))) = validaLigacao (x1+1,y1+1) b l
                                  | elem (Bloco,(x1,y1+1)) l && (abs (y2 - y1) >= abs (y2 - (y1+1))) = validaLigacao (x1,y1+1) b l
                                  | otherwise = False