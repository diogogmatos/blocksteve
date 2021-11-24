{- |
Module      : Tarefa1_2021li1g099
Description : Validação de um potencial mapa
Copyright   : Rui Pedro Cerqueira <a100537@alunos.uminho.pt>;
            : Diogo Matos <a100741@alunos.uminho.pt>;

Módulo para a realização da Tarefa 1 do projeto de LI1 em 2021/22.
-}

module Tarefa1_2021li1g099 where

import LI12122

{- | A função ’validaPotencialMapa’ aplica as funções 'validaPosicoes', 'validaPorta', 'validaVazios', 'validaCaixas' e 'validaChao' a um
potencial mapa, verificando assim se cumpre todos os requisitos. -}

validaPotencialMapa :: [(Peca, Coordenadas)] -- ^ Input de um potencial mapa, constituído por pares '(Peca, Coordenadas)'
                    -> Bool -- ^ Output booleano (True - mapa válido, False - mapa inválido)
validaPotencialMapa [] = False
validaPotencialMapa x = validaPosicoes x && validaPorta x && validaVazios x && validaCaixas x x && validaChao x 0

-- 1

{- | A função ’validaPosicoes’ verifica se existem peças com posições equivalentes, o que não pode acontecer para termos um mapa válido.

== Exemplos de utilização:

>>> validaPosicoes [(Bloco, (1,1)), Porta, (1,1)]
False
>>> validaPosicoes [(Bloco, (1,1)), Porta, (2,4)]
True
-}

validaPosicoes :: [(Peca, Coordenadas)] -> Bool
validaPosicoes [] = True
validaPosicoes ((p,c):t) = validaC c t && validaPosicoes t -- 'validaC' é chamada como auxiliar para cada elemento da lista

{- | A função ’validaC’ compara uma das coordenadas do potencial mapa a toda a cauda da lista, de modo a verificar se é equivalente a uma delas. 

Esta função funciona como auxiliar de 'validaPosicoes'.

== Exemplos de utilização

>>> validaC (1,1) [(Bloco,(1,1)),(Porta,(1,2))]
False
>>> validaC (1,1) [(Bloco,(1,2)),(Porta,(1,4))]
True
-}

validaC :: Coordenadas -> [(Peca, Coordenadas)] -> Bool
validaC _ [] = True
validaC c@(x1,y1) ((p1,(x2,y2)):t) | x1 == x2 && y1 == y2 = False
                                   | otherwise = validaC c t

-- 2 & 4

{- | A função ’validaPorta’ verifica se existe uma porta no mapa e se esta é única.

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

Como as peças "Vazio" podem não ser declaradas, o comprimento da lista é comparado ao número de peças que o mapa dado deve ter, número este 
que é calculado com a ajuda de 'xMax' e 'yMax'.

Podemos observar abaixo como esta comparação é feita:

__@length l /= ((xMax l + 1) * (yMax l + 1))@__

== Exemplos de utilização:

>>> validaVazio[(Bloco, (0,0)), (Porta, (0,1))]
False
>>> validaVazio [(Vazio, (1,1)), (Caixa, (1,2))]
True
-}

validaVazios :: [(Peca,Coordenadas)] -> Bool
validaVazios l = ((contaPecas Vazio 0 l) >= 1) || (length l /= ((xMax l + 1) * (yMax l + 1)))

{- | A função ’contaPecas’ conta quantas peças existem de um dado tipo numa lista. 

É utilizada como auxilidar em 'validaPorta' e 'validaVazios' de modo a contar o número de Portas e Vazios, respetivamente. -}

contaPecas :: Peca -> Int -> [(Peca,Coordenadas)] -> Int
contaPecas peca acc [] = acc
contaPecas peca acc ((p,c):t) | p == peca = contaPecas peca (acc+1) t
                              | otherwise = contaPecas peca acc t

{- | A função ’xMax’ dá-nos o valor Máximo de X de uma lista do tipo '[(Peca,Coordenadas)]'. -}

xMax :: [(Peca,Coordenadas)] -> Int
xMax [(_,(x,_))] = x
xMax ((_,(x,_)):t) = max x (xMax t)

{- | A função ’yMax’ dá-nos o valor Máximo de Y de uma lista do tipo '[(Peca,Coordenadas)]'. -}

yMax :: [(Peca,Coordenadas)] -> Int
yMax [(_,(_,y))] = y
yMax ((_,(_,y)):t) = max y (yMax t)

-- 3

{- | A função ’validaCaixas’ verifica se uma caixa se encontra em cima de outra caixa ou de um bloco.

== Exemplos de utilização:

>>> validaCaixas [(Bloco, (0,3)), (Caixa, (0,2))]
True
>>> validaCaixas [(Bloco, (0,3)), (Caixa, (1,3))]
False
-}

validaCaixas :: [(Peca,Coordenadas)] -> [(Peca,Coordenadas)] -> Bool
validaCaixas [] _ = True
validaCaixas l1@((p,c):t) l2 | p == Caixa && not (on c l2) = False -- se 'on' não se verifica, significa que a caixa está numa posição inválida (False)
                             | p == Caixa && on c l2 = validaCaixas t l2 -- se a caixa está válida, então continua a procura por uma caixa inválida
                             | otherwise = validaCaixas t l2 -- se a peça não é "Caixa" então é ignorada

{- | A função ’on’ verifica, dadas as coordenadas de uma caixa, se a peça em baixo da mesma é válida, isto é, se é "Bloco" ou "Caixa". -}

on :: Coordenadas -- ^ Input das coordenadas de uma das caixas de um potencial mapa
      -> [(Peca,Coordenadas)] -> Bool
on _ [] = True
on (x,y) l | elem (Bloco,(x,y+1)) l = True
           | elem (Caixa,(x,y+1)) l = True
           | otherwise = False

-- 5

{- | A função ’validaChao’ verifica se existe um chão contínuo (sem falhas) de blocos, da esquerda à direita do mapa. 

Esta análise ocorre gradualmente de coluna a coluna, da seguinte forma:

1. Para cada coluna do mapa, é chamada a função 'validaLigacao' com as coordenadas da peça "Bloco" de maior Y da coluna atual e da coluna seguinte;
2. Se a ligação for considerada válida por 'validaLigacao', a função prossegue para a coluna seguinte. Caso contrário, significa que foi detetada
uma falha, pelo que o chão é inválido (False).

Se 'validaLigacao' nunca devolver um valor False, significa que não foram detetadas falhas em nenhum ponto e o chão do mapa é válido.

== Exemplos de utilização:

>>> validaChao [(Bloco, (0,3)), (Caixa, (1,3))]
False
>>> validaChao [(Bloco, (0,3)), (Bloco, (1,3))]
True
-}

validaChao :: [(Peca,Coordenadas)]
           -> Int -- ^ Input de um acumulador (inicialmente 0), que tem como objetivo assumir o valor da coluna do mapa que está a ser analisada pela função no momento. 
           -> Bool
validaChao l acc | not (elem (Bloco,(acc,yMax (filter aux1 l))) l) = False -- se a peça com maior Y da coluna não for "Bloco" existe um "buraco", pelo que o mapa é inválido (False)
                 | acc == xMax l = True -- se a função atinge a última coluna, então não foram encontradas falhas e o mapa é válido (True)
                 | (acc < xMax l) && validaLigacao (acc,yMax (filter aux1 l)) (acc+1, yMax (filter aux2 l)) l && validaChao l (acc+1) = True
                 | otherwise = False
                 where aux1 (_,(x,_)) = x == acc
                       aux2 (_,(x,_)) = x == acc+1

{- | A função ’validaLigacao’ verifica se existe uma ligação válida entre o bloco de maior Y de uma coluna e o bloco de maior Y da coluna
   seguinte. Para isso, a função:
   
1. Para cada bloco, avalia as opções de "movimento", isto é, se existem blocos em posições relevantes para a ligação, e escolhe aquela que
se aproxima do bloco de destino;
2. Assume a coordenada da opção escolhida e repete o processo até que a coordenada corresponda à coordeanda do bloco de destino.

Se ao longo destes passos não existirem falhas, como a inexistência de opções de "movimento" (conexão entre os dois blocos impossível),
a "ligação" é considerada válida. Caso contrário, inválida.
   
== Exemplos de utilização:

>>> validaLigacao (0,1) (2,1) [(Bloco,(0,1)),(Bloco,(1,1)),(Bloco,(2,1))]
True
-}

validaLigacao :: Coordenadas -- ^ Coordenadas da peça "Bloco" com maior Y da coluna atual
              -> Coordenadas -- ^ Coordenadas da peça "Bloco" com maior Y da coluna em seguida
              -> [(Peca,Coordenadas)] -- ^ Potencial mapa
              -> Bool
validaLigacao (x1,y1) b@(x2,y2) l | (x1 == x2) && (y1 == y2) = True
                                  | elem (Bloco,(x1,y1-1)) l && (abs (y2 - y1) >= abs (y2 - (y1-1))) = validaLigacao (x1,y1-1) b l
                                  | elem (Bloco,(x1+1,y1-1)) l && (abs (y2 - y1) >= abs (y2 - (y1-1))) && (abs (x2 - x1) >= abs (x2 - (x1+1))) = validaLigacao (x1+1,y1-1) b l
                                  | elem (Bloco,(x1+1,y1)) l && (abs (x2 - x1) >= abs (x2 - (x1+1))) = validaLigacao (x1+1,y1) b l
                                  | elem (Bloco,(x1+1,y1+1)) l && (abs (y2 - y1) >= abs (y2 - (y1+1))) && (abs (x2 - x1) >= abs (x2 - (x1+1))) = validaLigacao (x1+1,y1+1) b l
                                  | elem (Bloco,(x1,y1+1)) l && (abs (y2 - y1) >= abs (y2 - (y1+1))) = validaLigacao (x1,y1+1) b l
                                  | otherwise = False