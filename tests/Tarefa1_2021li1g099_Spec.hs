module Tarefa1_2021li1g099_Spec where

import Test.HUnit
import LI12122
import Tarefa1_2021li1g099
import Fixtures

-- Tarefa 1
testsT1 =
  test
    [ "Tarefa 1 - Teste Valida Mapa m1r" ~: validaPotencialMapa m1 ~=? True
    , "Tarefa 1 - Teste Valida Mapa vazio" ~: validaPotencialMapa [] ~=? False
    , "Tarefa 1 - Teste Valida Mapa com 2 portas" ~: validaPotencialMapa [(Porta, (0,0)), (Porta, (1,0))] ~=?  False
    , "Tarefa 1 - Teste Valida Mapa com uma caixa em cima de uma porta" ~: validaCaixas [(Porta, (1,1)), (Caixa, (1,2))] [(Porta, (1,1)), (Caixa, (1,2))] ~=? False
    , "Tarefa 1 - Teste Valida Mapa sem vazios" ~: validaVazios [(Bloco, (0,0)), (Bloco, (1,0)), (Bloco, (0,1)), (Caixa, (1,1))] ~=? False
    , "Tarefa 1 - Teste Valida Mapa sem chao" ~: validaPotencialMapa [(Bloco, (0,0)), (Bloco, (0,2))] ~=? False
    , "Tarefa 1 - Teste Valida Mapa com chao como teto do mapa" ~: validaPotencialMapa [(Bloco, (0,0)), (Bloco, (1,0)), (Bloco,(2,0)), (Porta,(1,1))] ~=? False
    , "Tarefa 1 - Teste Valida Mapa m2r" ~: validaPotencialMapa m2 ~=? True
    ]
