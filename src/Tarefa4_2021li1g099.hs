{- |
Module      : Tarefa4_2021li1g099
Description : Movimentação do personagem
Copyright   : Rui Pedro Cerqueira <a100537@alunos.uminho.pt>;
            : Diogo Matos <a100741@alunos.uminho.pt>;

Módulo para a realização da Tarefa 4 do projeto de LI1 em 2021/22.
-}
module Tarefa4_2021li1g099 where

import LI12122
import Tarefa2_2021li1g099

moveJogador :: Jogo -> Movimento -> Jogo
moveJogador jogo movimento = undefined

validaMovimento :: Jogo -> Movimento -> Bool
validaMovimento (Jogo mapa jogador) m | m == Trepar = validaTrepar (desconstroiMapa mapa) jogador

validaTrepar :: [(Peca,Coordenadas)] -> Jogador -> Bool
validaTrepar m (Jogador (x,y) d b) | elem (Bloco,(x,y-1)) m = False
                                   | (d == Este) && (b == True) && validEste && (not ((elem (Bloco,(x+1,y-2)) m) || (elem (Caixa,(x+1,y-2)) m))) = True
                                   | (d == Oeste) && (b == True) && validOeste && (not ((elem (Bloco,(x-1,y-2)) m) || (elem (Caixa,(x-1,y-2)) m))) = True
                                   | (d == Este) && (b == False) && validEste = True
                                   | (d == Oeste) && (b == False) && validOeste = True
                                   | otherwise = False
                                   where validEste = (((elem (Bloco,(x+1,y)) m) || (elem (Caixa,(x+1,y)) m)) && not ((elem (Bloco,(x+1,y-1)) m) || (elem (Caixa,(x+1,y-1)) m)))
                                         validOeste = (((elem (Bloco,(x-1,y)) m) || (elem (Caixa,(x-1,y)) m)) && not ((elem (Bloco,(x-1,y-1)) m) || (elem (Caixa,(x-1,y-1)) m)))

correrMovimentos :: Jogo -> [Movimento] -> Jogo
correrMovimentos jogo movimentos = undefined