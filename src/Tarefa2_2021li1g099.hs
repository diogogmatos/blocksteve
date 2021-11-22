{- |
Module      : Tarefa2_2021li1g099
Description : Construção/Desconstrução do mapa
Copyright   : Rui Pedro Cerqueira <a100537@alunos.uminho.pt>;
            : Diogo Matos <a100741@alunos.uminho.pt>;

Módulo para a realização da Tarefa 2 do projeto de LI1 em 2021/22.
-}

module Tarefa2_2021li1g099 where

import LI12122
import Tarefa1_2021li1g099

constroiMapa :: [(Peca, Coordenadas)] -> Mapa
constroiMapa [] = []
constroiMapa pecas = formata (parteLista (adicionaVazios (fundeIguais pecas)) 0)

-- Função 'fundeIguais'

fundeIguais :: [(Peca, Coordenadas)] -> [(Peca, Coordenadas)]
fundeIguais [] = []
fundeIguais (x:xs) | elem x xs = fundeIguais xs
                   | otherwise = x : fundeIguais xs 

-- Função 'adicionaVazios'

adicionaVazios :: [(Peca,Coordenadas)] -> [(Peca,Coordenadas)]
adicionaVazios l = organizaPecas (l ++ listaVazios l 0)

--

organizaPecas :: [(Peca,Coordenadas)] -> [(Peca,Coordenadas)]
organizaPecas l = organizaPecasY (organizaPecasX l 0) 0

organizaPecasY :: [(Peca,Coordenadas)] -> Int -> [(Peca,Coordenadas)]
organizaPecasY l acc | acc <= yMax l = (filter aux l) ++ organizaPecasY l (acc+1)
                     | otherwise = []
                     where aux (_,(_,y)) = y == acc

organizaPecasX :: [(Peca,Coordenadas)] -> Int -> [(Peca,Coordenadas)]
organizaPecasX l acc | acc <= xMax l = (filter aux l) ++ organizaPecasX l (acc+1)
                     | otherwise = []
                     where aux (_,(x,_)) = x == acc 

--

listaVazios :: [(Peca,Coordenadas)] -> Int -> [(Peca,Coordenadas)]
listaVazios l acc | acc <= yMax l = listaVaziosX l 0 acc ++ listaVazios l (acc+1)
                  | otherwise = []

listaVaziosX :: [(Peca,Coordenadas)] -> Int -> Int -> [(Peca,Coordenadas)]
listaVaziosX l@(a@(p,(x,y1)):t) acc y2 | acc <= xMax l = if ((elem (Bloco,(acc,y2)) l) || (elem (Caixa,(acc,y2)) l) || (elem (Porta,(acc,y2)) l) || (elem (Vazio,(acc,y2)) l))
                                                         then listaVaziosX l (acc+1) y2
                                                         else (Vazio,(acc,y2)) : listaVaziosX l (acc+1) y2
                                       | otherwise = []

-- Função 'parteLista'

parteLista :: [(Peca, Coordenadas)] -> Int -> [[(Peca, Coordenadas)]]
parteLista l acc | acc <= yMax l = [(filter aux l)] ++ parteLista l (acc+1)
                 | otherwise = []
                 where aux (_,(_,y)) = y == acc

-- Função 'formata'

formata :: [[(Peca, Coordenadas)]] -> Mapa
formata [] = []
formata (x:xs) = retiraCoordenadas x : formata xs

retiraCoordenadas :: [(Peca, Coordenadas)] -> [Peca]
retiraCoordenadas [] = []
retiraCoordenadas ((p,(x,y)):t) = p : retiraCoordenadas t

-- // --

desconstroiMapa :: Mapa -> [(Peca, Coordenadas)]
desconstroiMapa [] = []
desconstroiMapa mapa = filter aux (converte mapa 0)
    where aux (p,(_,_)) = p /= Vazio

converte :: Mapa -> Int -> [(Peca, Coordenadas)]
converte [] _ = []
converte (x:xs) acc = adicionaCoordenadas x 0 acc ++ converte xs (acc+1)

adicionaCoordenadas :: [Peca] -> Int -> Int -> [(Peca, Coordenadas)]
adicionaCoordenadas [] _ _ = []
adicionaCoordenadas l@(x:xs) acc y = (x,(acc,y)) : adicionaCoordenadas xs (acc+1) y

