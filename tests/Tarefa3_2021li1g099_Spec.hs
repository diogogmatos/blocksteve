module Tarefa3_2021li1g099_Spec where

import Test.HUnit
import Tarefa3_2021li1g099
import Fixtures

testsT3 =
  test
    [ "Tarefa 3 - Teste Imprime Jogo m1e1" ~: "      <\n      X\n      X\nP   C X\nXXXXXXX" ~=?  show m1e1
    , "Tarefa 3 - Teste Imprime Jogo m1e2" ~: "       \n      X\n      X\nP < C X\nXXXXXXX" ~=?  show m1e2
    , "Tarefa 3 - Teste Imprime Jogo m2e1" ~: " X                 \n X   XXXXXXXXXXXXX \nX X X             X\nX  X              X\nX  C             CX\nX  >            CCX\nX XXX        XC XX \nX X X    X  XXXXX  \nX X XCC XX  X      \nXPX XXXXXX XX      \nXXX XX   XXX       " ~=?  show m2e1
    , "Tarefa 3 - Teste Imprime Jogo m1e2" ~: " X                 \n X   XXXXXXXXXXXXX \nX X X             X\nX  X              X\nX                CX\nX               CCX\nX XXX    <   XC XX \nX X X    X  XXXXX  \nX X XCC XX  X      \nXPX XXXXXX XX      \nXXX XX   XXX       " ~=?  show m2e2
    ]