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

{- | A função ’constroiMapa’ constroi um 'Mapa' a partir de uma lista do tipo '[(Peca, Coordenadas)]' (já validada)
usando as funções 'formata', 'parteLista', 'adicionaVazios' e 'fundeIguais'.

== Exemplos de utilização:

>>>constroiMapa [(Porta, (0,2)), (Bloco, (0,3)), (Bloco, (1,3))]
[[Vazio,Vazio],
 [Vazio,Vazio],
 [Porta,Vazio],
 [Bloco,Bloco]]
-}

constroiMapa :: [(Peca, Coordenadas)] -> Mapa
constroiMapa [] = []
constroiMapa pecas = formata (parteLista (adicionaVazios (fundeIguais pecas)) 0)

{- | A função ’fundeIguais’ funde dois elementos que sejam iguais.

Esta função tem como objetivo prevenir a ocorrência de erros na formação do Mapa quando existe sobreposição de peças.

Esta função é também responsável por realizar a primeira alteração à lista recebida por 'constroiMapa'.

-}

fundeIguais :: [(Peca, Coordenadas)] -> [(Peca, Coordenadas)]
fundeIguais [] = [] -- se a lista é vazia, significa que a função percorreu toda a lista e pode parar de ser chamada recursivamente - caso de paragem
fundeIguais (x:xs) | elem x xs = fundeIguais xs -- se o elemento da cabeça da lista existir na cauda, será ignorado - o que resulta na eliminação do elemento repetido
                   | otherwise = x : fundeIguais xs -- se o elemento da cabeça da lista não exisitir na cauda, não está repetido, logo é mantido e a função continua a procura para o resto da lista

{- | A função ’adicionaVazios’ adiciona à lista de pares '(Peca,Coordenadas)' as peças do tipo 'Vazio' não declaradas.

Para isso, a função:

1. Adiciona ao fim da lista rececebida a lista de peças 'Vazio' que não estão incluídas na mesma, com a ajuda de 'listaVazios';
2. Organiza as peças da lista resultante dessa "adição", com a ajuda de 'organizaPecas'.

O resultado é uma lista com todos os elementos organizados por coordenadas e com os vazios do mapa incluídos.

-}

adicionaVazios :: [(Peca,Coordenadas)] -> [(Peca,Coordenadas)]
adicionaVazios l = organizaPecas (l ++ listaVazios l 0)

--
{- | A função ’organizaPecas’ organiza uma lista de acordo com o valor das 'Coordenadas' de cada 'Peca'.

Para isso, a função:

1. Organiza as peças de acordo com a coordenada __x__, com a ajuda de 'organizaPecasX';
2. Organiza a lista resultante de 'organizaPecasX' de acordo com a coordenada __y__, com a ajuda de 'organizaPecasY'.

O resultado é uma lista de peças, ordendada pelas suas coordenadas __x__ e __y__.

== Exemplos de utilização:

>>> organizaPecas [(Bloco, (1,6)), (Bloco, (1,4))]
[(Bloco, (1,4)), (Bloco, (1,6))]
-}

organizaPecas :: [(Peca,Coordenadas)] -> [(Peca,Coordenadas)]
organizaPecas l = organizaPecasY (organizaPecasX l 0) 0

{- | A função ’organizaPecasY’ organiza uma lista de peças de acordo com a coordenada __y__ de cada peça.

A lista é organizada de forma __crescente__.

== Exemplos de utilização:

>>> organizaPecasY [(Bloco, (1,6)), (Bloco, (1,4)), (Bloco, (2,3)), (Bloco, (2,5))] 0
[(Bloco,(2,3)), (Bloco,(1,4)), (Bloco,(2,5)), (Bloco,(1,6))]
-}

organizaPecasY :: [(Peca,Coordenadas)]
               -> Int -- ^ Input de um acumulador, de valor inicial 0, que tem como objetivo manter uma contagem crescente de __y__.
               -> [(Peca,Coordenadas)]
organizaPecasY l acc | acc <= yMax l = (filter aux l) ++ organizaPecasY l (acc+1)
                     | otherwise = [] -- caso de paragem - a lista já foi toda percorrida
                     where aux (_,(_,y)) = y == acc -- a lista de peças com Y igual ao valor atual do acumulador é filtrada (filter aux l), isto é, a lista é organizada "linha a linha".

{- | A função ’organizaPecasX’ organiza uma lista de peças de acordo com a coordenada __x__ de cada peça.

A lista é organizada de forma __crescente__.

== Exemplos de utilização:

>>> organizaPecasX [(Bloco, (1,6)), (Bloco, (1,4)), (Bloco, (2,3)), (Bloco, (2,5))] 0
[(Bloco,(1,6)),(Bloco,(1,4)),(Bloco,(2,3)),(Bloco,(2,5))]
-}

organizaPecasX :: [(Peca,Coordenadas)]
               -> Int -- ^ Input de um acumulador, de valor inicial 0, que tem como objetivo manter uma contagem crescente de __x__.
               -> [(Peca,Coordenadas)]
organizaPecasX l acc | acc <= xMax l = (filter aux l) ++ organizaPecasX l (acc+1) -- para cada X (acc), aplica 'organizaPecasX' até atingir o valor máximo de X da lista (xMax l)
                     | otherwise = [] -- caso de paragem - a lista já foi toda percorrida
                     where aux (_,(x,_)) = x == acc -- a lista de peças com X igual ao valor atual do acumulador é filtrada (filter aux l), isto é, a lista é organizada "linha a linha".

{- | A função ’listaVazios’ cria uma lista do conjunto de peças 'Vazio' não declaradas no mapa. 

Para isso, a função:

1. Lista, para cada "linha" (valor de __y__), os vazios dessa "linha" - com a ajuda da função 'listaVaziosX';
2. Concatena as listas resultantes, de forma a obter a lista completa de vazios.

== Exemplos de utilização:

>>> listaVazios [(Bloco, (0,6))] 0
[(Vazio,(0,0)),(Vazio,(0,1)),(Vazio,(0,2)),(Vazio,(0,3)),(Vazio,(0,4)),(Vazio,(0,5))]
-}

listaVazios :: [(Peca,Coordenadas)]
            -> Int -- ^ Input de um acumulador, de valor inicial 0, que tem como objetivo manter uma contagem crescente de __y__.
            -> [(Peca,Coordenadas)]
listaVazios l acc | acc <= yMax l = listaVaziosX l 0 acc ++ listaVazios l (acc+1) -- para cada Y (acc), aplica 'listaVaziosX' até atingir o valor máximo de Y da lista (yMax l)
                  | otherwise = [] -- caso de paragem - a lista já foi toda percorrida

{- | A função ’listaVaziosX’ cria uma lista com as peças 'Vazio' não declaradas numa certa "linha" do mapa (valor @y2@).

Para isso, a função:

1. Verifica, para cada coordenada dessa linha, se existe um elemento não vazio;
2. Se existir, ignora a coordenada e continua a procura;
3. Se não existir, adiciona esse elemento à lista de Output da função.

O resultado é uma lista com todas as peças 'Vazio' e as respetivas coordenadas, dessa linha.

 -}

listaVaziosX :: [(Peca,Coordenadas)] -> Int -> Int -> [(Peca,Coordenadas)]
listaVaziosX l@(a@(p,(x,y1)):t) acc y2 | acc <= xMax l = if ((elem (Bloco,(acc,y2)) l) || (elem (Caixa,(acc,y2)) l) || (elem (Porta,(acc,y2)) l) || (elem (Vazio,(acc,y2)) l))
                                                         then listaVaziosX l (acc+1) y2
                                                         else (Vazio,(acc,y2)) : listaVaziosX l (acc+1) y2
                                       | otherwise = [] -- caso de paragem - a lista já foi toda percorrida

{- | A função ’parteLista’ parte a lista de '(Peca,Coordendas)' em várias sub-listas, de acordo com a coordenada __y__.

Esta função é utilizada de modo a facilitar a função 'formata' que irá receber a lista já com as peças organizadas por __y__, em sub-listas.

Para isso, a função:

1. Para cada "linha" (valor do acumulador), cria uma sub-lista com os elementos com o valor de __y__ igual ao valor de __y__ da linha atual;
2. Enumera as listas resultantes, formando assim uma lista de listas, onde cada lista contém elementos com um valor de __y__ diferente, de forma crescente.

== Exemplos de utilização:

>>> parteLista [(Bloco,(0,0)),(Bloco,(1,0)),(Bloco, (0,1)),(Bloco, (1,1)),(Bloco,(2,1))] 0
[[(Bloco,(0,0)),(Bloco,(1,0))],[(Bloco, (0,1)),(Bloco, (1,1)),(Bloco,(2,1))]]
-}

parteLista :: [(Peca, Coordenadas)]
           -> Int -- ^ Input de um acumulador, de valor inicial 0, que tem como objetivo manter uma contagem crescente de __y__.
           -> [[(Peca, Coordenadas)]]
parteLista l acc | acc <= yMax l = (filter aux l) : parteLista l (acc+1)
                 | otherwise = [] -- caso de paragem - a lista já foi toda percorrida
                 where aux (_,(_,y)) = y == acc -- filtragem da lista de acordo com o valor atual do acumulador

{- | A função ’formata’ converte a lista recebida para o formato 'Mapa' desejado.

Para isso, a função:

1. Recebe a lista partida e organizada, resultante de @(parteLista (adicionaVazios (fundeIguais pecas)) 0)@;
2. Para cada sub-lista, retira as coordenadas dos pares '(Peca,Coordendas)', com a ajuda de 'retiraCoordenadas', criando uma lista
de sub-listas do tipo '[[Peca]]', ou seja, um 'Mapa'.

-}

formata :: [[(Peca, Coordenadas)]] -> Mapa
formata [] = [] -- caso de paragem - a função já percorreu toda a lista
formata (x:xs) = retiraCoordenadas x : formata xs -- aplica 'retiraCoordenadas' a cada sub-lista

{- | A função ’retiraCoordenadas’ remove as 'Coordenadas' de uma lista '[(Peca, Coordenadas)]'.

== Exemplos de utilização:

>>> retiraCoordenadas [(Bloco,(1,2))]
[Bloco]
-}

retiraCoordenadas :: [(Peca, Coordenadas)] -> [Peca]
retiraCoordenadas [] = [] -- caso de paragem - a função já percorreu toda a lista
retiraCoordenadas ((p,(x,y)):t) = p : retiraCoordenadas t

-- // --

{- | A função ’desconstroiMapa’ recebe um 'Mapa', ou seja, uma lista do tipo '[[Peca]]', e converte-o numa lista do tipo
'[(Peca,Coordenadas)]'.

Para isso, a função:

1. Adiciona as coordenadas de cada peça, com a ajuda da função 'converte';
2. Filtra a lista resultante, de forma a retirar todas as peças do tipo 'Vazio'.

== Exemplos de utilização:

>>> desconstroiMapa [[Vazio,Vazio],[Vazio,Vazio],[Porta,Vazio],[Bloco,Bloco]]
[(Porta,(0,2)),(Bloco,(0,3)),(Bloco,(1,3))]
-}

desconstroiMapa :: Mapa -> [(Peca, Coordenadas)]
desconstroiMapa [] = [] -- caso base
desconstroiMapa mapa = filter aux (converte mapa 0)
    where aux (p,(_,_)) = p /= Vazio -- filtra todas as peças que sejam diferentes de 'Vazio', ou seja, os vazios são removidos.

{- | A função ’converte’ adiciona as coordenadas a cada peça de um 'Mapa'.

Para isso, a função:

1. Adiciona as coordenadas das peças a cada sub-lista do Mapa, com a ajuda de 'adicionaCoordenadas';
2. Concatena as listas resultantes, de forma a criar uma lista do tipo '[(Peca,Coordenadas)]'.

-}

converte :: Mapa
         -> Int -- ^ Input de um acumulador que tem como objetivo assumir um valor de __y__ crescente
         -> [(Peca, Coordenadas)]
converte [] _ = [] -- caso de paragem - a lista já foi toda percorrida
converte (x:xs) acc = adicionaCoordenadas x 0 acc ++ converte xs (acc+1) -- aplica 'adicionaCoordenadas' para cada valores crescentes de __y__

{- | A função ’adicionaCoordenadas’ adiciona as coordenadas a uma lista de peças.

Para isso, a função:

- De acordo com o valor atual do acumulador, adiciona a coordenada __x__ de cada peça para um valor constante de __y__ (proveniente de 'converte').

== Exemplos de utilização:

>>> adicionaCoordenadas [Bloco] 1 2
[(Bloco,(1,2))]
-}

adicionaCoordenadas :: [Peca]
                    -> Int -- ^ Input de um acumulador que tem como objetivo assumir um valor de __x__ crescente
                    -> Int -- ^ Valor de __y__ proveniente de 'converte' que cresce para cada vez que ’adicionaCoordenadas’ é aplicada
                    -> [(Peca, Coordenadas)]
adicionaCoordenadas [] _ _ = [] -- caso de paragem - a lista já foi toda percorrida 
adicionaCoordenadas l@(x:xs) acc y = (x,(acc,y)) : adicionaCoordenadas xs (acc+1) y -- para cada peça da lista adiciona a sua coordenada __x__, sendo que __y__ se mantém constante