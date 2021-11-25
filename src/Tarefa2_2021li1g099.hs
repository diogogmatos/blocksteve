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

{- | A função ’constroiMapa’ constroi um mapa a partir de uma lista de [(Peca, Coordenadas)] usando as funções 'formata', 'parteLista', 'adicionaVazios' e 'fundeIguais' 

>>>constroiMapa [(Porta, (0,2)), (Bloco, (0,3)), (Bloco, (1,3))]
[[Vazio,Vazio],
 [Vazio,Vazio],
 [Porta,Vazio],
 [Bloco,Bloco]]
-}

constroiMapa :: [(Peca, Coordenadas)] -> Mapa
constroiMapa [] = []
constroiMapa pecas = formata (parteLista (adicionaVazios (fundeIguais pecas)) 0)

{- | A função ’fundeIguais’ funde dois elementos que sejam iguais. -}

fundeIguais :: [(Peca, Coordenadas)] -> [(Peca, Coordenadas)]
fundeIguais [] = []
fundeIguais (x:xs) | elem x xs = fundeIguais xs
                   | otherwise = x : fundeIguais xs 

{- | A função ’adicionaVazios’ organiza a lista das peças do tipo Vazio obitda pela função 'listaVazios'. -}

adicionaVazios :: [(Peca,Coordenadas)] -> [(Peca,Coordenadas)]
adicionaVazios l = organizaPecas (l ++ listaVazios l 0)

--
{- | A função ’organizaPecas’ organiza uma lista dependendo do valor das suas Coordenadas.

>>> organizaPecas [(Bloco, (1,6)), (Bloco, (1,4))]
[(Bloco, (1,4)), (Bloco, (1,6))]
-}

organizaPecas :: [(Peca,Coordenadas)] -> [(Peca,Coordenadas)]
organizaPecas l = organizaPecasY (organizaPecasX l 0) 0

{- | A função ’organizaPecasY’ organiza uma lista dependendo do seu valor Y (crescente). 

>>> organizaPecasY [(Bloco, (1,6)), (Bloco, (1,4)), (Bloco, (2,3)), (Bloco, (2,5))] 0
[(Bloco,(2,3)), (Bloco,(1,4)), (Bloco,(2,5)), (Bloco,(1,6))]
-}

organizaPecasY :: [(Peca,Coordenadas)] -> Int -> [(Peca,Coordenadas)]
organizaPecasY l acc | acc <= yMax l = (filter aux l) ++ organizaPecasY l (acc+1)
                     | otherwise = []
                     where aux (_,(_,y)) = y == acc

{- | A função ’organizaPecasX’ organiza uma lista dependendo do seu valor X (crescente). 

>>> organizaPecasY [(Bloco, (1,6)), (Bloco, (1,4)), (Bloco, (2,3)), (Bloco, (2,5))] 0
[(Bloco,(1,6)),(Bloco,(1,4)),(Bloco,(2,3)),(Bloco,(2,5))]
-}

organizaPecasX :: [(Peca,Coordenadas)] -> Int -> [(Peca,Coordenadas)]
organizaPecasX l acc | acc <= xMax l = (filter aux l) ++ organizaPecasX l (acc+1)
                     | otherwise = []
                     where aux (_,(x,_)) = x == acc 

{- | A função ’listaVazios’ cria uma lista do conjunto de peça Vazios do mapa. 

>>> listaVazios [(Bloco, (0,6))] 0
[(Vazio,(0,0)),(Vazio,(0,1)),(Vazio,(0,2)),(Vazio,(0,3)),(Vazio,(0,4)),(Vazio,(0,5))]
-}

listaVazios :: [(Peca,Coordenadas)] -> Int -> [(Peca,Coordenadas)]
listaVazios l acc | acc <= yMax l = listaVaziosX l 0 acc ++ listaVazios l (acc+1)
                  | otherwise = []

{- | A função ’listaVaziosX’ cria uma lista de peças do tipo Vazio de um certo valor Y. -}

listaVaziosX :: [(Peca,Coordenadas)] -> Int -> Int -> [(Peca,Coordenadas)]
listaVaziosX l@(a@(p,(x,y1)):t) acc y2 | acc <= xMax l = if ((elem (Bloco,(acc,y2)) l) || (elem (Caixa,(acc,y2)) l) || (elem (Porta,(acc,y2)) l) || (elem (Vazio,(acc,y2)) l))
                                                         then listaVaziosX l (acc+1) y2
                                                         else (Vazio,(acc,y2)) : listaVaziosX l (acc+1) y2
                                       | otherwise = []

{- | A função ’parteLista’ parte uma lista em varias. 

>>> parteLista [(Bloco, (1,1)), (Bloco, (2,1))] 0
[[],[(Bloco,(1,1)),(Bloco,(2,1))]]
-}

parteLista :: [(Peca, Coordenadas)] -> Int -> [[(Peca, Coordenadas)]]
parteLista l acc | acc <= yMax l = [(filter aux l)] ++ parteLista l (acc+1)
                 | otherwise = []
                 where aux (_,(_,y)) = y == acc

{- | A função ’formata’ utiliza a função retiraCoordenadas para formatar uma lista de [[(Peca, Coordenadas)]]. -}

formata :: [[(Peca, Coordenadas)]] -> Mapa
formata [] = []
formata (x:xs) = retiraCoordenadas x : formata xs

{- | A função ’retiraCoordenadas’ remove de um conjunto [(Peca, Coordenadas)], as respetivas coordenadas.

>>> retiraCoordenadas [(Bloco,(1,2))]
[Bloco]
-}

retiraCoordenadas :: [(Peca, Coordenadas)] -> [Peca]
retiraCoordenadas [] = []
retiraCoordenadas ((p,(x,y)):t) = p : retiraCoordenadas t

-- // --

{- | A função ’desconstroiMapa’ desconstroi listas de peças e adiciona Coordenadas as mesmas excluindo o tipo de peça Vazio. 

>>> desconstroiMapa [[Vazio,Vazio],[Vazio,Vazio],[Porta,Vazio],[Bloco,Bloco]]
[(Porta,(0,2)),(Bloco,(0,3)),(Bloco,(1,3))]
-}

desconstroiMapa :: Mapa -> [(Peca, Coordenadas)]
desconstroiMapa [] = []
desconstroiMapa mapa = filter aux (converte mapa 0)
    where aux (p,(_,_)) = p /= Vazio

{- | A função ’converte’ utiliza a função 'adicionaCoordenadas' para adicionar coordenadas a uma lista de peças. -}

converte :: Mapa -> Int -> [(Peca, Coordenadas)]
converte [] _ = []
converte (x:xs) acc = adicionaCoordenadas x 0 acc ++ converte xs (acc+1)

{- | A função ’adicionaCoordenadas’ adiciona coordenadas a uma peça.

>>> adicionaCoordenadas [Bloco] 1 2
[(Bloco,(1,2))]
-}

adicionaCoordenadas :: [Peca] -> Int -> Int -> [(Peca, Coordenadas)]
adicionaCoordenadas [] _ _ = []
adicionaCoordenadas l@(x:xs) acc y = (x,(acc,y)) : adicionaCoordenadas xs (acc+1) y