module Fixtures where

import LI12122
import ListaJogos
import Tarefa1_2021li1g099
import Tarefa2_2021li1g099
import Tarefa4_2021li1g099
import Tarefa6_2021li1g099

m1 :: [(Peca, Coordenadas)]
m1 =
  [ (Porta, (0, 3)),
    (Bloco, (0, 4)),
    (Bloco, (1, 4)),
    (Bloco, (2, 4)),
    (Bloco, (3, 4)),
    (Bloco, (4, 4)),
    (Caixa, (4, 3)),
    (Bloco, (5, 4)),
    (Bloco, (6, 4)),
    (Bloco, (6, 3)),
    (Bloco, (6, 2)),
    (Bloco, (6, 1))
  ]

m1r :: Mapa
m1r =
  [ [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio],
    [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco],
    [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco],
    [Porta, Vazio, Vazio, Vazio, Caixa, Vazio, Bloco],
    [Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco]
  ]

m2 :: [(Peca, Coordenadas)]
m2 =
  [ (Bloco,(0,2)),
    (Bloco,(0,3)),
    (Bloco,(0,4)),
    (Bloco,(0,5)),
    (Bloco,(0,6)),
    (Bloco,(0,7)),
    (Bloco,(0,8)),
    (Bloco,(0,9)),
    (Bloco,(0,10)),
    (Bloco,(1,0)),
    (Bloco,(1,1)),
    (Porta,(1,9)),
    (Bloco,(1,10)),
    (Bloco,(2,2)),
    (Bloco,(2,6)),
    (Bloco,(2,7)),
    (Bloco,(2,8)),
    (Bloco,(2,9)),
    (Bloco,(2,10)),
    (Bloco,(3,3)),
    (Bloco,(3,6)),
    (Bloco,(4,2)),
    (Bloco,(4,6)),
    (Bloco,(4,7)),
    (Bloco,(4,8)),
    (Bloco,(4,9)),
    (Bloco,(4,10)),
    (Bloco,(5,1)),
    (Caixa,(5,8)),
    (Bloco,(5,9)),
    (Bloco,(5,10)),
    (Bloco,(6,1)),
    (Caixa,(6,8)),
    (Bloco,(6,9)),
    (Bloco,(7,1)),
    (Bloco,(7,9)),
    (Bloco,(8,1)),
    (Bloco,(8,8)),
    (Bloco,(8,9)),
    (Bloco,(9,1)),
    (Bloco,(9,7)),
    (Bloco,(9,8)),
    (Bloco,(9,9)),
    (Bloco,(9,10)),
    (Bloco,(10,1)),
    (Bloco,(10,10)),
    (Bloco,(11,1)),
    (Bloco,(11,9)),
    (Bloco,(11,10)),
    (Bloco,(12,1)),
    (Bloco,(12,7)),
    (Bloco,(12,8)),
    (Bloco,(12,9)),
    (Bloco,(13,1)),
    (Bloco,(13,6)),
    (Bloco,(13,7)),
    (Bloco,(14,1)),
    (Caixa,(14,6)),
    (Bloco,(14,7)),
    (Bloco,(15,1)),
    (Bloco,(15,7)),
    (Bloco,(16,1)),
    (Caixa,(16,5)),
    (Bloco,(16,6)),
    (Bloco,(16,7)),
    (Bloco,(17,1)),
    (Caixa,(17,4)),
    (Caixa,(17,5)),
    (Bloco,(17,6)),
    (Bloco,(18,2)),
    (Bloco,(18,3)),
    (Bloco,(18,4)),
    (Bloco,(18,5))
  ]

m2TesteInterageCaixa :: [(Peca, Coordenadas)]
m2TesteInterageCaixa =
  [ (Bloco,(0,2)),
    (Bloco,(0,3)),
    (Bloco,(0,4)),
    (Bloco,(0,5)),
    (Bloco,(0,6)),
    (Bloco,(0,7)),
    (Bloco,(0,8)),
    (Bloco,(0,9)),
    (Bloco,(0,10)),
    (Bloco,(1,0)),
    (Bloco,(1,1)),
    (Porta,(1,9)),
    (Bloco,(1,10)),
    (Bloco,(2,2)),
    (Bloco,(2,6)),
    (Bloco,(2,7)),
    (Bloco,(2,8)),
    (Bloco,(2,9)),
    (Bloco,(2,10)),
    (Bloco,(3,3)),
    (Bloco,(3,6)),
    (Bloco,(4,2)),
    (Bloco,(4,6)),
    (Bloco,(4,7)),
    (Bloco,(4,8)),
    (Bloco,(4,9)),
    (Bloco,(4,10)),
    (Bloco,(5,1)),
    (Caixa,(5,8)),
    (Bloco,(5,9)),
    (Bloco,(5,10)),
    (Bloco,(6,1)),
    (Caixa,(6,8)),
    (Bloco,(6,9)),
    (Bloco,(7,1)),
    (Bloco,(7,9)),
    (Bloco,(8,1)),
    (Bloco,(8,8)),
    (Bloco,(8,9)),
    (Bloco,(9,1)),
    (Bloco,(9,7)),
    (Bloco,(9,8)),
    (Bloco,(9,9)),
    (Bloco,(9,10)),
    (Bloco,(10,1)),
    (Bloco,(10,10)),
    (Bloco,(11,1)),
    (Caixa,(11,8)),
    (Bloco,(11,9)),
    (Bloco,(11,10)),
    (Bloco,(12,1)),
    (Bloco,(12,7)),
    (Bloco,(12,8)),
    (Bloco,(12,9)),
    (Bloco,(13,1)),
    (Bloco,(13,6)),
    (Bloco,(13,7)),
    (Bloco,(14,1)),
    (Caixa,(14,6)),
    (Bloco,(14,7)),
    (Bloco,(15,1)),
    (Bloco,(15,7)),
    (Bloco,(16,1)),
    (Caixa,(16,5)),
    (Bloco,(16,6)),
    (Bloco,(16,7)),
    (Bloco,(17,1)),
    (Caixa,(17,4)),
    (Caixa,(17,5)),
    (Bloco,(17,6)),
    (Bloco,(18,2)),
    (Bloco,(18,3)),
    (Bloco,(18,4)),
    (Bloco,(18,5))
  ]

m2r :: Mapa
m2r = [ [Vazio,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],
        [Vazio,Bloco,Vazio,Vazio,Vazio,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Vazio],
        [Bloco,Vazio,Bloco,Vazio,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco],
        [Bloco,Vazio,Vazio,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco],
        [Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Caixa,Bloco],
        [Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Caixa,Caixa,Bloco],
        [Bloco,Vazio,Bloco,Bloco,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco,Caixa,Vazio,Bloco,Bloco,Vazio],
        [Bloco,Vazio,Bloco,Vazio,Bloco,Vazio,Vazio,Vazio,Vazio,Bloco,Vazio,Vazio,Bloco,Bloco,Bloco,Bloco,Bloco,Vazio,Vazio],
        [Bloco,Vazio,Bloco,Vazio,Bloco,Caixa,Caixa,Vazio,Bloco,Bloco,Vazio,Vazio,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],
        [Bloco,Porta,Bloco,Vazio,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Vazio,Bloco,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],
        [Bloco,Bloco,Bloco,Vazio,Bloco,Bloco,Vazio,Vazio,Vazio,Bloco,Bloco,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio]]

m2RTesteInterageCaixa :: Mapa
m2RTesteInterageCaixa = [ [Vazio,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],
                          [Vazio,Bloco,Vazio,Vazio,Vazio,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Vazio],
                          [Bloco,Vazio,Bloco,Vazio,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco],
                          [Bloco,Vazio,Vazio,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco],
                          [Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Caixa,Bloco],
                          [Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Caixa,Caixa,Bloco],
                          [Bloco,Vazio,Bloco,Bloco,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco,Caixa,Vazio,Bloco,Bloco,Vazio],
                          [Bloco,Vazio,Bloco,Vazio,Bloco,Vazio,Vazio,Vazio,Vazio,Bloco,Vazio,Vazio,Bloco,Bloco,Bloco,Bloco,Bloco,Vazio,Vazio],
                          [Bloco,Vazio,Bloco,Vazio,Bloco,Caixa,Caixa,Vazio,Bloco,Bloco,Vazio,Caixa,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],
                          [Bloco,Porta,Bloco,Vazio,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Vazio,Bloco,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],
                          [Bloco,Bloco,Bloco,Vazio,Bloco,Bloco,Vazio,Vazio,Vazio,Bloco,Bloco,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio]]

m3r :: Mapa
m3r = [ [Vazio,Vazio,Bloco,Vazio],
        [Vazio,Vazio,Vazio,Vazio],
        [Vazio,Bloco,Vazio,Vazio],
        [Bloco,Bloco,Bloco,Bloco]]

m1e1 :: Jogo
m1e1 = Jogo m1r (Jogador (6, 0) Oeste False)

m1e2 :: Jogo
m1e2 = Jogo m1r (Jogador (2, 3) Oeste False)

m2e1 :: Jogo
m2e1 = Jogo m2r (Jogador (3,5) Este True)

m2e2 :: Jogo
m2e2 = Jogo m2r (Jogador (9,6) Oeste False)

m2e3 :: Jogo
m2e3 = Jogo m2r (Jogador (7,8) Oeste False)

m2e4 :: Jogo
m2e4 = Jogo m2r (Jogador (10,9) Este False)

m2e5 :: Jogo
m2e5 = Jogo m2r (Jogador (0,1) Este False)

m2e6 :: Jogo
m2e6 = Jogo m2r (Jogador (18,1) Oeste True)

m2e7 :: Jogo
m2e7 = Jogo m2r (Jogador (0,1) Oeste False)

m2e8 :: Jogo
m2e8 = Jogo m2r (Jogador (18,1) Este True)

m3e1 :: Jogo
m3e1 = Jogo m3r (Jogador (2,2) Oeste True)


je1 :: Mapa
je1 = [[Vazio,Vazio,Vazio,Vazio,Vazio],
       [Porta,Vazio,Vazio,Vazio,Vazio],
       [Bloco,Bloco,Bloco,Bloco,Bloco]]
      
je2 :: [(Peca,Coordenadas)]
je2 = [(Porta,(0,1)),(Bloco,(0,2)),(Bloco,(1,2)),(Bloco,(2,2)),(Bloco,(3,2)),(Bloco,(4,2))]

jt1 :: Mapa
jt1 = [[Vazio,Vazio,Vazio,Vazio,Vazio],
       [Porta,Vazio,Bloco,Vazio,Vazio],
       [Bloco,Bloco,Bloco,Bloco,Bloco]]
      
jt2 :: [(Peca,Coordenadas)]
jt2 = [(Porta,(0,1)),(Bloco,(2,1)),(Bloco,(0,2)),(Bloco,(1,2)),(Bloco,(2,2)),(Bloco,(3,2)),(Bloco,(4,2))]

jl1 :: Mapa
jl1 = [[Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco],
      [Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco],
      [Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco],
      [Bloco,Vazio,Vazio,Vazio,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco],
      [Bloco,Porta,Vazio,Vazio,Bloco,Vazio,Vazio,Vazio,Bloco,Vazio,Caixa,Vazio,Bloco,Caixa,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco],
      [Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco,Bloco]]

j1e1 :: Jogo
j1e1 = Jogo jl1 (Jogador (1,4) Oeste False)

nextLevel :: Int -> Jogo -> Int
nextLevel n (Jogo m (Jogador (x1,y1) _ _)) | x1 == x2 && y1 == y2 = n+1
                                           | otherwise = n
                                           where aux (p,(_,_)) = p == Porta
                                                 (x2,y2) = giveCoordinates $ head $ filter aux $ desconstroiMapa m
                                                 giveCoordinates (p,c) = c