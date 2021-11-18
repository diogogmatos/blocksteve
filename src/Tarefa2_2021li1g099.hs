{- |
Module      : Tarefa2_2021li1g099
Description : Construção/Desconstrução do mapa
Copyright   : Rui Pedro Cerqueira <a100537@alunos.uminho.pt>;
            : Diogo Matos <a100741@alunos.uminho.pt>;

Módulo para a realização da Tarefa 2 do projeto de LI1 em 2021/22.
-}
module Tarefa2_2021li1g099 where

import LI12122

{-
constroiMapa :: [(Peca, Coordenadas)] -> Mapa
constroiMapa [] = []
constroimapa (Peca, (x,y)) =
-}
desconstroiMapa :: Mapa -> [(Peca, Coordenadas)]
desconstroiMapa mapa = undefined

-- Funçao que filtra as coordenadas com igual y e as ordena
--filtraY:: [(Peca, Coordenadas)] -> [Peca, Coordenadas]
--filtraY (p, (x1,y1)) ((p, (x2,y2):t)

-- Função que ordene as listas em relaçao ao x
ordenaX :: [(Peca, Coordenadas)] -> [(Peca, Coordenadas)]
ordenaX [] = []
ordenaX ((p, (x,y)):t) = ordenaX (menor t) ++ [(p, (x,y))] ++ ordenaX (maior t)
    where maior [] = []
          maior ((p, (xs,ys)):l) = if xs >= x then (p, (xs,ys)) : maior l else maior l
          menor [] = []
          menor ((p, (xs,ys)):l) = if xs < x then (p, (xs,ys)) : menor l else menor l