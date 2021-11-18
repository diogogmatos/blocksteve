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
ordenaY :: [(Peca, Coordenadas)] -> [Peca, Coordenadas]
ordenaY a@(Peca, (x1,y1)) ((Peca, (x2,y2)):t)

-- Função que ordene as listas obtidas na função ordenaY
ordenaPecas :: [(Peca, Coordenadas)] -> [Peca, Coordenadas]
ordenaPecas a@(Peca, (x1,y1)) ((Peca, (x2,y2)):t)