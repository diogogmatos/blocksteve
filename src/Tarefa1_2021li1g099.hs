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
validaPotencialMapa x = validaPosicoes x && validaPorta x && validaVazios x
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

validaVazios :: [(Peca,Coordenadas)] -> Bool
validaVazios l = (contaPecas Vazio 0 l) >= 1

contaPecas :: Peca -> Int -> [(Peca,Coordenadas)] -> Int
contaPecas peca acc [] = acc
contaPecas peca acc ((p,c):t) | p == peca = contaPecas peca (acc+1) t
                              | otherwise = contaPecas peca acc t

-- 3

{-
validaCaixa :: [(Peca,Coordenadas)] -> Bool
validaCaixa [] = True
validaCaixa l@((p,c):t) | p == Caixa = on c l
                        | otherwise = validaCaixa t

on :: Coordenadas -> [(Peca,Coordenadas)] -> Bool
on _ [] = False
on a@(x1,y1) ((p,(x2,y2)):t) | x1 == x2 && y1 == y2-1 = on' p
                             | otherwise = on a t

on' :: Peca -> Bool
on' p | p == Bloco || p == Caixa = True
      | otherwise = False
-}

-- 5

{-
validaChao :: [(Peca,Coordenadas)] -> Bool
validaChao [] = False
validaChao ((p,c):t) | y == yMax && p == Bloco && validaChao t

yMax :: [(Peca,Coordenadas)] -> Int
-}