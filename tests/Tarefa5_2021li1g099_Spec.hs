module Tarefa5_2021li1g099_Spec where

import Test.HUnit
import Tarefa1_2021li1g099
import Tarefa2_2021li1g099
import Tarefa4_2021li1g099
import Tarefa6_2021li1g099
import Fixtures

testsT5 =
  test
    [ "Tarefa 5 - Teste nextLevel" ~: nextLevel 1 j1e1 ~=? 2
    ]
