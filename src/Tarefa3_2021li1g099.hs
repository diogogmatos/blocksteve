{- |
Module      : Tarefa3_2021li1g099
Description : Representação textual do jogo
Copyright   : Rui Pedro Cerqueira <a100537@alunos.uminho.pt>;
            : Diogo Matos <a100741@alunos.uminho.pt>;

Módulo para a realização da Tarefa 3 do projeto de LI1 em 2021/22.
-}

module Tarefa3_2021li1g099 where

import LI12122

{- | ’show’ permite representar no terminal o output da função 'representaJogo', formatando as linhas pelos parágrafos indicados por
"\\n".

Assim, sempre que uma função do projeto retornar um valor do tipo 'Jogo', o output será representado no ghci não no tipo 'Jogo',
mas como o output de 'representaJogo' para esse 'Jogo'.

-}

instance Show Jogo where
  show jogo = representaJogo jogo 0

{- | A função ’representaJogo’ converte um 'Jogo' numa 'String', de forma a representar o seu estado atual graficamente.

Para isso, a função:

1. Para cada linha do 'Mapa', isto é, para cada sub-lista da lista do tipo '[[Peca]]', transforma as suas peças em determinados caracteres,
com a ajuda da função 'escreveLinha';
2. Caso estejamos na linha onde o 'Jogador' se encontra (@acc == y@), aplica (de forma análoga a 'escreveLinha') a função 'escreveLinhaJ' - que irá, para além
das peças, representar também o jogador na 'String';
3.  Caso o jogador esteja a carregar uma caixa e estejamos a analisar a linha onde a caixa estará situada (@acc == (y-1) && b == True@), aplica
(de forma análoga a 'escreveLinha') a função 'escreveLinhaC' - que irá, para além das peças, representar também a caixa que o jogador carrega na 'String';
4. Concatena as listas resultantes, adicionando o caracter "\\n" (parágrafo) entre elas, de forma a obter uma 'String' com todas as linhas do mapa
representadas.

-}

representaJogo :: Jogo
               -> Int -- ^ Input de um acumulador, de valor inicial 0, que tem como objetivo assumir um valor crescente de __y__
               -> String
representaJogo (Jogo [] _) _ = "" -- caso de paragem - a função já percorreu toda a lista
representaJogo (Jogo (h:t) a@(Jogador (x,y) d b)) acc | acc == y = escreveLinhaJ h x d 0 ++ (if null t then "" else "\n") ++ representaJogo (Jogo t a) (acc+1) --  caso (2.)
                                                      | acc == (y-1) && b == True = escreveLinhaC h x 0 ++ (if null t then "" else "\n") ++ representaJogo (Jogo t a) (acc+1) -- caso (3.)
                                                      | otherwise = escreveLinha h ++ (if null t then "" else "\n") ++ representaJogo (Jogo t a) (acc+1) -- caso (1.)

{- | A função ’escreveLinha’ converte uma lista de peças ([Peca]) numa String, onde cada peça é representada por um caracter diferente.

- 'Bloco' é representado por: @X@
- 'Caixa' é representado por: @C@
- 'Porta' é representado por: @P@
- 'Vazio' é representado por um espaço vazio: @" "@

Para isso, a função verifica para cada elemento da lista se é Bloco, Caixa, Porta ou Vazio e adiciona à String o caracter correspondente.

-}

escreveLinha :: [Peca] -> String
escreveLinha [] = ""
escreveLinha (p:ps) | p == Vazio = " " ++ escreveLinha ps
                    | p == Bloco = "X" ++ escreveLinha ps
                    | p == Caixa = "C" ++ escreveLinha ps
                    | p == Porta = "P" ++ escreveLinha ps

{- | A função ’escreveLinhaJ’ converte, de forma análoga a 'escreveLinha', as peças em caracteres. No entanto, representa também o jogador que se
encontra nessa linha.

Para isso, a função:

1. Recebe de 'representaJogo' a linha do Mapa à qual o jogador pertence;
2. Quando o valor do acumulador corresponde ao valor da coordenada __x__ do Jogador, dependendo da sua direção (Este ou Oeste), o mesmo é representado
na String por ">" para Este e "<" para Oeste;
3. Para os outros casos, as peças são convertidas em caracteres normalmente, como acontece em 'escreveLinha'.

-}

escreveLinhaJ :: [Peca] -- ^ Lista de peças correspondente à linha do Mapa que contém o Jogador
              -> Int -- ^ Valor inteiro correspondente ao valor da coordenada __x__ do Jogador
              -> Direcao -- ^ Direção do Jogador (Este ou Oeste)
              -> Int -- ^ Acumulador, de valor inicial 0, que tem como objetivo assumir um valor crescente de __x__
              -> String
escreveLinhaJ [] _ _ _ = "" -- caso de paragem - a função já percorreu toda a lista
escreveLinhaJ (p:ps) x d acc | acc /= x = if (p == Vazio) then " " ++ escreveLinhaJ ps x d (acc+1) -- caso (3.)
                                          else if (p == Bloco) then "X" ++ escreveLinhaJ ps x d (acc+1)
                                          else if (p == Caixa) then "C" ++ escreveLinhaJ ps x d (acc+1)
                                          else "P" ++ escreveLinhaJ ps x d (acc+1)
                             | otherwise = if (d == Este) then ">" ++ escreveLinhaJ ps x d (acc+1) -- caso (2.)
                                           else "<" ++ escreveLinhaJ ps x d (acc+1)

{- | A função ’escreveLinhaC’ funciona de forma análoga a 'escreveLinhaJ' e tem como objetivo representar a Caixa que o jogador segura, no mapa.

Para isso, a função:

1. Recebe de 'representaJogo' a linha do Mapa à qual a Caixa que o jogador segura pertence;
2. Quando o valor do acumulador corresponde ao valor da coordenada __x__ da Caixa, a mesma é representada na String;
3. Para os outros casos, as peças são convertidas em caracteres normalmente, como acontece em 'escreveLinha'.

-}

escreveLinhaC :: [Peca] -- ^ Lista de peças correspondente à linha do Mapa que contém a Caixa que o jogador segura
                 -> Int -- ^ Valor inteiro correspondente ao valor da coordenada __x__ da Caixa
                 -> Int -- ^ Acumulador, de valor inicial 0, que tem como objetivo assumir um valor crescente de __x__
                 -> String
escreveLinhaC [] _ _ = "" -- caso de paragem - a função já percorreu toda a lista
escreveLinhaC (p:ps) x acc | acc /= x = if (p == Vazio) then " " ++ escreveLinhaC ps x (acc+1) -- caso (3.)
                                        else if (p == Bloco) then "X" ++ escreveLinhaC ps x (acc+1)
                                        else if (p == Caixa) then "C" ++ escreveLinhaC ps x (acc+1)
                                        else "P" ++ escreveLinhaC ps x (acc+1)
                           | otherwise = "C" ++ escreveLinhaC ps x (acc+1) -- caso (2.)
