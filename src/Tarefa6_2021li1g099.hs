{- |
Module      : Tarefa6_2021li1gXXX
Description : Resolução de um puzzle

Módulo para a realização da Tarefa 6 do projeto de LI1 em 2021/22.
-}
module Tarefa6_2021li1gXXX where

import LI12122
import Tarefa1_2021li1g099
import Tarefa4_2021li1g099

resolveJogo :: Int -> Jogo -> Maybe [Movimento]
resolveJogo i jogo = undefined


--conta o numero de jogadas de todos os movimentos executados
contaJogadas :: Int -> [Movimento] -> Int
contaJogadas acc [] = acc
contaJogadas acc (x:xs) | x == Trepar = contaJogadas (acc+1) xs
                        | x == AndarEsquerda = contaJogadas (acc+1) xs
                        | x == AndarDireita = contaJogadas (acc+1) xs
                        | x == InterageCaixa = contaJogadas (acc+1) xs
                        | otherwise = contaJogadas acc xs

-- conta o numero de jogadas de um certo movimento                        
{-                   
contaJogadas :: Movimento -> Int -> [Movimento] -> Int
contaJogadas mov acc [] = acc
contaJogadas mov acc (x:xs) | x == mov = contaJogadas mov (acc+1) xs
                            | otherwise = contaJogadas mov acc xs
-}

numMaxJogadas :: Int -> [Movimento] -> Bool
numMaxJogadas x l = x >= (contaJogadas 0 l)
