module Tarefa2_2021li1g099_Spec where

import Data.List (sort)
import Test.HUnit
import LI12122
import Tarefa2_2021li1g099
import Fixtures

testsT2 =
  test
    [ "Tarefa 2 - Teste Construir Mapa m1" ~: m1r ~=? constroiMapa m1
    , "Tarefa 2 - Teste Construir Mapa vazio" ~: [] ~=? constroiMapa []
    , "Tarefa 2 - Teste Desconstruir Mapa m1" ~: sort m1 ~=?  sort (desconstroiMapa m1r)
    , "Tarefa 2 - Teste Desconstruir Mapa vazio" ~: [] ~=? desconstroiMapa []
    , "Tarefa 2 - Teste Identidade m1" ~: sort m1 ~=?  sort (desconstroiMapa (constroiMapa m1))
    , "Tarefa 2 - Teste Identidade m1r" ~: m1r ~=?  constroiMapa (desconstroiMapa m1r)
    , "Tarefa 2 - Teste Construir Sobrepor Peças" ~: constroiMapa [(Porta, (7, 4))] ~=?  constroiMapa [(Porta, (7, 4)), (Porta, (7, 4))]
    , "Tarefa 2 - Teste Construir Mapa m2" ~: m2r ~=? constroiMapa m2
    , "Tarefa 2 - Teste Desconstruir Mapa m2" ~: sort m2 ~=?  sort (desconstroiMapa m2r)
    , "Tarefa 2 - Teste Identidade m2" ~: sort m2 ~=?  sort (desconstroiMapa (constroiMapa m2))
    , "Tarefa 2 - Teste Identidade m2r" ~: m2r ~=?  constroiMapa (desconstroiMapa m2r)
    , "Tarefa 2 - Teste Adicionar Vazios a Lista" ~: [ (Vazio,(0,0)),(Vazio,(1,0)),
                                                       (Vazio,(2,0)),(Vazio,(3,0)),
                                                       (Vazio,(4,0)),(Vazio,(5,0)),
                                                       (Vazio,(6,0)),(Vazio,(0,1)),
                                                       (Vazio,(1,1)),(Vazio,(2,1)),
                                                       (Vazio,(3,1)),(Vazio,(4,1)),
                                                       (Vazio,(5,1)),(Bloco,(6,1)),
                                                       (Vazio,(0,2)),(Vazio,(1,2)),
                                                       (Vazio,(2,2)),(Vazio,(3,2)),
                                                       (Vazio,(4,2)),(Vazio,(5,2)),
                                                       (Bloco,(6,2)),(Porta,(0,3)),
                                                       (Vazio,(1,3)),(Vazio,(2,3)),
                                                       (Vazio,(3,3)),(Caixa,(4,3)),
                                                       (Vazio,(5,3)),(Bloco,(6,3)),
                                                       (Bloco,(0,4)),(Bloco,(1,4)),
                                                       (Bloco,(2,4)),(Bloco,(3,4)),
                                                       (Bloco,(4,4)),(Bloco,(5,4)),
                                                       (Bloco,(6,4))
                                                     ] ~=? adicionaVazios m1
    ]