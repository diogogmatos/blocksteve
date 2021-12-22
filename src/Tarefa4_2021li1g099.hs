{- |
Module      : Tarefa4_2021li1g099
Description : Movimentação do personagem
Copyright   : Rui Pedro Cerqueira <a100537@alunos.uminho.pt>;
            : Diogo Matos <a100741@alunos.uminho.pt>;

Módulo para a realização da Tarefa 4 do projeto de LI1 em 2021/22.
-}

module Tarefa4_2021li1g099 where

import LI12122
import Tarefa1_2021li1g099
import Tarefa2_2021li1g099
import Tarefa3_2021li1g099

{- | A função ’moveJogador’ aplica um dado movimento ao 'Jogador', alterando assim o estado atual do 'Jogo'.

Para isso, a função:

1. Verifica qual é o movimento a ser aplicado;
2. Verifica se o movimento é válido (exceto para AndarDireita ou AndarEsquerda, uma vez que tais movimentos são sempre válidos),
recorrendo à função 'validaMovimento';
3. Se o movimento é válido, aplica-o ao 'Jogo' usando a função 'interageCaixa', 'andarDireita' ou 'andarEsquerda'. Exceto para o movimento 'Trepar',
que é aplicado diretamente sem recorrer a uma função auxiliar, tendo em conta a sua simplicidade.

- __Nota:__ As funções auxiliares 'interageCaixa', 'andarDireita' e 'andarEsquerda' recebem o mapa não no formato 'Mapa' mas no formato de uma lista
do tipo __[(Peca,Coordeandas)]__, de forma a facilitar o processo. Assim, é usada a função 'desconstroiMapa' (importada da Tarefa 2) para transformar 'Mapa'.

== Exemplos de utilização:

>>> moveJogador (Jogo [[Vazio,Vazio,Vazio],[Bloco,Bloco,Bloco]] (Jogador (0,0) Este False)) AndarDireita
 > 
XXX
-}

moveJogador :: Jogo -> Movimento -> Jogo
moveJogador jogo@(Jogo m jogador@(Jogador (x,y) d b)) mov | mov == Trepar && validaMovimento jogo mov = if d == Este
                                                                                                        then Jogo m (Jogador (x+1,y-1) d b)
                                                                                                        else Jogo m (Jogador (x-1,y-1) d b)
                                                          | mov == InterageCaixa && validaMovimento jogo mov = interageCaixa (desconstroiMapa m) jogador
                                                          | mov == AndarDireita = andarDireita (desconstroiMapa m) jogador
                                                          | mov == AndarEsquerda = andarEsquerda (desconstroiMapa m) jogador
                                                          | otherwise = Jogo m (Jogador (x,y) d b)

--

{- | A função ’interageCaixa’ aplica ao Jogo a ação de pegar ou largar uma Caixa por parte do Jogador.

Para isso, a função:

1. Para os casos em que o Jogador não se encontra a segurar uma caixa (@b == False@), a função filter vai "apagar" do Mapa a caixa com a qual o Jogador interagiu 
e alterar o valor __b__ de __False__ para __True__ (ou seja, informa que no estado atual do Jogo o Jogador está a carregar uma caixa);

2. Para os casos em que o Jogador se encontra a segurar uma caixa (@b == True@), a função vai adicionar a mesma ao Mapa (de acordo com a Direção do Jogador)
e alterar o valor __b__ de __True__ para __False__ (ou seja, informa que no estado atual do Jogo, o Jogador não está a carregar uma caixa);

3. Para os casos em que o Jogador carrega/segura uma caixa, existe também a possibilidade de exisitir uma queda na direção em que a caixa vai ser
largada. Nesse caso, usamos a função 'posicaoQueda', de forma semelhante ao que acontece na função 'andarDireita' ou 'andarEsquerda', para descobrir a posição final,
 não do Jogador, mas da caixa.

- __Nota:__ Para todos os casos onde o jogador carrega uma caixa, é também verificado se existe um Bloco em frente ao Jogador. Se tal Bloco existir,
a Caixa será posicionada nas coordenadas acima desse Bloco, e não na mesma posição do Bloco como acontece normalmente.

== Exemplos de utilização:

>>> interageCaixa [(Bloco,(0,2)),(Bloco,(1,2)),(Bloco,(2,2)),(Caixa,(1,1))] (Jogador (0,1) Este False)
C  
>  
XXX
>>> interageCaixa [(Bloco,(0,2)),(Bloco,(1,2)),(Bloco,(2,2))] (Jogador (0,1) Este True)

>C 
XXX
-}

interageCaixa :: [(Peca,Coordenadas)] -> Jogador -> Jogo
interageCaixa m j@(Jogador (x,y) d b) | d == Este && not b = Jogo (constroiMapa (filter aux1 m)) (Jogador (x,y) d True) -- caso (1.)
                                      | d == Oeste && not b = Jogo (constroiMapa (filter aux2 m)) (Jogador (x,y) d True) -- caso (1.)
                                      | d == Este && notElemD = if elem (Bloco,(x+1,y)) m || elem (Caixa,(x+1,y)) m -- caso (3.) | Ver "Nota"
                                                                then Jogo (constroiMapa ((Caixa,(x+1,y-1)) : m)) (Jogador (x,y) d False)
                                                                else Jogo (constroiMapa ((Caixa,posicaoQueda m j AndarDireita) : m)) (Jogador (x,y) d False)
                                      | d == Oeste && notElemE = if elem (Bloco,(x-1,y)) m || elem (Caixa,(x-1,y)) m -- caso (3.) | Ver "Nota"
                                                                 then Jogo (constroiMapa ((Caixa,(x-1,y-1)) : m)) (Jogador (x,y) d False)
                                                                 else Jogo (constroiMapa ((Caixa,posicaoQueda m j AndarEsquerda) : m)) (Jogador (x,y) d False)
                                      | d == Este = if elem (Bloco,(x+1,y)) m || elem (Caixa,(x+1,y)) m -- caso (2.) | Ver "Nota"
                                                    then Jogo (constroiMapa ((Caixa,(x+1,y-1)) : m)) (Jogador (x,y) d False)
                                                    else Jogo (constroiMapa ((Caixa,(x+1,y)) : m)) (Jogador (x,y) d False)
                                      | d == Oeste = if elem (Bloco,(x-1,y)) m || elem (Caixa,(x-1,y)) m -- caso (2.) | Ver "Nota"
                                                     then Jogo (constroiMapa ((Caixa,(x-1,y-1)) : m)) (Jogador (x,y) d False)
                                                     else Jogo (constroiMapa ((Caixa,(x-1,y)) : m)) (Jogador (x,y) d False)
                                      where aux1 p = p /= (Caixa,(x+1,y))
                                            aux2 p = p /= (Caixa,(x-1,y))
                                            notElemD = not (elem (Bloco,(x+1,y+1)) m || elem (Caixa,(x+1,y+1)) m)
                                            notElemE = not (elem (Bloco,(x-1,y+1)) m || elem (Caixa,(x-1,y+1)) m)

{- | A função ’andarDireita’ aplica o movimento __AndarDireita__ ao jogador.

Para isso, a função:

1. Aplica a função auxiliar 'validaAvancaDireita' para verificar se é possível fazer o Jogador avançar para a direita (Este);
2. Se não for possivel avançar, as coordenadas do Jogador mantém-se e apenas a direção é alterada (para Este);
3. Se for possivel avançar, verifica ainda se existe uma queda (@notElem@) e, caso exista, aplica a função 'posicaoQueda' para determinar as coordenadas da posição do
Jogador após a queda. Caso não exista queda, simplesmente move o Jogador uma coordenada para a Direita/Este.

== Exemplos de utilização:

>>> andarDireita [(Bloco,(0,2)),(Bloco,(1,2)),(Bloco,(2,2)),(Caixa,(1,1))] (Jogador (0,1) Oeste False)
>C 
XXX
>>> andarDireita [(Bloco,(0,2)),(Bloco,(1,2)),(Bloco,(2,2))] (Jogador (0,1) Oeste False)
 > 
XXX
-}

andarDireita :: [(Peca,Coordenadas)] -> Jogador -> Jogo
andarDireita m j@(Jogador (x,y) d b) | validaAvancaDireita m j && notElem = Jogo (constroiMapa m) (Jogador (posicaoQueda m j AndarDireita) Este b) -- caso (3.) - existe queda
                                     | validaAvancaDireita m j = Jogo (constroiMapa m) (Jogador (x+1,y) Este b) -- caso (3.) - não existe queda
                                     | otherwise = Jogo (constroiMapa m) (Jogador (x,y) Este b) -- caso (2.)
                                     where notElem = not (elem (Bloco,(x+1,y+1)) m || elem (Caixa,(x+1,y+1)) m) -- verifica se existe queda
                                           (c1,c2) = posicaoQueda m j AndarDireita -- permite o acesso a cada coordenada do output de 'posicaoQueda'

{- | A função ’andarEsquerda’ aplica o movimento __AndarEsquerda__ ao jogador, se o movimento não for possivel o jogador fica na mesma posição mas virado na posição Oeste.

Para isso, a função:

1. Aplica a função auxiliar 'validaAvancaEsquerda' para verificar se é possível fazer o Jogador avançar para a esquerda (Oeste);
2. Se não for possivel avançar, as coordenadas do Jogador mantém-se e apenas a direção é alterada (para Oeste);
3. Se for possivel avançar, verifica ainda se existe uma queda (@notElem@) e, caso exista, aplica a função 'posicaoQueda' para determinar as coordenadas da posição do
Jogador após a queda. Caso não exista queda, simplesmente move o Jogador uma coordenada para a Esquerda/Oeste.

== Exemplos de utilização:

>>> andarEsquerda [(Bloco,(0,2)),(Bloco,(1,2)),(Bloco,(2,2)),(Caixa,(1,1))] (Jogador (2,1) Este False)
 C< 
XXX
>>> andarEsquerda [(Bloco,(0,2)),(Bloco,(1,2)),(Bloco,(2,2))] (Jogador (1,1) Este False)
<  
XXX
-}

andarEsquerda :: [(Peca,Coordenadas)] -> Jogador -> Jogo
andarEsquerda m j@(Jogador (x,y) d b) | validaAvancaEsquerda m j && notElem = Jogo (constroiMapa m) (Jogador (posicaoQueda m j AndarEsquerda) Oeste b) -- caso (3.) - existe queda
                                      | validaAvancaEsquerda m j = Jogo (constroiMapa m) (Jogador (x-1,y) Oeste b) -- caso (3.) - não existe queda
                                      | otherwise = Jogo (constroiMapa m) (Jogador (x,y) Oeste b) -- caso (2.)
                                      where notElem = not (elem (Bloco,(x-1,y+1)) m || elem (Caixa,(x-1,y+1)) m) -- verifica se existe queda
                                            (c1,c2) = posicaoQueda m j AndarEsquerda -- permite o acesso a cada coordenada do output de 'posicaoQueda'


{- | A função ’posicaoQueda’ determina as coordenadas exatas da posição final de um Jogador após uma queda. No entanto, é ainda utilizada em 'interageCaixa'
para determinar as coordenadas de uma Caixa após uma queda (a posição de queda do jogador e da caixa são equivalentes).

Para isso, a função:

1. Verifica se a queda é à direita ou à esquerda do jogador, ou seja, se o jogador executa o movimento __AndarDireita__ ou __AndarEsquerda__;
2. De acordo com o movimento, filtra a coluna do Mapa onde a queda se encontra em __x__ e __y__, de forma a ficar apenas com uma lista com os elementos
que vão desde o início da queda até ao fim da coluna;
3. Retira as coordenadas da primeira peça dessa lista, que irá corresponder à peça que assinala o fim da queda (uma vez que as peças 'Vazio' não são declaradas);
4. Devolve as coordenadas da posição final do jogador, que serão equivalentes ás coordenadas da peça que assinala o fim da queda, exceto em __y__, que será mais
pequeno por 1 valor ( @(xD,yD-1)@ e @(xE,yE-1)@ ).

== Exemplos de utilização:

>>> posicaoQueda [(Bloco,(0,3)),(Bloco,(1,3)),(Bloco,(2,3)),(Bloco,(2,2))] (Jogador (2,1) Este False) AndarEsquerda
(1,2)
-}

posicaoQueda :: [(Peca,Coordenadas)] -> Jogador -> Movimento -> Coordenadas
posicaoQueda m (Jogador (x1,y1) d b) mov | mov == AndarDireita = (xD,yD-1)
                                         | mov == AndarEsquerda = (xE,yE-1)
                                         where auxD (p,(x2,y2)) = x2 == x1+1 && y2 > y1 && p /= Porta
                                               auxE (p,(x2,y2)) = x2 == x1-1 && y2 > y1 && p /= Porta
                                               (_,(xD,yD)) = head (filter auxD m)
                                               (_,(xE,yE)) = head (filter auxE m)

--

{- | A função ’validaMovimento’ irá validar os movimentos __Trepar__ ou __InterageCaixa__ recorrendo ás funções 'validaTrepar' e 'validaInterageCaixa',
respetivamente.

- __Nota:__ As funções auxiliares 'validaTrepar' e 'validaInterageCaixa' recebem o mapa não no formato 'Mapa' mas no formato de uma lista
do tipo __[(Peca,Coordeandas)]__, de forma a facilitar o processo. Assim, é usada a função 'desconstroiMapa' (importada da Tarefa 2) para transformar 'Mapa'.

-}

validaMovimento :: Jogo -> Movimento -> Bool
validaMovimento (Jogo mapa jogador) m | m == Trepar = validaTrepar (desconstroiMapa mapa) jogador
                                      | m == InterageCaixa = validaInterageCaixa (desconstroiMapa mapa) jogador

{- | A função ’validaTrepar’ verifica se é possivel executar o movimento __Trepar__. 

Para isso, a função verifica se todas as condições necessárias para o jogador poder efetuar o movimento __Trepar__ são cumpridas, condições
essas que estão descritas no enunciado do projeto.

Para além disso, verifica que o estado do Jogo não se encontra numa possível exceção ás regras
normais que têm de ser cumpridas para trepar. Por exemplo, quando o jogador se encontra em __y = 0__ ou quando trepar obriga a que a caixa que o mesmo
carrega fique "fora" do Mapa.

== Exemplos de utilização:

>>> validaTrepar [(Bloco,(0,3)),(Bloco,(1,3)),(Bloco,(2,3)),(Bloco,(0,1)),(Bloco,(0,2))] (Jogador (1,2) Oeste False)
False
>>> validaTrepar [(Bloco,(0,3)),(Bloco,(1,3)),(Bloco,(2,3)),(Bloco,(0,2))] (Jogador (1,2) Oeste False)
True
-}

validaTrepar :: [(Peca,Coordenadas)] -> Jogador -> Bool
validaTrepar m (Jogador (x,y) d b) | y == 0 = False -- jogador na linha 0 do mapa - impossível trepar
                                   | b && y == 1 = False -- jogador com uma caixa na linha 1 do mapa - impossível trepar (caixa fora do mapa)
                                   | (Bloco,(x,y-1)) `elem` m = False -- existe um bloco por cima do jogador - impossível trepar
                                   | d == Este && b && validEste && not (elem (Bloco,(x+1,y-2)) m || elem (Caixa,(x+1,y-2)) m) = True -- o jogador carrega uma caixa, existe um bloco para trepar e tem espaço para o trepar, na direção Este
                                   | d == Oeste && b && validOeste && not (elem (Bloco,(x-1,y-2)) m || elem (Caixa,(x-1,y-2)) m) = True -- o jogador carrega uma caixa, existe um bloco para trepar e tem espaço para o trepar, na direção Oeste
                                   | d == Este && not b && validEste = True -- o jogador não carrega uma caixa, existe um bloco para trepar e tem espaço para o trepar, na direção Este
                                   | d == Oeste && not b && validOeste = True -- o jogador não carrega uma caixa, existe um bloco para trepar e tem espaço para o trepar, na direção Oeste
                                   | otherwise = False -- não verifica as condições acima - Trepar inválido
                                   where validEste = (elem (Bloco,(x+1,y)) m || elem (Caixa,(x+1,y)) m) && not (elem (Bloco,(x+1,y-1)) m || elem (Caixa,(x+1,y-1)) m)
                                         validOeste = (elem (Bloco,(x-1,y)) m || elem (Caixa,(x-1,y)) m) && not (elem (Bloco,(x-1,y-1)) m || elem (Caixa,(x-1,y-1)) m)

{- | A função ’validaInterageCaixa’ verifica se é possivel executar o movimento __InterageCaixa__. 

Para isso, a função verifica se todas as condições necessárias para o jogador poder efetuar o movimento __InterageCaixa__ são cumpridas, condições
essas que estão descritas no enunciado do projeto.

Para além disso, verifica que o estado do Jogo não se encontra numa possível exceção ás regras
normais que têm de ser cumpridas para interagir com uma caixa. Por exemplo, quando o jogador se encontra em __y = 0__.

== Exemplos de utilização:

>>> validaInterageCaixa [(Bloco,(0,3)),(Bloco,(1,3)),(Bloco,(2,3)),(Bloco,(0,0)),(Caixa,(0,1))] (Jogador (1,1) Oeste False)
False
-}

validaInterageCaixa :: [(Peca,Coordenadas)] -> Jogador -> Bool
validaInterageCaixa m (Jogador (x,y) d b) | y == 0 = False -- jogador na linha 0 do mapa - impossível pegar ou largar uma caixa
                                          | x == xMax m && d == Este = False -- jogador voltado para a direita na última coluna do mapa - impossível pegar ou largar uma caixa
                                          | x == 0 && d == Oeste = False -- jogador voltado para a esquerda na primeira coluna do mapa - impossível pegar ou largar uma caixa
                                          | (Bloco,(x,y-1)) `elem` m = False -- existe um bloco por cima do jogador - impossível interagir com caixas
                                          | d == Este && not b && elem (Caixa,(x+1,y)) m && notElemEste = True -- existe uma caixa válida para pegar e não existem obstáculos, à Direita
                                          | d == Oeste && not b && elem (Caixa,(x-1,y)) m && notElemOeste = True -- existe uma caixa válida para pegar e não existem obstáculos, à Esquerda
                                          | d == Este && b && notElemEste = True -- existe um lugar válido para largar a caixa e não existem obstáculos, à Direita
                                          | d == Oeste && b && notElemOeste = True -- existe um lugar válido para largar a caixa e não existem obstáculos, à Esquerda
                                          | otherwise = False -- não verifica as condições acima - InterageCaixa inválido
                                          where notElemEste = not (elem (Bloco,(x+1,y-1)) m || elem (Caixa,(x+1,y-1)) m)
                                                notElemOeste = not (elem (Bloco,(x-1,y-1)) m || elem (Caixa,(x-1,y-1)) m)

--

{- | A função ’validaAvancaDireita’ verifica se o jogador consegue, de facto, avançar um bloco para a direita quando é executado o movimento __AndarDireita__.

Para isso, a função verifica um conjunto de condições que têm de ser cumpridas e que estão descritas no enunciado do projeto.

Para além disso, verifica que o estado do Jogo não se encontra numa possível exceção ás regras normais que têm de ser cumpridas para o jogador poder avançar para a direita.
Por exemplo, quando o jogador se encontra na última coluna do mapa (__@x == xMax m@__).

== Exemplos de utilização:

>>> validaAvancaDireita [(Bloco,(0,3)),(Bloco,(1,3)),(Bloco,(2,3)),(Bloco,(0,1)),(Bloco,(0,2)),(Bloco,(2,2))] (Jogador (1,2) Oeste False)
False
-}

validaAvancaDireita :: [(Peca,Coordenadas)] -> Jogador -> Bool
validaAvancaDireita m (Jogador (x,y) d b) | x == xMax m = False -- o jogador está na última coluna do mapa - impossível avançar para a direita
                                          | not b && notElem = True -- o jogador não carrega uma caixa e tem espaço para se movimentar
                                          | b && notElem && not (elem (Bloco,(x+1,y-1)) m || elem (Caixa,(x+1,y-1)) m) = True -- o jogador carrega uma caixa e tem espaço para se movimentar
                                          | otherwise = False -- não verifica as condições acima - impossível avançar para a direita
                                          where notElem = not (elem (Bloco,(x+1,y)) m|| elem (Caixa,(x+1,y)) m)

{- | A função ’validaAvancaEsquerda’ verifica se o jogador consegue, de facto, avançar um bloco para a esquerda quando é executado o movimento __AndarEsquerda__.

Para isso, a função verifica um conjunto de condições que têm de ser cumpridas e que estão descritas no enunciado do projeto.

Para além disso, verifica que o estado do Jogo não se encontra numa possível exceção ás regras normais que têm de ser cumpridas para o jogador poder avançar para a esquerda.
Por exemplo, quando o jogador se encontra na primeira coluna do mapa (__@x == 0@__).

== Exemplos de utilização:

>>> validaAvancaEsquerda [(Bloco,(0,3)),(Bloco,(1,3)),(Bloco,(2,3)),(Bloco,(0,1)),(Bloco,(0,2)),(Bloco,(2,2))] (Jogador (1,2) Oeste False)
False
-}

validaAvancaEsquerda :: [(Peca,Coordenadas)] -> Jogador -> Bool
validaAvancaEsquerda m (Jogador (x,y) d b) | x == 0 = False -- o jogador está na primeira coluna do mapa - impossível avançar para a esquerda
                                           | not b && notElem = True -- o jogador não carrega uma caixa e tem espaço para se movimentar
                                           | b && notElem && not (elem (Bloco,(x-1,y-1)) m || elem (Caixa,(x-1,y-1)) m) = True -- o jogador carrega uma caixa e tem espaço para se movimentar
                                           | otherwise = False -- não verifica as condições acima - impossível avançar para a esquerda
                                           where notElem = not (elem (Bloco,(x-1,y)) m || elem (Caixa,(x-1,y)) m)

--

{- | A função ’correrMovimentos’ aplica uma sequência de movimentos chamando a função 'moveJogador' para cada movimento.

== Exemplos de utilização:

>>> correrMovimentos (Jogo [[Vazio,Vazio,Vazio],[Bloco,Bloco,Bloco]] (Jogador (0,0) Este False)) [AndarDireita,AndarDireita]
  >
XXX
-}

correrMovimentos :: Jogo -> [Movimento] -> Jogo
correrMovimentos = foldl moveJogador