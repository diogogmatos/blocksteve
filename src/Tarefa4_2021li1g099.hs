{- |
Module      : Tarefa4_2021li1g099
Description : Movimentação do personagem
Copyright   : Rui Pedro Cerqueira <a100537@alunos.uminho.pt>;
            : Diogo Matos <a100741@alunos.uminho.pt>;

Módulo para a realização da Tarefa 4 do projeto de LI1 em 2021/22.
-}

module Tarefa4_2021li1g099 where

import LI12122
import Tarefa1_2021li1g099
import Tarefa2_2021li1g099
import Tarefa3_2021li1g099

{- | A função ’moveJogador’ verifica qual é o movimento a ser aplicado no jogador e após confirmar se o movimento é possivel, aplica o movimento.

== Exemplos de utilização:

>>> moveJogador (Jogo [[Vazio,Vazio,Vazio],[Bloco,Bloco,Bloco]] (Jogador (0,0) Este False)) AndarDireita
 > 
XXX
-}

moveJogador :: Jogo -> Movimento -> Jogo
moveJogador jogo@(Jogo m jogador@(Jogador (x,y) d b)) mov | (mov == Trepar) && validaMovimento jogo mov = if (d == Este)
                                                                                                          then (Jogo m (Jogador (x+1,y-1) d b))
                                                                                                          else (Jogo m (Jogador (x-1,y-1) d b))
                                                          | (mov == InterageCaixa) && validaMovimento jogo mov = interageCaixa (desconstroiMapa m) jogador
                                                          | mov == AndarDireita = andarDireita (desconstroiMapa m) jogador
                                                          | mov == AndarEsquerda = andarEsquerda (desconstroiMapa m) jogador
                                                          | otherwise = Jogo m (Jogador (x,y) d b)

--

{- | A função ’interageCaixa’ verifica se é possivel pegar numa caixa ou largar uma caixa, e o que acontece a caixa após o jogador interagir com a mesma.

1 - Para os casos em que o Jogador nao se encontra a segurar uma caixa, ao interagir com a caixa, a função filter vai "apagar"
a caixa com a qual o Jogador interagiu do mapa e alterar o valor de b de False para True (ou seja, informa que no estado atual
do Jogo o Jogador está a carregar uma caixa).

2 - Para os casos em que o Jogador se encontra a segurar uma caixa, ao interagir com a caixa (ou seja, ao largar a caixa), vai adicionar uma caixa ao mapa,
e alterar o valor de b de False para True (ou seja, informa que no estado atual do Jogo, o Jogador não está a segurar uma caixa).

3 - Para os casos em que o Jogador se encontra a segurar uma caixa, existe também a possibilidade de não existir um "Chão" ou Bloco onde o Jogador
possa largar a caixa, nesse caso usamos a função 'posicaoQueda' de forma semelhante ao que acontece na função 'andarDireita' ou 'andarEsquerda',
utilizamos a função 'posicaoQueda' para descobrir a posição final, não do Jogador, mas da caixa.

== Exemplos de utilização:

>>> interageCaixa [(Bloco,(0,2)),(Bloco,(1,2)),(Bloco,(2,2)),(Caixa,(1,1))] (Jogador (0,1) Este False)
C  
>  
XXX
>>> interageCaixa [(Bloco,(0,2)),(Bloco,(1,2)),(Bloco,(2,2))] (Jogador (0,1) Este True)
>C 
XXX
-}

interageCaixa :: [(Peca,Coordenadas)] -> Jogador -> Jogo
interageCaixa m j@(Jogador (x,y) d b) | (d == Este) && (b == False) = (Jogo (constroiMapa (filter aux1 m)) (Jogador (x,y) d True))
                                      | (d == Oeste) && (b == False) = (Jogo (constroiMapa (filter aux2 m)) (Jogador (x,y) d True))
                                      | (d == Este) && (b == True) && notElemD = if ((elem (Bloco,(x+1,y)) m) || (elem (Caixa,(x+1,y)) m))
                                                                                 then (Jogo (constroiMapa ((Caixa,(x+1,y-1)) : m)) (Jogador (x,y) d False))
                                                                                 else (Jogo (constroiMapa ((Caixa,(posicaoQueda m j AndarDireita)) : m)) (Jogador (x,y) d False))
                                      | (d == Oeste) && (b == True) && notElemE = if ((elem (Bloco,(x-1,y)) m) || (elem (Caixa,(x-1,y)) m))
                                                                                  then (Jogo (constroiMapa ((Caixa,(x-1,y-1)) : m)) (Jogador (x,y) d False))
                                                                                  else (Jogo (constroiMapa ((Caixa,(posicaoQueda m j AndarEsquerda)) : m)) (Jogador (x,y) d False))
                                      | (d == Este) && (b == True) = if ((elem (Bloco,(x+1,y)) m) || (elem (Caixa,(x+1,y)) m))
                                                                     then (Jogo (constroiMapa ((Caixa,(x+1,y-1)) : m)) (Jogador (x,y) d False))
                                                                     else (Jogo (constroiMapa ((Caixa,(x+1,y)) : m)) (Jogador (x,y) d False))
                                      | (d == Oeste) && (b == True) = if ((elem (Bloco,(x-1,y)) m) || (elem (Caixa,(x-1,y)) m))
                                                                      then (Jogo (constroiMapa ((Caixa,(x-1,y-1)) : m)) (Jogador (x,y) d False))
                                                                      else (Jogo (constroiMapa ((Caixa,(x-1,y)) : m)) (Jogador (x,y) d False))
                                      where aux1 p = p /= (Caixa,(x+1,y))
                                            aux2 p = p /= (Caixa,(x-1,y))
                                            notElemD = not ((elem (Bloco,(x+1,y+1)) m) || (elem (Caixa,(x+1,y+1)) m))
                                            notElemE = not ((elem (Bloco,(x-1,y+1)) m) || (elem (Caixa,(x-1,y+1)) m))

{- | A função ’andarDireita’ aplica o movimento __AndarDireita__ ao jogador.

1 - A função usa a auxiliar 'validaAvancaDireira' para verificar se é possivel executar o movimento
2 - Se não for possivel executar o movimento a direção do Jogador é alterada para Este
3 - Se for possivel ainda verifica se existe uma queda, e usa a função 'posicaoQueda' para saber as coordenadas do Jogador 

== Exemplos de utilização:

>>> andarDireita [(Bloco,(0,2)),(Bloco,(1,2)),(Bloco,(2,2)),(Caixa,(1,1))] (Jogador (0,1) Oeste False)
>C 
XXX
>>> andarDireita [(Bloco,(0,2)),(Bloco,(1,2)),(Bloco,(2,2))] (Jogador (0,1) Oeste False)
 > 
XXX
-}

andarDireita :: [(Peca,Coordenadas)] -> Jogador -> Jogo
andarDireita m j@(Jogador (x,y) d b) | validaAvancaDireita m j && notElem = (Jogo (constroiMapa m) (Jogador (posicaoQueda m j AndarDireita) Este b))
                                     | validaAvancaDireita m j = (Jogo (constroiMapa m) (Jogador (x+1,y) Este b))
                                     | otherwise = (Jogo (constroiMapa m) (Jogador (x,y) Este b))
                                     where notElem = not ((elem (Bloco,(x+1,y+1)) m) || (elem (Caixa,(x+1,y+1)) m))
                                           (c1,c2) = posicaoQueda m j AndarDireita

{- | A função ’andarEsquerda’ aplica o movimento __AndarEsquerda__ ao jogador, se o movimento não for possivel o jogador fica na mesma posição mas virado na posição Oeste.

1 - A função usa a auxiliar 'validaAvancaEsquerda' para verificar se é possivel executar o movimento
2 - Se não for possivel executar o movimento a direção do Jogador é alterada para Oeste
3 - Se for possivel ainda verifica se existe uma queda, se existir usa a função 'posicaoQueda' para saber as coordenadas do Jogador

== Exemplos de utilização:

>>> andarEsquerda [(Bloco,(0,2)),(Bloco,(1,2)),(Bloco,(2,2)),(Caixa,(1,1))] (Jogador (2,1) Este False)
 C< 
XXX
>>> andarEsquerda [(Bloco,(0,2)),(Bloco,(1,2)),(Bloco,(2,2))] (Jogador (1,1) Este False)
<  
XXX
-}

andarEsquerda :: [(Peca,Coordenadas)] -> Jogador -> Jogo
andarEsquerda m j@(Jogador (x,y) d b) | validaAvancaEsquerda m j && notElem = (Jogo (constroiMapa m) (Jogador (posicaoQueda m j AndarEsquerda) Oeste b))
                                      | validaAvancaEsquerda m j = (Jogo (constroiMapa m) (Jogador (x-1,y) Oeste b))
                                      | otherwise = (Jogo (constroiMapa m) (Jogador (x,y) Oeste b))
                                      where notElem = not ((elem (Bloco,(x-1,y+1)) m) || (elem (Caixa,(x-1,y+1)) m))
                                            (c1,c2) = posicaoQueda m j AndarEsquerda


{- | A função ’posicaoQueda’ devolve as coordenadas da peca que se vai encontrar em baixo do Jogador no caso de uma queda.

Dependendo do tipo de movimento (__AndarEsquerda__,__AndarDireita__), a função vai devolver as coordenadas da peça ( /= Vazio ) de Y menor da lista das peças (com Y superior ao do Jogador) de um certo x, o qual depende do movimento executado.

== Exemplos de utilização:

>>> posicaoQueda [(Bloco,(0,3)),(Bloco,(1,3)),(Bloco,(2,3)),(Bloco,(2,2))] (Jogador (2,1) Este False) AndarEsquerda
(1,2)
-}

posicaoQueda :: [(Peca,Coordenadas)] -> Jogador -> Movimento -> Coordenadas
posicaoQueda m (Jogador (x1,y1) d b) mov | mov == AndarDireita = (xD,yD-1)
                                         | mov == AndarEsquerda = (xE,yE-1) 
                                         where auxD (_,(x2,y2)) = (x2 == (x1+1)) && (y2 > y1)
                                               auxE (_,(x2,y2)) = (x2 == (x1-1)) && (y2 > y1)
                                               (_,(xD,yD)) = head (filter auxD m)
                                               (_,(xE,yE)) = head (filter auxE m)

--

validaMovimento :: Jogo -> Movimento -> Bool
validaMovimento (Jogo mapa jogador) m | m == Trepar = validaTrepar (desconstroiMapa mapa) jogador
                                      | m == InterageCaixa = validaInterageCaixa (desconstroiMapa mapa) jogador

{- | A função ’validaTrepar’ verifica se é possivel executar o movimento __Trepar__. 

== Exemplos de utilização:

>>> validaTrepar [(Bloco,(0,3)),(Bloco,(1,3)),(Bloco,(2,3)),(Bloco,(0,1)),(Bloco,(0,2))] (Jogador (1,2) Oeste False)
False
>>> validaTrepar [(Bloco,(0,3)),(Bloco,(1,3)),(Bloco,(2,3)),(Bloco,(0,2))] (Jogador (1,2) Oeste False)
True
-}

validaTrepar :: [(Peca,Coordenadas)] -> Jogador -> Bool
validaTrepar m (Jogador (x,y) d b) | y == 0 = False
                                   | (b == True) && y == 1 = False
                                   | elem (Bloco,(x,y-1)) m = False
                                   | (d == Este) && (b == True) && validEste && (not ((elem (Bloco,(x+1,y-2)) m) || (elem (Caixa,(x+1,y-2)) m))) = True
                                   | (d == Oeste) && (b == True) && validOeste && (not ((elem (Bloco,(x-1,y-2)) m) || (elem (Caixa,(x-1,y-2)) m))) = True
                                   | (d == Este) && (b == False) && validEste = True
                                   | (d == Oeste) && (b == False) && validOeste = True
                                   | otherwise = False
                                   where validEste = (((elem (Bloco,(x+1,y)) m) || (elem (Caixa,(x+1,y)) m)) && not ((elem (Bloco,(x+1,y-1)) m) || (elem (Caixa,(x+1,y-1)) m)))
                                         validOeste = (((elem (Bloco,(x-1,y)) m) || (elem (Caixa,(x-1,y)) m)) && not ((elem (Bloco,(x-1,y-1)) m) || (elem (Caixa,(x-1,y-1)) m)))

{- | A função ’validaInterageCaixa’ verifica se é possivel executar o movimento __InterageCaixa__. 

== Exemplos de utilização:

Também verifica o caso de o jogador se encontrar em y = 0 (borda do mapa)

>>> validaInterageCaixa [(Bloco,(0,3)),(Bloco,(1,3)),(Bloco,(2,3)),(Bloco,(0,0)),(Caixa,(0,1))] (Jogador (1,1) Oeste False)
False
-}

validaInterageCaixa :: [(Peca,Coordenadas)] -> Jogador -> Bool
validaInterageCaixa m (Jogador (x,y) d b) | y == 0 = False
                                          | elem (Bloco,(x,y-1)) m = False
                                          | (d == Este) && (b == False) && (elem (Caixa,(x+1,y)) m) && notElemEste = True
                                          | (d == Oeste) && (b == False) && (elem (Caixa,(x-1,y)) m) && notElemOeste = True
                                          | (d == Este) && (b == True) && notElemEste = True
                                          | (d == Oeste) && (b == True) && notElemOeste = True
                                          | otherwise = False
                                          where notElemEste = not ((elem (Bloco,(x+1,y-1)) m) || (elem (Caixa,(x+1,y-1)) m))
                                                notElemOeste = not ((elem (Bloco,(x-1,y-1)) m) || (elem (Caixa,(x-1,y-1)) m))

--

{- | A função ’validaAvancaDireita’ verifica se é possivel executar o movimento __AndarDireita__. 

== Exemplos de utilização:

Também verifica o caso de o jogador se encontrar na borda do mapa 

>>> validaAvancaDireita [(Bloco,(0,3)),(Bloco,(1,3)),(Bloco,(2,3)),(Bloco,(0,1)),(Bloco,(0,2)),(Bloco,(2,2))] (Jogador (1,2) Oeste False)
False
-}

validaAvancaDireita :: [(Peca,Coordenadas)] -> Jogador -> Bool
validaAvancaDireita m (Jogador (x,y) d b) | x == xMax m = False                 -- Caso o jogador se encontre na borda do mapa
                                          | (b == False) && notElem = True
                                          | (b == True) && notElem && not ((elem (Bloco,(x+1,y-1)) m) || (elem (Caixa,(x+1,y-1)) m))= True
                                          | otherwise = False
                                          where notElem = not ((elem (Bloco,(x+1,y)) m)|| (elem (Caixa,(x+1,y)) m))

{- | A função ’validaAvancaEsquerda’ verifica se é possivel executar o movimento __AndarEsquerda__. 

Também verifica o caso de o jogador se encontrar na borda do mapa

>>> validaAvancaEsquerda [(Bloco,(0,3)),(Bloco,(1,3)),(Bloco,(2,3)),(Bloco,(0,1)),(Bloco,(0,2)),(Bloco,(2,2))] (Jogador (1,2) Oeste False)
False
-}

validaAvancaEsquerda :: [(Peca,Coordenadas)] -> Jogador -> Bool
validaAvancaEsquerda m (Jogador (x,y) d b) | x == 0 = False                     -- Caso o jogador se encontre na borda do mapa
                                           | (b == False) && notElem = True
                                           | (b == True) && notElem && not ((elem (Bloco,(x-1,y-1)) m) || (elem (Caixa,(x-1,y-1)) m)) = True
                                           | otherwise = False
                                           where notElem = not ((elem (Bloco,(x-1,y)) m) || (elem (Caixa,(x-1,y)) m))

--

{- | A função ’correrMovimentos’ aplica uma sequencia de movimentos chamando a função 'moveJogador'.

== Exemplos de utilização:

>>> correrMovimentos (Jogo [[Vazio,Vazio,Vazio],[Bloco,Bloco,Bloco]] (Jogador (0,0) Este False)) [AndarDireita,AndarDireita]
  >
XXX
-}

correrMovimentos :: Jogo -> [Movimento] -> Jogo
correrMovimentos jogo [] = jogo
correrMovimentos jogo (m:ms) = correrMovimentos (moveJogador jogo m) ms