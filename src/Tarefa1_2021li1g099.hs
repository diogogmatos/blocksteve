{- |
Module      : Tarefa1_2021li1g099
Description : Validação de um potencial mapa
Copyright   : Rui Pedro Cerqueira <a100537@alunos.uminho.pt>;
            : Diogo Matos <a100741@alunos.uminho.pt>;

Módulo para a realização da Tarefa 1 do projeto de LI1 em 2021/22.
-}

module Tarefa1_2021li1g099 where

import LI12122

{- | A função ’validaPotencialMapa’ aplica as funçoes 'validaPosicoes', 'validaPorta', 'validaVazios', 'validaCaixas' e 'validaChao' e verifica se o mapa cumpre com todos os requisitos. -}

validaPotencialMapa :: [(Peca, Coordenadas)] -> Bool
validaPotencialMapa [] = False
validaPotencialMapa x = validaPosicoes x && validaPorta x && validaVazios x && validaCaixas x x && validaChao x 0

-- 1

{- | A função ’validaPosicoes’ verifica se existem 2 peças com as mesmas coordenadas.

== Exemplos de utilização:

>>> validaPosicoes [(Bloco, (1,1)), Porta, (1,1)]
False

-}

validaPosicoes :: [(Peca, Coordenadas)] -> Bool
validaPosicoes [] = True
validaPosicoes ((p,c):t) = validaC c t && validaPosicoes t 

{- | A função ’validaC’ verifica se existem 2 coordenadas iguais. -}

validaC :: Coordenadas -> [(Peca, Coordenadas)] -> Bool
validaC _ [] = True
validaC c@(x1,y1) ((p1,(x2,y2)):t) | x1 == x2 && y1 == y2 = False
                                   | otherwise = validaC c t

-- 2 & 4

{- | A função ’validaPorta’ verifica se existe apenas uma porta no mapa.

== Exemplos de utilização:

>>> validaPorta [(Bloco, (1,1)), (Porta, (1,2))]
True
>>> validaPorta [(Bloco, (1,1)), (Caixa, (1,2))]
False
>>> validaPorta [(Bloco, (1,1)), (Porta (1,2)), (Porta (1,3))]
False
-}

validaPorta :: [(Peca,Coordenadas)] -> Bool
validaPorta l = (contaPecas Porta 0 l) == 1

{- | A função ’validaVazios’ verifica se existe no mínimo um "Vazio" no mapa.

== Exemplos de utilização:

>>> validaVazio[(Bloco, (0,0)), (Porta, (0,1))]
False
>>> validaVazio [(Vazio, (1,1)), (Caixa, (1,2))]
True
-}

validaVazios :: [(Peca,Coordenadas)] -> Bool
validaVazios l = ((contaPecas Vazio 0 l) >= 1) || (length l /= ((xMax l + 1) * (yMax l + 1)))

{- | A função ’contaPecas’ conta quantas peças existem de cada tipo. -}

contaPecas :: Peca -> Int -> [(Peca,Coordenadas)] -> Int
contaPecas peca acc [] = acc
contaPecas peca acc ((p,c):t) | p == peca = contaPecas peca (acc+1) t
                              | otherwise = contaPecas peca acc t

{- | A função ’xMax’ dá-nos o valor Máximo de x de uma lista [(Peca,Coordenadas)]. -}

xMax :: [(Peca,Coordenadas)] -> Int
xMax [(_,(x,_))] = x
xMax ((_,(x,_)):t) = max x (xMax t)

{- | A função ’yMax’ dá-nos o valor Máximo de Y de uma lista [(Peca,Coordenadas)]. -}

yMax :: [(Peca,Coordenadas)] -> Int
yMax [(_,(_,y))] = y
yMax ((_,(_,y)):t) = max y (yMax t)

-- 3

{- | A função ’validaCaixas’ verifica se uma caixa está em cima de outra caixa ou de ou bloco.

== Exemplos de utilização:

>>> validaCaixas [(Bloco, (0,3)), (Caixa, (0,2))]
True
>>> validaCaixas [(Bloco, (0,3)), (Caixa, (1,3))]
False
-}

validaCaixas :: [(Peca,Coordenadas)] -> [(Peca,Coordenadas)] -> Bool
validaCaixas [] _ = True
validaCaixas l1@((p,c):t) l2 | p == Caixa && not (on c l2) = False         -- Se a peça for uma Caixa, vai verificar se ao longo da lista existe um bloco uma caixa em baixo da mesma
                             | p == Caixa && on c l2 = validaCaixas t l2      
                             | otherwise = validaCaixas t l2

{- | A função ’on’ verifica se uma peça esta em cima de uma caixa ou bloco. -}

on :: Coordenadas -> [(Peca,Coordenadas)] -> Bool
on _ [] = True
on (x,y) l | elem (Bloco,(x,y+1)) l = True
           | elem (Caixa,(x,y+1)) l = True
           | otherwise = False

-- 5

{- | A função ’validaChao’ verifica se o chao do mapa é constituido por Blocos apenas.

== Exemplos de utilização:

>>> validaChao [(Bloco, (0,3)), (Caixa, (1,3))]
False
>>> validaChao [(Bloco, (0,3)), (Bloco, (1,3))]
True
-}

validaChao :: [(Peca,Coordenadas)] -> Int -> Bool
validaChao l acc | not (elem (Bloco,(acc,yMax (filter aux1 l))) l) = False
                 | acc == xMax l = True
                 | (acc < xMax l) && validaLigacao (acc,yMax (filter aux1 l)) (acc+1, yMax (filter aux2 l)) l && validaChao l (acc+1) = True
                 | otherwise = False
                 where aux1 (_,(x,_)) = x == acc
                       aux2 (_,(x,_)) = x == acc+1

{- | A função ’validaLigacao’. -}

validaLigacao :: Coordenadas -> Coordenadas -> [(Peca,Coordenadas)] -> Bool
validaLigacao (x1,y1) b@(x2,y2) l | (x1 == x2) && (y1 == y2) = True
                                  | elem (Bloco,(x1,y1-1)) l && (abs (y2 - y1) >= abs (y2 - (y1-1))) = validaLigacao (x1,y1-1) b l
                                  | elem (Bloco,(x1+1,y1-1)) l && (abs (y2 - y1) >= abs (y2 - (y1-1))) && (abs (x2 - x1) >= abs (x2 - (x1+1))) = validaLigacao (x1+1,y1-1) b l
                                  | elem (Bloco,(x1+1,y1)) l && (abs (x2 - x1) >= abs (x2 - (x1+1))) = validaLigacao (x1+1,y1) b l
                                  | elem (Bloco,(x1+1,y1+1)) l && (abs (y2 - y1) >= abs (y2 - (y1+1))) && (abs (x2 - x1) >= abs (x2 - (x1+1))) = validaLigacao (x1+1,y1+1) b l
                                  | elem (Bloco,(x1,y1+1)) l && (abs (y2 - y1) >= abs (y2 - (y1+1))) = validaLigacao (x1,y1+1) b l
                                  | otherwise = False