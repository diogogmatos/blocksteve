{- |
Module      : Tarefa6_2021li1g099
Description : Resolução de um puzzle

Módulo para a realização da Tarefa 6 do projeto de LI1 em 2021/22.
-}

module Tarefa6_2021li1g099 where

import LI12122
import Data.List
import Tarefa1_2021li1g099
import Tarefa2_2021li1g099
import Tarefa4_2021li1g099

{- | __A função ’resolveJogo’ calcula o menor número de movimentos necessários para resolver um jogo.__

__!! :__ Função inconcluída - funciona apenas para mapas que não contêm caixas.
-}

resolveJogo :: Int -> Jogo -> Maybe [Movimento]
resolveJogo i j@(Jogo m jogador) | not (validaPotencialMapa (desconstroiMapa m)) = Nothing -- se o mapa é inválido retorna 'Nothing'
                                 | not (any aux (desconstroiMapa m)) = if null $ resolveSemCaixas i (desconstroiMapa m) jogador
                                                                       then Nothing -- se 'resolveSemCaixas' devolve lista vazia, o mapa é impossível - logo: 'Nothing'
                                                                       else Just $ resolveSemCaixas i (desconstroiMapa m) jogador
                                 | otherwise = Nothing
                                 where aux (p,(_,_)) = p == Caixa

--

{- | A função ’resolveSemCaixas’ calcula o menor número de movimentos para resolver um jogo __sem caixas__.

Para isso, a função verifica as coordenadas da 'Porta' do mapa e, dependendo da sua posição em relação ao jogador
(à direita ou à esquerda), irá efetuar movimentos nessa direção até o jogador chegar à porta, ou seja, até o jogador ter coordenadas iguais
às coordenadas da porta.

Sendo uma função recursiva, para cada movimento irá efetuar um conjunto de avaliações de modo a saber qual é o próximo passo.
Essas avaliações são:

Verifica se existe ou não um 'Bloco' em frente ao jogador:

- Se existe, efetua o movimento 'Trepar' para subir o bloco;
- Caso contrário, efetua o movimento 'AndarDireita' ou 'AndarEsquerda', dependendo da orientação.

__Nota:__ Quando o jogador carrega uma caixa, verifica também se existe espaço para transportar a caixa, caso não exista
retorna 'Nothing'.
-}

resolveSemCaixas :: Int -> [(Peca,Coordenadas)] -> Jogador -> [Movimento]
resolveSemCaixas i mapa j@(Jogador (x,y) d b)
    | p1 == x && p2 == y = []
    | (p1 - x) > 0 && b =
        if notElem (Bloco,(x+1,y)) mapa || notElem (Bloco,(x+1,y-1)) mapa
        then AndarDireita : resolveSemCaixas i mapa (Jogador (x+1,y) d b)
        else if (Bloco,(x+1,y-1)) `elem` mapa
        then []
        else if d /= Este
        then [AndarDireita,Trepar] ++ resolveSemCaixas i mapa (Jogador (x+1,y-1) d b)
        else Trepar : resolveSemCaixas i mapa (Jogador (x+1,y-1) d b)
    | (p1 - x) < 0 && b =
        if notElem (Bloco,(x-1,y)) mapa || notElem (Bloco,(x-1,y-1)) mapa
        then AndarEsquerda : resolveSemCaixas i mapa (Jogador (x-1,y) d b)
        else if (Bloco,(x-1,y-1)) `elem` mapa
        then []
        else if d /= Oeste
        then [AndarEsquerda,Trepar] ++ resolveSemCaixas i mapa (Jogador (x-1,y-1) d b)
        else Trepar : resolveSemCaixas i mapa (Jogador (x-1,y-1) d b)
    | p1 - x > 0 =
        if (Bloco,(x+1,y)) `notElem` mapa
        then AndarDireita : resolveSemCaixas i mapa (Jogador (x+1,y) d b)
        else if d /= Este
        then [AndarDireita,Trepar] ++ resolveSemCaixas i mapa (Jogador (x+1,y-1) d b)
        else Trepar : resolveSemCaixas i mapa (Jogador (x+1,y-1) d b)
    | p1 - x < 0 =
        if (Bloco,(x-1,y)) `notElem` mapa
        then AndarEsquerda : resolveSemCaixas i mapa (Jogador (x-1,y) d b)
        else if d /= Oeste
        then [AndarEsquerda,Trepar] ++ resolveSemCaixas i mapa (Jogador (x-1,y-1) d b)
        else Trepar : resolveSemCaixas i mapa (Jogador (x-1,y-1) d b)
    | otherwise = []
    where (_,(p1,p2)) = head $ filter aux mapa -- filtra o mapa de todos elementos exceto a porta e retira as coordenadas da mesma
          aux (p,(_,_)) = p == Porta

--