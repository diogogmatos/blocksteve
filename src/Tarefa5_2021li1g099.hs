{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{- |
Module      : Tarefa5_2021li1g099
Description : Aplicação Gráfica

Módulo para a realização da Tarefa 5 do projeto de LI1 em 2021/22.

== Bibliografia:

- "Gloss Library" Hackage, 2020 "https://hackage.haskell.org/package/gloss"
-}

module Main where

import LI12122
import ListaJogos
import Tarefa1_2021li1g099
import Tarefa2_2021li1g099
import Tarefa4_2021li1g099
import Tarefa6_2021li1g099
import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import Graphics.Gloss.Data.Bitmap
import Graphics.Gloss.Juicy (loadJuicy)


-- MAIN --


{- | A função ’main’ constitui a base da Tarefa 5. É uma função do tipo @IO ()@ responsável por carregar todas as diversas texturas/imagens
utilizadas no desenvolvimento do ambiente gráfico do jogo, utilizando para isso a função 'loadJuicy' da livraria __@Graphics.Gloss.Juicy@__.
Para além disso, invoca a função 'play' (incluída na livraria __@Graphics.Gloss@__), função essa que constitui o corpo de todo o funcionamento do ambiente
gráfico do jogo.
-}

main :: IO ()
main = do
    Just p1 <- loadJuicy "imagens/title.png" -- menu: logótipo do jogo
    Just p2 <- loadJuicy "imagens/jogar.png" -- menu: texto "Jogar"
    Just p3 <- loadJuicy "imagens/jogars.png" -- menu: texto "Jogar" selecionado
    Just p4 <- loadJuicy "imagens/sair.png" -- menu: texto "Sair"
    Just p5 <- loadJuicy "imagens/sairs.png" -- menu: texto "Sair" selecionado
    Just p6 <- loadJuicy "imagens/grass.png" -- jogo: textura 'Bloco' - bloco de relva
    Just p7 <- loadJuicy "imagens/dirt.png" -- jogo: textura 'Bloco' - bloco de terra
    Just p8 <- loadJuicy "imagens/box.png" -- jogo: textura 'Caixa' - pistão
    Just p9 <- loadJuicy "imagens/boxe.png" -- jogo: textura 'Caixa' - base pistão extendido
    Just p10 <- loadJuicy "imagens/boxmiddle.png" -- jogo: textura 'Caixa' - centro do pistão extendido
    Just p11 <- loadJuicy "imagens/boxup.png" -- jogo: textura 'Caixa' - topo do pistão extendido
    Just p12 <- loadJuicy "imagens/door.png" -- jogo: textura 'Porta' - portal
    Just p13 <- loadJuicy "imagens/dudeRight.png" -- jogo: textura do Jogador para Este
    Just p14 <- loadJuicy "imagens/dudeLeft.png" -- jogo: textura do Jogador para Oeste
    Just p15 <- loadJuicy "imagens/titlep.png" -- menu pausa: logótipo do menu pausa
    Just p16 <- loadJuicy "imagens/cont.png" -- menu pausa: texto "Continuar"
    Just p17 <- loadJuicy "imagens/conts.png" -- menu pausa: texto "Continuar" selecionado
    Just p18 <- loadJuicy "imagens/menu.png" -- menu pausa: texto "Menu"
    Just p19 <- loadJuicy "imagens/menus.png" -- menu pausa: texto "Menu" selecionado
    Just p20 <- loadJuicy "imagens/help.png" -- menu Help: imagem com as informações do menu de ajuda
    Just p21 <- loadJuicy "imagens/background.png" -- menu: fundo do menu
    Just p22 <- loadJuicy "imagens/gamebackground.png" -- jogo: fundo do jogo
    Just p23 <- loadJuicy "imagens/niveis.png" -- menu: texto "Niveis"
    Just p24 <- loadJuicy "imagens/niveiss.png" -- menu: texto "Niveis" selecionado
    Just p25 <- loadJuicy "imagens/n1.png" -- seleção níveis: nível 1 selecionado
    Just p26 <- loadJuicy "imagens/n2.png" -- seleção níveis: nível 2 selecionado
    Just p27 <- loadJuicy "imagens/n3.png" -- seleção níveis: nível 3 selecionado
    Just p28 <- loadJuicy "imagens/n4.png" -- seleção níveis: nível 4 selecionado
    Just p29 <- loadJuicy "imagens/n5.png" -- seleção níveis: nível 5 selecionado
    Just p30 <- loadJuicy "imagens/n6.png" -- seleção níveis: nível 6 selecionado
    Just p31 <- loadJuicy "imagens/n7.png" -- seleção níveis: nível 7 selecionado
    Just p32 <- loadJuicy "imagens/n8.png" -- seleção níveis: nível 8 selecionado
    Just p33 <- loadJuicy "imagens/n9.png" -- seleção níveis: nível 9 selecionado
    Just p34 <- loadJuicy "imagens/n10.png" -- seleção níveis: nível 10 selecionado
    Just p35 <- loadJuicy "imagens/botRight.png" -- jogo: textura do Bot para Este
    Just p36 <- loadJuicy "imagens/botLeft.png" -- jogo: textura do Bot para Oeste
    Just p37 <- loadJuicy "imagens/botErrorRight.png" -- jogo: textura do Bot para Este quando é impossível a resolução do nível a partir do estado atual do jogo
    Just p38 <- loadJuicy "imagens/botErrorLeft.png" -- jogo: textura do Bot para Oeste quando é impossível a resolução do nível a partir do estado atual do jogo
    play janela white fr (estadoInicial (p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,p20,p21,p22,p23,p24,p25,p26,p27,p28,p29,p30,p31,p32,p33,p34,p35,p36,p37,p38)) draw reage reageTempo

{- | __’fr’ representa a "frame rate" do jogo, isto é, o número de vezes por segundo que é atualizada a função 'play'.__

Este valor é particularmente útil na funcionalidade "Bot" do jogo, onde, recorrendo à Tarefa 6, é possível visualizar o bot a resolver
o nível atual. Como os movimentos do bot são calculados previamente à sua animação, a velocidade a que cada movimento é desenhado no ecrã
está dependendete da taxa de atualização do jogo. Isto é alcaçado com o uso da função 'reageTempo'.

A dependência na taxa de atualização (frame rate) para a animação do bot permite uma implementação mais simples da funcionalidade,
no entanto, prejudica a velocidade a que o jogo consegue reagir aos inputs que o utilizador faz pelo teclado, ou seja, consegue apresentar
no máximo apenas 2 movimentos por segundo no ecrã. Sendo este tipo de jogo um jogo de raciocínio e que não requer uma grande velocidade de
resposta, optei por manter esta forma de implementação apesar de tudo.
-}

fr :: Int
fr = 2

{- | __’janela’ representa o modo de exibição da "janela" onde o jogo é apresentado.__

Neste caso, o jogo é apresentado em modo 'FullScreen', isto é, em ecrã cheio.
Optei por este modo de exibição por considerar ser o mais flexível e imersivo.
-}

janela :: Display
janela = FullScreen

-- | O estado geral do jogo.
data Estado =
    E
    EstadoMenu -- ^ Estado atual do Menu
    EstadoJogo -- ^ Estado atual do Jogo
    EstadoPausa -- ^ Estado atual do Menu Pausa
    EstadoNiveis -- ^ Estado atual da Seleção de Níveis

-- | Tuplo contendo a totalidade das texturas/imagens utilizadas em todo o ambiente gráfico do jogo.
type Texturas = (Picture, Picture, Picture, Picture, Picture, Picture, Picture,
                 Picture, Picture, Picture, Picture, Picture, Picture, Picture,
                 Picture, Picture, Picture, Picture, Picture, Picture, Picture,
                 Picture, Picture, Picture, Picture, Picture, Picture, Picture,
                 Picture, Picture, Picture, Picture, Picture, Picture, Picture,
                 Picture, Picture, Picture)

{- | A função ’estadoInicial’ recebe a totalidade das imagens utilizadas no jogo (carregadas em 'main' com a função 'loadJuicy') e retorna o estado
inicial do jogo, inlcuindo no mesmo todas as texturas que recebe. Isto permite que estas sejam utilizadas nas funções que "desenham" os elementos
no ecrã ('draw', 'drawMenu', 'drawNiveis', 'drawPausa' e 'drawJogo').

Para além disso, calcula o número de níveis carregados (@length world@) e estabelece o nível 1 como o nível atual. Estes níveis são importados do ficheiro
__ListaJogos.hs__.
-}

estadoInicial :: Texturas -> Estado
estadoInicial (p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,p20,p21,p22,p23,p24,p25,p26,p27,p28,p29,p30,p31,p32,p33,p34,p35,p36,p37,p38) =
    E

    -- 'Jogar' é a opção escolhida por defeito no menu | 'False' porque não está selecionado
    (Menu Jogar (p1,p2,p3,p4,p5,p21,p23,p24) False)

    {- 1. A contagem de níveis começa em 0;
       2. O número de níveis é dado por 'length world';
       3. 'False' porque naturalmente ainda não foi concluído o último nível;
       4. 'world' representa a lista com os níveis importados de 'ListaJogos.hs';
       5. O "jogo atual" começa naturalmente por ser o primeiro nível (head world);
       6. 'ElementosJogo';
       7. O menu "Help" não está aberto (False) por defeito;
       8. A escala do mapa é a original, (1,1), por defeito;
       9. O bot encontra-se desativado e retorna 'Nothing' por defeito. -}
    (0, length world, False, world, head world, (p6,p7,p8,p9,p10,p11,p12,p13,p14,p20,p22,p35,p36,p37,p38), False, (1,1), Bot False Nothing)

    -- O menu pausa encontra-se por defeito com 'Continuar' selecionado
    (Pausa Continuar (p15,p16,p17,p18,p19,p21) True)

    -- O nível 1 é a opção escolhida por defeito na seleção de níveis | 'False' porque não está selecionado
    (Nivel 1 False (p25,p26,p27,p28,p29,p30,p31,p32,p33,p34))

{- | __A função ’reage’ atualiza o estado do jogo de acordo com os inputs que o utilizador realiza pelo teclado.__

Esta função funciona como uma espécie de
filtro, uma vez que, a partir de uma avaliação do estado atual do jogo, direciona o input do utilizador para a função "reage" correspondente, isto é,
para 'reageMenu', 'reageNiveis', 'reagePausa', 'reageJogo' ou 'reageTempo'. No entanto, reponde também a certos inputs localmente, como é o caso da
ativação ou desativação do "Bot", isto acontece porque esta funcionalidade utiliza a função 'reageTempo' que tem obrigatoriamente de receber o estado geral
do jogo ('Estado') e a função 'reageTempo' tem apenas acesso a 'EstadoJogo'. A ativação do menu pausa é também realizada localmente nesta função por ser
mais flexível fazê-lo dessa forma, assim, apenas a navegação no menu pausa é controlada por 'reagePausa'.
-}

reage :: Event -- ^ Input do utilizador pelo teclado
      -> Estado -- ^ Estado atual
      -> Estado -- ^ Estado atualizado

-- O bot foi ativado (True) e retornou 'Nothing': é automaticamente desativado (False) - impossível resolver nível a partir do estado atual do jogo.
reage e (E em (r1,r2,r3,r4,r5,r6,r7,r8,Bot True Nothing) ep en) =
    E em (r1,r2,r3,r4,r5,r6,r7,r8,Bot False Nothing) ep en

-- Estamos no jogo e a tecla "b" é pressionada: bot é ativado (Bot True ...) e 'resolveJogo' é invocada para calcular os movimentos para a resolução do nível atual.
reage (EventKey (Char 'b') Down _ _) (E em@(Menu Jogar _ True) (n,nMax,v,j,ja,t,h,(s1,s2),Bot False Nothing) ep@(Pausa Continuar _ True) en) =
    reageTempo 1 (E em (n,nMax,v,j,ja,t,h,(s1,s2),Bot True (resolveJogo 200 ja)) ep en)

-- Estamos no jogo e a tecla "b" é pressionada novamente: bot é desativado (Bot False ...) e é retomado o valor por defeito 'Nothing'.
reage (EventKey (Char 'b') Down _ _) (E em@(Menu Jogar _ True) (n,nMax,v,j,ja,t,h,(s1,s2),Bot True _) ep@(Pausa Continuar _ True) en) =
    E em (n,nMax,v,j,ja,t,h,(s1,s2),Bot False Nothing) ep en

-- Enquanto o bot está ativado, nenhuma ação é permitida à exceção das acima mencionadas.
reage e es@(E _ (_,_,_,_,_,_,_,_,Bot True _) _ _) = es

{- Estamos no jogo e a tecla "p" é pressionada: voltamos ao menu pausa (Pausa Continuar t False).
   Nota: O facto de a opção "Continuar" não estar selecionada significa que estamos no menu pausa e não no jogo. -}
reage (EventKey (Char 'p') Down _ _) (E em@(Menu Jogar e True) ej (Pausa Continuar t True) en) =
    E em ej (Pausa Continuar t False) en

-- Estamos no menu pausa (Pausa ... False), logo o 'EstadoPausa' será atualizado por 'reagePausa'.
reage e (E em@(Menu Jogar _ True) ej ep@(Pausa _ _ False) en) =
    E em ej (reagePausa e ep) en

-- O último nível do jogo foi concluído: o 'Estado' retoma os valores iniciais e, consequentemente, voltamos ao menu inicial.
reage e (E (Menu _ t1 _) (_, _, True, _, _, t2, _, _, _) (Pausa _ t3 _) (Nivel _ _ t4)) =
    E (Menu Jogar t1 False) (0, length world, False, world, head world, t2, False, (1,1), Bot False Nothing) (Pausa Continuar t3 True) (Nivel 1 False t4)

-- Estamos no jogo, no menu pausa, e a opção 'VoltarAoMenu' foi selecionada: voltamos ao menu inicial (Menu Jogar ... False) e o 'Estado' retoma os valores inciais.
reage e (E em@(Menu Jogar t1 True) (n, nMax, v, _, _, t, h, _, _) (Pausa VoltarAoMenu t2 True) (Nivel _ _ t3)) =
    E (Menu Jogar t1 False) (0, nMax, False, world, head world, t, h, (1,1), Bot False Nothing) (Pausa Continuar t2 True) (Nivel 1 False t3)

-- Estamos no jogo [(Menu Jogar ... True) e (Pausa Continuar ... True)], logo o 'EstadoJogo' será atualizado por 'reageJogo'.
reage e (E em@(Menu Jogar _ True) ej ep@(Pausa Continuar _ True) en) =
    E em (reageJogo e ej) ep en

{- Estamos na seleção de níveis (Menu Niveis ... True) e o nível 'n' foi selecionado:
   1. Entramos no jogo (Menu Jogar ... True) com o nível selecionado como "jogo atual" (world !! (n-1));
   2. O número de níveis é ajustado para que quando o nível for concluído voltemos ao menu inicial (n-1, n, ...);
   3. Os restantes valores do 'EstadoJogo' retornam aos valores padrão.
   Nota: Existe um ajuste de -1 entre o nível selecionado e a contagem de níveis, uma vez que a contagem começa em 0 e não em 1 -}
reage e (E em@(Menu Niveis t1 True) (_,_,_,_,_,t2,_,_,_) ep en@(Nivel n True _)) =
    E (Menu Jogar t1 True) (n - 1, n, False, world, world !! (n - 1), t2, False, (1,1), Bot False Nothing) ep en

-- Estamos na seleção de níves (Menu Niveis ... True), logo o 'EstadoNiveis' será atualizado por 'reageNiveis'.
reage e (E em@(Menu Niveis _ True) ej ep en) =
    E em ej ep (reageNiveis e en)

-- Se o 'Estado' não se encontra em nenhuma das situações acima, então estamos no menu incial - logo o 'EstadoMenu' será atualizado por 'reageMenu'.
reage e (E em ej ep en) =
    E (reageMenu e em) ej ep en

{- | __A função ’draw’ "desenha" o que é suposto ser representado no ecrã ao utilizador.__

À semelhança do que acontece em 'reage', esta função
funciona como um "filtro" que a partir de uma avaliação do 'Estado' do jogo invoca a função "draw" correspondente, ou seja, invoca 'drawMenu',
'drawJogo', 'drawPausa' ou 'drawNiveis'.
-}

draw :: Estado -> Picture

{- O último nível foi concluído, logo será desenhado o menu inicial com 'drawMenu'.
   Nota: invocamos 'drawMenu' para '(Menu Jogar e False)' porque o menu inicial é desenhado antes de o 'Estado' ser atualizado. -}
draw (E (Menu _ e _) (_, _, True, _, _, _, _, _, _) ep en) = drawMenu (Menu Jogar e False)

-- Estamos no jogo [(Menu Jogar ... True) e (Pausa Continuar ... True)], logo o jogo será desenhado com 'drawJogo'.
draw (E (Menu Jogar _ True) ej (Pausa Continuar _ True) en) = drawJogo ej

-- Estamos no jogo, no menu pausa [(Menu Jogar ... True) e (Pausa ... False)], logo o menu pausa será desenhado com 'drawPausa'.
draw (E (Menu Jogar _ True) ej ep@(Pausa _ _ False) en) = drawPausa ep

{- A opção 'VoltarAoMenu' foi selecionada no menu pausa, logo será desenhado o menu inicial com 'drawMenu'.
   Nota: invocamos 'drawMenu' para '(Menu Jogar e False)' porque o menu inicial é desenhado antes de o 'Estado' ser atualizado. -}
draw (E (Menu Jogar e True) ej (Pausa VoltarAoMenu _ True) en) = drawMenu (Menu Jogar e False)

-- Estamos na seleção de níveis (Menu Niveis ... True), logo será desenhado o menu de seleção de níveis com 'drawNiveis'.
draw (E em@(Menu Niveis e True) ej ep en) = drawNiveis en

-- Se o 'Estado' não se encontra em nenhuma das situações acima, então estamos no menu incial - logo este será desenhado com 'drawMenu'.
draw (E em _ _ _) = drawMenu em


-- MENU --


-- | O estado atual do menu do jogo.
data EstadoMenu =
    Menu
    Opcao -- ^ Opção que se encontra escolhida no menu
    Elementos -- ^ Imagens que compõe o menu
    Bool -- ^ Indica se a 'Opcao' escolhida foi selecionada (True) ou não (False)

-- | Opções do menu.
data Opcao
    = Jogar
    | Niveis
    | Sair
    deriving Eq -- ^ Estabelece a relação de igualdade entre os elementos de 'Opcao'

-- | Tuplo contendo todas as texturas/imagens usadas no menu.
type Elementos = (Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture)

{- | __A função ’reageMenu’ atualiza o estado do menu de acordo com os inputs que o utilizador realiza pelo teclado.__

É, assim, a função responsável por permitir o utilizador navegar e selecionar opções do menu inicial.
-}

reageMenu :: Event -- ^ Input do utilizador pelo teclado
             -> EstadoMenu -- ^ Estado atual do menu
             -> EstadoMenu -- ^ Estado atualizado do menu

-- Navegar para cima (KeyUp)
reageMenu (EventKey (SpecialKey KeyUp) Down _ _) (Menu o e s) | o == Jogar = Menu Sair e False -- se estamos no topo, navegamos para a base
                                                              | o == Niveis = Menu Jogar e False
                                                              | otherwise = Menu Niveis e False

-- Navegar para baixo (KeyDown)
reageMenu (EventKey (SpecialKey KeyDown) Down _ _) (Menu o e s) | o == Jogar = Menu Niveis e False
                                                                | o == Niveis = Menu Sair e False
                                                                | otherwise = Menu Jogar e False -- se estamos na base, navegamos para o topo

-- Selecionar uma opção (KeyEnter)
reageMenu (EventKey (SpecialKey KeyEnter) Down _ _) (Menu o e s) | o == Sair = undefined -- 'undefined' interrompe o algoritmo, obrigando o jogo a fechar
                                                                 | otherwise = Menu o e True

-- Qualquer outro input não altera o estado do menu
reageMenu _ m = m

{- | __A função ’drawMenu’ desenha o menu inicial do jogo.__

Para isso, recebe o 'EstadoMenu' e, de acordo com o mesmo, alterna entre as imagens que o compõe de forma a "animar" a escolha das opções.
-}

drawMenu :: EstadoMenu -> Picture
drawMenu (Menu o (title, jogartxt, jogartxts, sairtxt, sairtxts, background, niveistxt, niveistxts) s)
    | o == Jogar = Pictures $ background : [Translate 0 300 title, Translate 0 50 jogartxts, Translate 0 (-150) niveistxt, Translate 0 (-340) sairtxt]
    | o == Niveis = Pictures $ background : [Translate 0 300 title, Translate 0 50 jogartxt, Translate 0 (-150) niveistxts, Translate 0 (-340) sairtxt]
    | otherwise = Pictures $ background : [Translate 0 300 title, Translate 0 50 jogartxt, Translate 0 (-150) niveistxt, Translate 0 (-340) sairtxts]


-- NIVEIS --


-- | Estado atual da seleção de níveis.
data EstadoNiveis =
    Nivel
    Int -- ^ Nível que se encontra escolhido no menu de seleção de níveis
    Bool -- ^ Indica se o nível escolhido foi selecionado (True) ou não (False)
    TexturasN -- ^ Imagens que compõe o menu de seleção de níveis

-- | Tuplo contendo as texturas/imagens usadas no menu de seleção de níveis.
type TexturasN = (Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture)

{- | __A função ’reageNiveis’ atualiza o estado do menu de seleção de níveis de acordo com os inputs que o utilizador realiza pelo teclado.__

É, assim, a função responsável por permitir o utilizador navegar e selecionar níveis.
-}

reageNiveis :: Event -- ^ Input do utilizador pelo teclado
            -> EstadoNiveis -- ^ Estado atual da seleção de níveis
            -> EstadoNiveis -- ^ Estado atualizado da seleção de níveis

-- Navegar para níveis superiores (KeyRight)
reageNiveis (EventKey (SpecialKey KeyRight) Down _ _) (Nivel n s t) | n == 10 = Nivel 1 s t -- se estamos no último nível, voltamos ao 1º
                                                                    | otherwise = Nivel (n+1) s t

-- Navegar para níveis inferiores (KeyLeft)
reageNiveis (EventKey (SpecialKey KeyLeft) Down _ _) (Nivel n s t) | n == 1 = Nivel 10 s t -- se estamos no 1º nível, voltamos ao último
                                                                   | otherwise = Nivel (n-1) s t

-- Selecionar um nível (KeyEnter)
reageNiveis (EventKey (SpecialKey KeyEnter) Down _ _) (Nivel n s t) = Nivel n True t

-- Qualquer outro input não altera o 'EstadoNiveis'
reageNiveis _ n = n

{- | __A função ’drawNiveis’ desenha o menu de seleção de níveis do jogo.__

Para isso, recebe o 'EstadoNiveis' e, de acordo com o mesmo, alterna entre as imagens que o compõe de forma a "animar" a escolha das opções.

- __Nota:__ Para uma maior simplicidade e eficiência no uso das imagens, cada uma das imagens usadas nesta função inclui todos os elementos que compõe o menu
de seleção de níveis, sendo o nível selecionado a única diferença entre elas.
-}

drawNiveis :: EstadoNiveis -> Picture
drawNiveis (Nivel n s (n1,n2,n3,n4,n5,n6,n7,n8,n9,n10))
    | n == 1 = n1
    | n == 2 = n2
    | n == 3 = n3
    | n == 4 = n4
    | n == 5 = n5
    | n == 6 = n6
    | n == 7 = n7
    | n == 8 = n8
    | n == 9 = n9
    | otherwise = n10


-- PAUSA --


-- | Estado atual do menu pausa.
data EstadoPausa =
    Pausa
    OpcaoP -- ^ Opção que se encontra escolhida no menu pausa
    ElementosP -- ^ Imagens que compõe o menu pausa
    Bool -- ^ Indica se a opção escolhida foi selecionada (True) ou não (False)

-- | Tuplo contendo as texturas/imagens usadas no menu pausa.
type ElementosP = (Picture, Picture, Picture, Picture, Picture, Picture)

-- | Opções do menu pausa.
data OpcaoP
    = Continuar -- ^ Voltar ao jogo
    | VoltarAoMenu
    deriving Eq -- ^ Estabelece a relação de igualdade entre os elementos de 'OpcaoP'

{- | __A função ’reagePausa’ atualiza o estado do menu pausa de acordo com os inputs que o utilizador realiza pelo teclado.__

É, assim, a função responsável por permitir o utilizador navegar e selecionar opções do menu pausa.
-}

reagePausa :: Event -- ^ Input do utilizador pelo teclado
           -> EstadoPausa -- ^ Estado atual do menu pausa
           -> EstadoPausa -- ^ Estado atualizado do menu pausa

-- Navegar para cima (KeyUp)
reagePausa (EventKey (SpecialKey KeyUp) Down _ _) (Pausa o e s) | o == Continuar = Pausa VoltarAoMenu e False
                                                                | otherwise = Pausa Continuar e False

-- Navegar para baixo (KeyDown)
reagePausa (EventKey (SpecialKey KeyDown) Down _ _) (Pausa o e s) | o == Continuar = Pausa VoltarAoMenu e False
                                                                  | otherwise = Pausa Continuar e False

-- Selecionar opção (KeyEnter)
reagePausa (EventKey (SpecialKey KeyEnter) Down _ _) (Pausa o e s) = Pausa o e True

-- Qualquer outro input não altera o 'EstadoPausa'
reagePausa _ p = p

{- | __A função ’drawPausa’ desenha o menu pausa do jogo.__

Para isso, recebe o 'EstadoPausa' e, de acordo com o mesmo, alterna entre as imagens que o compõe de forma a "animar" a escolha das opções.
-}

drawPausa :: EstadoPausa -> Picture
drawPausa (Pausa o (title, cont, conts, menu, menus, background) s)
    | o == Continuar = Pictures $ background : [Translate 0 280 title, Translate 50 (-100) conts, Translate 50 (-300) menu]
    | otherwise = Pictures $ background : [Translate 0 280 title, Translate 50 (-100) cont, Translate 50 (-300) menus]


-- JOGO --


-- | Tuplo contendo todas as diversas variáveis relativas ao jogo, ou seja, usadas para o seu "funcionamento".
type EstadoJogo
    =
    (
     Int, -- Nível atual
     Int, -- Número total de níveis (calculado em 'estadoInicial')
     Bool, -- Indica se o último nível foi concluído (True) ou não (False)
     [Jogo], -- Lista de mapas/níveis, no seu estado inicial
     Jogo, -- Nível atual, no seu estado atual
     ElementosJogo, -- Imagens/texturas que compõe o jogo
     Bool, -- Indica se o menu "Help" (menu de ajuda) está aberto (True) ou não (False)
     (Float,Float), -- Tuplo contendo os valores de escala em X e Y - utilizado na funcionalidade de ampliar ou diminuir o mapa
     Bot -- Estado atual da funcionalidade "Bot"
    )

-- | Tuplo contendo todas as texturas/imagens utilizadas no jogo.
type ElementosJogo = (Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture)

-- | Tuplo contendo apenas as imagens utilizadas para desenhar o mapa e o jogador ou bot.
type TexturasJogo = (Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture, Picture)

-- mapa --

{- | ’world’ representa a lista com a totalidade dos níveis/mapas do jogo, níveis que são importados do ficheiro __ListaJogos.hs__.
-}

world :: [Jogo]
world = [j1,j2,j3,j4,j5,j6,j7,j8,j9,j10]

-- reageJogo --

{- | __A função ’reageJogo’ atualiza o estado do jogo de acordo com os inputs que o utilizador realiza pelo teclado.__

É, assim, responsável por permitir ao utilizador interagir com o personagem e outras funcionalidades como ampliar e diminuir o mapa,
recomeçar o nível e abrir o menu Help.

Para isso, a função utiliza:

1. 'moveJogador', importada da Tarefa 4, para atualizar o estado do jogador e do mapa;
2. 'nextLevel', para atualizar a contagem de nível.

- __Nota:__ Esta função é ainda utilizada por 'reageTempo' para aplicar os movimentos do bot, uma vez que reageTempo simula o input do teclado.
-}

reageJogo :: Event -- ^ Input do utilizador pelo teclado
             -> EstadoJogo -- ^ Estado atual do jogo
             -> EstadoJogo -- ^ Estado atualizado do jogo

-- Andar para a esquerda (KeyLeft)
reageJogo (EventKey (SpecialKey KeyLeft) Down _ _) (n, nMax, v, j, ja, t, False, (s1,s2), b)
    | nextLevel n (moveJogador ja AndarEsquerda) == nMax = (n, nMax, True, j, ja, t, False, (s1,s2), b)
    | n == nextLevel n (moveJogador ja AndarEsquerda) = (n, nMax, v, j, moveJogador ja AndarEsquerda, t, False, (s1,s2), b)
    | otherwise = (n+1, nMax, v, j, j !! (n+1), t, False, (s1,s2), b)

-- Andar para a direita (KeyRight)
reageJogo (EventKey (SpecialKey KeyRight) Down _ _) (n, nMax, v, j, ja, t, False, (s1,s2), b)
    | nextLevel n (moveJogador ja AndarDireita) == nMax = (n, nMax, True, j, ja, t, False, (s1,s2), b)
    | n == nextLevel n (moveJogador ja AndarDireita) = (n, nMax, v, j, moveJogador ja AndarDireita, t, False, (s1,s2), b)
    | otherwise = (n+1, nMax, v, j, j !! (n+1), t, False, (s1,s2), b)

-- Trepar (KeyUp)
reageJogo (EventKey (SpecialKey KeyUp) Down _ _) (n, nMax, v, j, ja, t, False, (s1,s2), b)
    | nextLevel n (moveJogador ja Trepar) == nMax = (n, nMax, True, j, ja, t, False, (s1,s2), b)
    | n == nextLevel n (moveJogador ja Trepar) = (n, nMax, v, j, moveJogador ja Trepar, t, False, (s1,s2), b)
    | otherwise = (n+1, nMax, v, j, j !! (n+1), t, False, (s1,s2), b)

-- Interagir com uma caixa (KeyDown)
reageJogo (EventKey (SpecialKey KeyDown) Down _ _) (n, nMax, v, j, ja, t, False, (s1,s2), b)
    | nextLevel n (moveJogador ja InterageCaixa) == nMax = (n, nMax, True, j, ja, t, False, (s1,s2), b)
    | n == nextLevel n (moveJogador ja InterageCaixa) = (nextLevel n (moveJogador ja InterageCaixa), nMax, v, j, moveJogador ja InterageCaixa, t, False, (s1,s2), b)
    | otherwise = (n+1, nMax, v, j, j !! (n+1), t, False, (s1,s2), b)

-- Ampliar o mapa
reageJogo (EventKey (Char '+') Down _ _) (n, nMax, v, j, ja, t, h, (s1,s2), b)
    | s1 >= 1.9 = (n, nMax, v, j, ja, t, h, (s1,s2), b)
    | otherwise = (n, nMax, v, j, ja, t, h, (s1+0.1,s2+0.1), b)

-- Diminuir o mapa
reageJogo (EventKey (Char '-') Down _ _) (n, nMax, v, j, ja, t, h, (s1,s2), b)
    | s1 <= 0.6 = (n, nMax, v, j, ja, t, h, (s1,s2), b)
    | otherwise = (n, nMax, v, j, ja, t, h, (s1-0.1,s2-0.1), b)

-- Recomeçar o nível
reageJogo (EventKey (Char 'r') Down _ _) (n, nMax, v, j, ja, t, h, (s1,s2), b) = (n, nMax, v, j, world !! n, t, False, (s1,s2), b)

-- Abrir menu "Help"
reageJogo (EventKey (Char 'h') Down _ _) (n, nMax, v, j, ja, t, h, (s1,s2), b) = if not h
                                                                                 then (n, nMax, v, j, ja, t, True, (s1,s2), b)
                                                                                 else (n, nMax, v, j, ja, t, False, (s1,s2), b)

-- Qualquer outro input não altera o 'EstadoJogo'
reageJogo _ j = j

--

{- | __A função ’nextLevel’ atualiza a contagem de nível do 'EstadoJogo'.__

Para isso, a função:

1. Utiliza 'desconstroiMapa', importada da Tarefa 2, para transformar 'Mapa' em '[(Peca,Coordenadas)]';
2. Filtra a lista de forma a ficar apenas com a peça 'Porta';
3. Compara as coordenadas da 'Porta' do mapa com as coordenadas do jogador;
4. Se forem iguais, aumenta o nível, senão, mantém o nível.

== Exemplos de utilização:

>>> nextLevel 1 (Jogo [[Vazio,Vazio],[Porta,Vazio],[Bloco,Bloco]] (Jogador (0,1) Oeste False))
2
-}

nextLevel :: Int -- ^ Nº do nível atual
             -> Jogo -- ^ Jogo atual
             -> Int -- ^ Nº atualizado do nível
nextLevel n (Jogo m (Jogador (x1,y1) _ _)) | x1 == x2 && y1 == y2 = n+1 -- as coordenadas são iguais: aumenta em 1 o nº do nível
                                           | otherwise = n -- as coordenadas não são iguais: mantém o nº do nível atual
                                           where aux (p,(_,_)) = p == Porta
                                                 (x2,y2) = giveCoordinates $ head $ filter aux $ desconstroiMapa m
                                                 giveCoordinates (p,c) = c

-- drawJogo --

{- | __A função ’drawJogo’ desenha o ambiente gráfico onde o jogo dá lugar.__

Ou seja, desenha o mapa, jogador/bot e outros elementos como o plano de fundo e o menu Help.

Localmente, tem como principal função alternar a textura do jogador entre o " Steve " e o " Bot ", que estão dependentes naturalmente de o bot estar
ou não ativo e até de este conseguir ou não resolver o nível (retornar 'Nothing'). Para além disso, é responsável por desenhar o menu Help quando
este é selecionado (@h == True@).

Para a "construção" do jogo em si, utiliza a função auxiliar 'drawMapa' que recebe o nível atual / jogo atual e as texturas do mapa e do
jogador ('TexturasJogo').
-}

drawJogo :: EstadoJogo -> Picture
drawJogo (n, nMax, v, j, ja, (p6,p7,p8,p9,p10,p11,p12,p13,p14,p20,p22,p35,p36,p37,p38), h, (s1,s2), Bot b l)
    | not h && b && l == Nothing = Pictures $ p22 : [Scale s1 s2 $ drawMapa (ja, (p6,p7,p8,p9,p10,p11,p12,p37,p38))]
    | not h && b = Pictures $ p22 : [Scale s1 s2 $ drawMapa (ja, (p6,p7,p8,p9,p10,p11,p12,p35,p36))]
    | not h = Pictures $ p22 : [Scale s1 s2 $ drawMapa (ja, (p6,p7,p8,p9,p10,p11,p12,p13,p14))]
    | otherwise = p20

{- | __A função ’drawMapa’ desenha o mapa e o jogador/bot com a ajuda das funções 'jogadorCaixa' e 'mapToPicture'.__

Localmente, centra o mapa no ecrã do utilizador, de acordo com o seu tamanho em X e em Y (obtido com as funções da Tarefa 1: 'xMax' e 'yMax'),
recorrendo a 'Translate'. Para além disso, utiliza 'desconstroiMapa' para transformar o mapa do tipo 'Mapa' para o tipo @[(Peca,Coordenadas)]@,
que é usado pelas funções 'jogadorCaixa' e 'mapToPicture'.
-}

drawMapa :: (Jogo, TexturasJogo) -> Picture
drawMapa (Jogo mapa j, t) = Translate dx dy $ Pictures (jogadorCaixa j t ++ mapToPicture m m t)
    where m = desconstroiMapa mapa
          dx = fromIntegral (xMax m) * (-960) / 30
          dy = fromIntegral (yMax m) * 540 / 17

{- | __A função ’jogadorCaixa’ desenha o jogador/bot de acordo com as suas coordenadas e estado atual.__

Para isso, a função tem a conta, para além da sua posição, a sua direção (@Este@ ou @Oeste@) e se está ou não a segurar numa caixa
(@b == True@ ou @b == False@). A função auxiliar 'converteCoordenada' é utilizada, como o nome sugere, para converter coordenadas simples em
coordenadas que têm em conta o tamanho dos elementos do mapa e o funcionamento das coordenadas no Gloss.
-}

jogadorCaixa :: Jogador -> TexturasJogo -> [Picture]
jogadorCaixa (Jogador (c,l) d b) (_, _, box, _, _, _, _, dudeE, dudeO)
    | d == Este && b = [jEste, Translate (fromIntegral x) (fromIntegral y+64) box] -- voltado para direita e segura numa caixa
    | d == Oeste && b = [jOeste, Translate (fromIntegral x) (fromIntegral y+64) box] -- voltado para esquerda e segura numa caixa
    | d == Este = [jEste] -- voltado para a direita
    | d == Oeste = [jOeste] -- voltado para a esquerda
    where (x,y) = converteCoordenada (c,l)
          jEste = Translate (fromIntegral x) (fromIntegral y) dudeE
          jOeste = Translate (fromIntegral x) (fromIntegral y) dudeO

{- | __A função ’mapToPicture’ desenha o mapa do jogo.__

É uma função recursiva que utiliza 'pecaToPicture' para representar cada peça do mapa individualmente até que todas estejam representadas.
-}

mapToPicture :: [(Peca,Coordenadas)] -> [(Peca,Coordenadas)] -> TexturasJogo -> [Picture]
mapToPicture [] _ _ = [] -- caso de paragem: todas as peças foram transformadas em 'Picture'
mapToPicture (x:xs) m t = pecaToPicture x t m : mapToPicture xs m t

{- | __A função ’pecaToPicture’ desenha uma peça do mapa.__

Embora pareça simples, esta função tem um papel extremamente importante no que toca às texturas que se adaptam ao meio, que é o caso das
texturas da peça 'Bloco' e da peça 'Caixa' que se adaptam da seguinte forma:

- __Bloco:__ É representado por um "bloco de relva" quando não existem peças acima (@Vazio@) e por um "bloco de terra" caso contrário;

- __Caixa:__ É representada por um pistão que extende quando se empilham 2 ou mais caixas.

Ambas estas texturas foram inspiradas no jogo " Minecraft ", onde funcionam de forma semelhante.

Para avaliar que textura usar, esta função recebe o mapa do jogo em formato @[(Peca,Coordenadas)]@, o que permite verificar facilmente
se existe um elemento da lista, ou seja, uma peça em determinadas coordenadas que irá influenciar o resultado. Para além disso, usa também
'converteCoordenada' de forma análoga a 'jogadorCaixa'.
-}

pecaToPicture :: (Peca,Coordenadas) -> TexturasJogo -> [(Peca,Coordenadas)] -> Picture
pecaToPicture (p,(c,l)) (grass, dirt, box, boxe, boxmiddle, boxup, door, _, _) m

    -- Se existe um 'Bloco' acima do atual, então a textura será "bloco de terra" (dirt), caso contrário será relva (grass).
    | p == Bloco = if (Bloco,(c,l-1)) `elem` m then Translate (fromIntegral x) (fromIntegral y) dirt else Translate (fromIntegral x) (fromIntegral y) grass

    {- 1. Se existe uma 'Caixa' acima e abaixo da atual, então a textura será o "centro do pistão extendido" (boxmiddle);
       2. Se existe uma 'Caixa' acima da atual, então a textura será "base do pistão extendido" (boxe);
       3. Se existe uma 'Caixa' abaixo da atual, então a textura será "topo do pistão extendido" (boxup);
       4. Se nenhum destes casos se confirma, então a textura será simplesmente "pistão não extendido" (box) -}
    | p == Caixa = if elem (Caixa,(c,l+1)) m && elem (Caixa,(c,l-1)) m then Translate (fromIntegral x) (fromIntegral y) boxmiddle -- 1.
                   else if (Caixa,(c,l-1)) `elem` m then Translate (fromIntegral x) (fromIntegral y) boxe -- 2.
                   else if (Caixa,(c,l+1)) `elem` m then Translate (fromIntegral x) (fromIntegral y) boxup -- 3.
                   else Translate (fromIntegral x) (fromIntegral y) box -- 4.

    -- Porta
    | p == Porta = Translate (fromIntegral x) (fromIntegral y) door
    where (x,y) = converteCoordenada (c,l)

{- | A função ’converteCoordenada’ tem como objetivo transformar as coordenadas simples utilizadas no mapa do formato @[(Peca,Coordenadas)]@ em
coordenadas que têm em conta o tamanho das peças do mapa (neste caso 64 x 64) e os eixos em que as coordenadas trabalham no Gloss.

Tendo isso em conta, a função multiplica cada coordenada X e Y por 64 e inverte o sinal de Y para que fique em conformidade com o eixo Y do Gloss.

== Exemplos de utilização:

>>> converteCoordenada (1,1)
(64,-64)
-}

converteCoordenada :: (Int,Int) -> (Int,Int)
converteCoordenada (x,y) = (x*64,(-y)*64)


-- BOT --


-- | Estado atual da funcionalidade "Bot".
data Bot =
    Bot
    Bool -- ^ Indica se o bot está ativado (True) ou não (False)
    (Maybe [Movimento]) -- ^ Lista de movimentos necessários para concluir o nível atual (calculados em 'reage' com a função importada da Tarefa 6 'resolveJogo')

{- | __A função ’reageTempo’ é responsável por "animar" o Bot a resolver o nível atual do jogo.__

Como é referido em 'fr', esta função está dependente da "frame rate" (taxa de atualização) imosta na função 'play' do Gloss. O que significa,
neste caso, que, se o Bot for ativado, ela irá ser invocada a cada 0,5 segundos. Cada vez que é invocada, um dos movimentos do Bot será aplicado
ao jogo, até que a lista de movimentos necessários para conlcluir o nível (calculada por 'resolveJogo') esteja vazia.

’reageTempo’ tira proveito da função 'reageJogo' para aplicar os movimentos, e o que faz é simplesmente invocar essa função simulando um input
do utilizador no teclado, input que será o equivalente ao movimento que pretende executar.

Assim, a função faz para cada movimento a seguinte avaliação:

1. Se a cauda da lista é nula/vazia (@null ms@), então todos os movimentos já terão sido aplicados após o atual e o Bot é desativado (@Bot False Nothing@);
2. Caso contrário, ainda temos movimentos a aplicar e por isso aplicamos o movimento atual sem alterar o estado do Bot.
-}

reageTempo :: Float -> Estado -> Estado

-- O Bot está ativo (Bot True ...), logo a função irá funcionar.
reageTempo _ (E em ej@(n,nMax,v,j,ja,t,h,(s1,s2),Bot True (Just (m:ms))) ep en)
    | m == AndarDireita = if null ms
                          then E em (reageJogo (EventKey (SpecialKey KeyRight) Down a b) (n,nMax,v,j,ja,t,h,(s1,s2),Bot False Nothing)) ep en -- 1.
                          else E em (reageJogo (EventKey (SpecialKey KeyRight) Down a b) (n,nMax,v,j,ja,t,h,(s1,s2),Bot True (Just ms))) ep en -- 2.
    | m == AndarEsquerda = if null ms
                           then E em (reageJogo (EventKey (SpecialKey KeyLeft) Down a b) (n,nMax,v,j,ja,t,h,(s1,s2),Bot False Nothing)) ep en -- 1.
                           else E em (reageJogo (EventKey (SpecialKey KeyLeft) Down a b) (n,nMax,v,j,ja,t,h,(s1,s2),Bot True (Just ms))) ep en -- 2.
    | m == Trepar = if null ms
                    then E em (reageJogo (EventKey (SpecialKey KeyUp) Down a b) (n,nMax,v,j,ja,t,h,(s1,s2),Bot False Nothing)) ep en -- 1.
                    else E em (reageJogo (EventKey (SpecialKey KeyUp) Down a b) (n,nMax,v,j,ja,t,h,(s1,s2),Bot True (Just ms))) ep en -- 2.
    | m == InterageCaixa = if null ms
                           then E em (reageJogo (EventKey (SpecialKey KeyDown) Down a b) (n,nMax,v,j,ja,t,h,(s1,s2),Bot False Nothing)) ep en -- 1.
                           else E em (reageJogo (EventKey (SpecialKey KeyDown) Down a b) (n,nMax,v,j,ja,t,h,(s1,s2),Bot True (Just ms))) ep en -- 2.
    | otherwise = E em ej ep en

    {- 'reageJogo', assim como qualquer outra função "reage" neste jogo, não tem em conta as seguintes variáveis, pelo que 'a' e 'b' são valores
       aleatórios que são utilizados na invocação da função 'reageJogo' e que não têm qualquer influência na mesma. -}
    where a = Modifiers Down Down Down
          b = (1,1)

-- O Bot não está ativo, logo a função não altera o estado do jogo.
reageTempo _ e = e