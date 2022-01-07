module Tarefa6_2021li1g099_Spec where

import Test.HUnit
import Data.List
import LI12122
import Tarefa1_2021li1g099
import Tarefa2_2021li1g099
import Tarefa4_2021li1g099
import Tarefa6_2021li1g099
import Fixtures

testsT6 =
  test
    [ "Tarefa 6 - Teste resolveSemCaixas" ~: resolveSemCaixas 4 je2 (Jogador (4,1) Oeste False) ~=? [AndarEsquerda,AndarEsquerda,AndarEsquerda,AndarEsquerda]
    , "Tarefa 6 - Teste resolveSemCaixas" ~: resolveSemCaixas 4 jt2 (Jogador (4,1) Oeste False)~=? [AndarEsquerda,Trepar,AndarEsquerda,AndarEsquerda]
    ]

