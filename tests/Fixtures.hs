module Fixtures where

import LI12122

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
        [Bloco,Bloco,Bloco,Vazio,Bloco,Bloco,Vazio,Vazio,Vazio,Bloco,Bloco,Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio]
      ]


m1e1 :: Jogo
m1e1 = Jogo m1r (Jogador (6, 0) Oeste False)

m1e2 :: Jogo
m1e2 = Jogo m1r (Jogador (2, 3) Oeste False)

m2e1 :: Jogo
m2e1 = Jogo m2r (Jogador (3,5) Este True)

m2e2 :: Jogo
m2e2 = Jogo m2r (Jogador (9,6) Oeste False)