{- |
Module      : Tarefa3_2021li1g099
Description : Representação textual do jogo
Copyright   : Rui Pedro Cerqueira <a100537@alunos.uminho.pt>;
            : Diogo Matos <a100741@alunos.uminho.pt>;

Módulo para a realização da Tarefa 3 do projeto de LI1 em 2021/22.
-}

module Tarefa3_2021li1g099 where

import LI12122

instance Show Jogo where
  show jogo = representaJogo jogo 0

representaJogo :: Jogo -> Int -> String
representaJogo (Jogo [] _) _ = ""
representaJogo (Jogo (h:t) a@(Jogador (x,y) d b)) acc | acc == y = escreveLinhaJ h x d 0 ++ (if null t then "" else "\n") ++ representaJogo (Jogo t a) (acc+1)
                                                      | acc == (y-1) && b == True = escreveLinhaC h x 0 ++ (if null t then "" else "\n") ++ representaJogo (Jogo t a) (acc+1)
                                                      | otherwise = escreveLinha h ++ (if null t then "" else "\n") ++ representaJogo (Jogo t a) (acc+1)

escreveLinha :: [Peca] -> String
escreveLinha [] = ""
escreveLinha (p:ps) | p == Vazio = " " ++ escreveLinha ps
                    | p == Bloco = "X" ++ escreveLinha ps
                    | p == Caixa = "C" ++ escreveLinha ps
                    | p == Porta = "P" ++ escreveLinha ps

escreveLinhaJ :: [Peca] -> Int -> Direcao -> Int -> String
escreveLinhaJ [] _ _ _ = ""
escreveLinhaJ (p:ps) x d acc | acc /= x = if (p == Vazio) then " " ++ escreveLinhaJ ps x d (acc+1)
                                          else if (p == Bloco) then "X" ++ escreveLinhaJ ps x d (acc+1)
                                          else if (p == Caixa) then "C" ++ escreveLinhaJ ps x d (acc+1)
                                          else "P" ++ escreveLinhaJ ps x d (acc+1)
                             | otherwise = if (d == Este) then ">" ++ escreveLinhaJ ps x d (acc+1)
                                           else "<" ++ escreveLinhaJ ps x d (acc+1)

escreveLinhaC :: [Peca] -> Int -> Int -> String
escreveLinhaC [] _ _ = ""
escreveLinhaC (p:ps) x acc | acc /= x = if (p == Vazio) then " " ++ escreveLinhaC ps x (acc+1)
                                        else if (p == Bloco) then "X" ++ escreveLinhaC ps x (acc+1)
                                        else if (p == Caixa) then "C" ++ escreveLinhaC ps x (acc+1)
                                        else "P" ++ escreveLinhaC ps x (acc+1)
                           | otherwise = "C" ++ escreveLinhaC ps x (acc+1)
