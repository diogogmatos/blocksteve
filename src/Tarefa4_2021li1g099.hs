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

moveJogador :: Jogo -> Movimento -> Jogo
moveJogador jogo@(Jogo m jogador@(Jogador (x,y) d b)) mov | (mov == Trepar) && validaMovimento jogo mov = if (d == Este)
                                                                                                          then (Jogo m (Jogador (x+1,y-1) d b))
                                                                                                          else (Jogo m (Jogador (x-1,y-1) d b))
                                                          | (mov == InterageCaixa) && validaMovimento jogo mov = interageCaixa (desconstroiMapa m) jogador
                                                          | mov == AndarDireita = andarDireita (desconstroiMapa m) jogador
                                                          | mov == AndarEsquerda = andarEsquerda (desconstroiMapa m) jogador
                                                          | otherwise = Jogo m (Jogador (x,y) d b)

--

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
--

andarDireita :: [(Peca,Coordenadas)] -> Jogador -> Jogo
andarDireita m j@(Jogador (x,y) d b) | validaAvancaDireita m j && notElem = (Jogo (constroiMapa m) (Jogador (posicaoQueda m j AndarDireita) Este b))
                                     | validaAvancaDireita m j = (Jogo (constroiMapa m) (Jogador (x+1,y) Este b))
                                     | otherwise = (Jogo (constroiMapa m) (Jogador (x,y) Este b))
                                     where notElem = not ((elem (Bloco,(x+1,y+1)) m) || (elem (Caixa,(x+1,y+1)) m))
                                           (c1,c2) = posicaoQueda m j AndarDireita

andarEsquerda :: [(Peca,Coordenadas)] -> Jogador -> Jogo
andarEsquerda m j@(Jogador (x,y) d b) | validaAvancaEsquerda m j && notElem = (Jogo (constroiMapa m) (Jogador (posicaoQueda m j AndarEsquerda) Oeste b))
                                      | validaAvancaEsquerda m j = (Jogo (constroiMapa m) (Jogador (x-1,y) Oeste b))
                                      | otherwise = (Jogo (constroiMapa m) (Jogador (x,y) Oeste b))
                                      where notElem = not ((elem (Bloco,(x-1,y+1)) m) || (elem (Caixa,(x-1,y+1)) m))
                                            (c1,c2) = posicaoQueda m j AndarEsquerda

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

validaAvancaDireita :: [(Peca,Coordenadas)] -> Jogador -> Bool
validaAvancaDireita m (Jogador (x,y) d b) | x == xMax m = False 
                                          | (b == False) && notElem = True
                                          | (b == True) && notElem && not ((elem (Bloco,(x+1,y-1)) m) || (elem (Caixa,(x+1,y-1)) m))= True
                                          | otherwise = False
                                          where notElem = not ((elem (Bloco,(x+1,y)) m)|| (elem (Caixa,(x+1,y)) m))

validaAvancaEsquerda :: [(Peca,Coordenadas)] -> Jogador -> Bool
validaAvancaEsquerda m (Jogador (x,y) d b) | x == 0 = False
                                           | (b == False) && notElem = True
                                           | (b == True) && notElem && not ((elem (Bloco,(x-1,y-1)) m) || (elem (Caixa,(x-1,y-1)) m)) = True
                                           | otherwise = False
                                           where notElem = not ((elem (Bloco,(x-1,y)) m) || (elem (Caixa,(x-1,y)) m))

--

correrMovimentos :: Jogo -> [Movimento] -> Jogo
correrMovimentos jogo [] = jogo
correrMovimentos jogo (m:ms) = correrMovimentos (moveJogador jogo m) ms