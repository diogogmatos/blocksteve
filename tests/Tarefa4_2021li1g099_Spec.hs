module Tarefa4_2021li1g099_Spec where

import Test.HUnit
import LI12122
import Tarefa3_2021li1g099
import Tarefa4_2021li1g099
import Fixtures

testsT4 =
  test
    [ "Tarefa 4 - Teste Move m1e1 Oeste" ~: Jogo m1r (Jogador (5, 3) Oeste False) ~=?  moveJogador m1e1 AndarEsquerda
    , "Tarefa 4 - Teste Move m1e1 Este" ~: Jogo m1r (Jogador (6, 0) Este False) ~=?  moveJogador m1e1 AndarDireita
    , "Tarefa 4 - Teste Move m1e1 Trepar" ~: m1e1 ~=? moveJogador m1e1 Trepar
    , "Tarefa 4 - Teste Move m1e1 InterageCaixa" ~: m1e1 ~=?  moveJogador m1e1 InterageCaixa
    , "Tarefa 4 - Teste movimentos m1e1" ~: m1e2 ~=?  correrMovimentos m1e1 [AndarEsquerda, Trepar, AndarEsquerda, AndarEsquerda]
    , "Tarefa 4 - Teste movimentos m1e2 Caixa1" ~: Jogo
        [ [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
        , [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco]
        , [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco]
        , [Porta, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco]
        , [Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco]
        ]
        (Jogador (3, 3) Este True) ~=?  correrMovimentos m1e2 [AndarDireita, InterageCaixa]
    , "Tarefa 4 - Teste movimentos m1e2 Caixa2" ~:
      Jogo
        [ [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
        , [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco]
        , [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco]
        , [Porta, Caixa, Vazio, Vazio, Vazio, Vazio, Bloco]
        , [Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco]
        ]
        (Jogador (2, 3) Oeste False) ~=?  correrMovimentos m1e2 [AndarDireita, InterageCaixa, AndarEsquerda, InterageCaixa]
    , "Tarefa 4 - Teste moverJogador" ~: Jogo m2r (Jogador (10,9) Este False) ~=? moveJogador m2e2 AndarDireita
    , "Tarefa 4 - Teste AndarDireita" ~: Jogo m2r (Jogador (10,9) Este False) ~=? andarDireita [(Bloco,(0,2)),(Bloco,(0,3)),
                                                                                                (Bloco,(0,4)),(Bloco,(0,5)),
                                                                                                (Bloco,(0,6)),(Bloco,(0,7)),
                                                                                                (Bloco,(0,8)),(Bloco,(0,9)),
                                                                                                (Bloco,(0,10)),(Bloco,(1,0)),
                                                                                                (Bloco,(1,1)),(Porta,(1,9)),
                                                                                                (Bloco,(1,10)),(Bloco,(2,2)),
                                                                                                (Bloco,(2,6)),(Bloco,(2,7)),
                                                                                                (Bloco,(2,8)),(Bloco,(2,9)),
                                                                                                (Bloco,(2,10)),(Bloco,(3,3)),
                                                                                                (Bloco,(3,6)),(Bloco,(4,2)),
                                                                                                (Bloco,(4,6)),(Bloco,(4,7)),
                                                                                                (Bloco,(4,8)),(Bloco,(4,9)),
                                                                                                (Bloco,(4,10)),(Bloco,(5,1)),
                                                                                                (Caixa,(5,8)),(Bloco,(5,9)),
                                                                                                (Bloco,(5,10)),(Bloco,(6,1)),
                                                                                                (Caixa,(6,8)),(Bloco,(6,9)),
                                                                                                (Bloco,(7,1)),(Bloco,(7,9)),
                                                                                                (Bloco,(8,1)),(Bloco,(8,8)),
                                                                                                (Bloco,(8,9)),(Bloco,(9,1)),
                                                                                                (Bloco,(9,7)),(Bloco,(9,8)),
                                                                                                (Bloco,(9,9)),(Bloco,(9,10)),
                                                                                                (Bloco,(10,1)),(Bloco,(10,10)),
                                                                                                (Bloco,(11,1)),(Bloco,(11,9)),
                                                                                                (Bloco,(11,10)),(Bloco,(12,1)),
                                                                                                (Bloco,(12,7)),(Bloco,(12,8)),
                                                                                                (Bloco,(12,9)),(Bloco,(13,1)),
                                                                                                (Bloco,(13,6)),(Bloco,(13,7)),
                                                                                                (Bloco,(14,1)),(Caixa,(14,6)),
                                                                                                (Bloco,(14,7)),(Bloco,(15,1)),
                                                                                                (Bloco,(15,7)),(Bloco,(16,1)),
                                                                                                (Caixa,(16,5)),(Bloco,(16,6)),
                                                                                                (Bloco,(16,7)),(Bloco,(17,1)),
                                                                                                (Caixa,(17,4)),(Caixa,(17,5)),
                                                                                                (Bloco,(17,6)),(Bloco,(18,2)),
                                                                                                (Bloco,(18,3)),(Bloco,(18,4)),(Bloco,(18,5))] 
                                                                                                (Jogador (10,9) Oeste False)
    , "Tarefa 4 - Teste Interage Caixa" ~: Jogo m2RTesteInterageCaixa (Jogador (10,9) Este False) ~=? interageCaixa [(Bloco,(0,2)),(Bloco,(0,3)),
                                                                                                (Bloco,(0,4)),(Bloco,(0,5)),
                                                                                                (Bloco,(0,6)),(Bloco,(0,7)),
                                                                                                (Bloco,(0,8)),(Bloco,(0,9)),
                                                                                                (Bloco,(0,10)),(Bloco,(1,0)),
                                                                                                (Bloco,(1,1)),(Porta,(1,9)),
                                                                                                (Bloco,(1,10)),(Bloco,(2,2)),
                                                                                                (Bloco,(2,6)),(Bloco,(2,7)),
                                                                                                (Bloco,(2,8)),(Bloco,(2,9)),
                                                                                                (Bloco,(2,10)),(Bloco,(3,3)),
                                                                                                (Bloco,(3,6)),(Bloco,(4,2)),
                                                                                                (Bloco,(4,6)),(Bloco,(4,7)),
                                                                                                (Bloco,(4,8)),(Bloco,(4,9)),
                                                                                                (Bloco,(4,10)),(Bloco,(5,1)),
                                                                                                (Caixa,(5,8)),(Bloco,(5,9)),
                                                                                                (Bloco,(5,10)),(Bloco,(6,1)),
                                                                                                (Caixa,(6,8)),(Bloco,(6,9)),
                                                                                                (Bloco,(7,1)),(Bloco,(7,9)),
                                                                                                (Bloco,(8,1)),(Bloco,(8,8)),
                                                                                                (Bloco,(8,9)),(Bloco,(9,1)),
                                                                                                (Bloco,(9,7)),(Bloco,(9,8)),
                                                                                                (Bloco,(9,9)),(Bloco,(9,10)),
                                                                                                (Bloco,(10,1)),(Bloco,(10,10)),
                                                                                                (Bloco,(11,1)),(Bloco,(11,9)),
                                                                                                (Bloco,(11,10)),(Bloco,(12,1)),
                                                                                                (Bloco,(12,7)),(Bloco,(12,8)),
                                                                                                (Bloco,(12,9)),(Bloco,(13,1)),
                                                                                                (Bloco,(13,6)),(Bloco,(13,7)),
                                                                                                (Bloco,(14,1)),(Caixa,(14,6)),
                                                                                                (Bloco,(14,7)),(Bloco,(15,1)),
                                                                                                (Bloco,(15,7)),(Bloco,(16,1)),
                                                                                                (Caixa,(16,5)),(Bloco,(16,6)),
                                                                                                (Bloco,(16,7)),(Bloco,(17,1)),
                                                                                                (Caixa,(17,4)),(Caixa,(17,5)),
                                                                                                (Bloco,(17,6)),(Bloco,(18,2)),
                                                                                                (Bloco,(18,3)),(Bloco,(18,4)),(Bloco,(18,5))] 
                                                                                                (Jogador (10,9) Este True)
    , "Tarefa 4 - Teste Valida Trepar" ~: validaTrepar m2 (Jogador (10,9) Este False) ~=? True
    , "Tarefa 4 - Teste Valida Trepar" ~: validaTrepar m2 (Jogador (10,9) Oeste False) ~=? False
    , "Tarefa 4 - Teste moverJogador2" ~: Jogo m2r (Jogador (6,7) Oeste False) ~=? moveJogador m2e3 Trepar
    , "Tarefa 4 - Teste moverJogador2" ~: Jogo m2r (Jogador (10,9) Este False) ~=? moveJogador m2e4 InterageCaixa
    , "Tarefa 4 - Teste Jogador na Borda do Mapa Andar O" ~: Jogo m2r (Jogador (0,1) Oeste False) ~=? moveJogador m2e5 AndarEsquerda
    , "Tarefa 4 - Teste Jogador na Borda do Mapa Andar E" ~: Jogo m2r (Jogador (18,1) Este True) ~=? moveJogador m2e6 AndarDireita
    , "Tarefa 4 - Teste Jogador na Borda do Mapa Trepar O" ~: Jogo m2r (Jogador (0,1) Oeste False) ~=? moveJogador m2e7 Trepar
    , "Tarefa 4 - Teste Jogador na Borda do Mapa Trepar E" ~: Jogo m2r (Jogador (18,1) Este True) ~=? moveJogador m2e8 Trepar
    , "Tarefa 4 - Teste Jogador na Borda do Mapa InterageCaixa O" ~: Jogo m2r (Jogador (0,1) Oeste False) ~=? moveJogador m2e7 InterageCaixa
    , "Tarefa 4 - Teste Jogador na Borda do Mapa InterageCaixa E" ~: Jogo m2r (Jogador (18,1) Este True) ~=? moveJogador m2e8 InterageCaixa
    , "Tarefa 4 - Teste Trepar com uma caixa e um Bloco acima da caixa" ~: Jogo m3r (Jogador (2,2) Oeste True) ~=? moveJogador m3e1 Trepar
    , "Tarefa 4 - Teste Trepar com uma caixa em (x,1)" ~: Jogo m2r (Jogador (18,1) Oeste True) ~=? moveJogador m2e6 Trepar
    , "Tarefa 4 - Teste Trepar com uma caixa em (x,1)" ~: validaTrepar m2 (Jogador (18,1) Oeste True) ~=? False
    ]