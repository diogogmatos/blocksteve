# BlockSteve

This little game was developed during the first semester of the Computer Science and Engineering degree at UMinho (University Of Minho - Braga, Portugal).
The full process of development was evaluated and established the final grade for the "Laboratórios de Informática I" subject.

The project consisted of recreating the game *BlockDude* (originally developed for Texas calculators) from the ground up, with the freedom to add features and completely change the graphical appearance, which was, in this case, heavily inspired by the classic game Minecraft.
The objective is to use the piston blocks throughout the map to help the player navigate and reach the portal.

The game was fully developed in Haskell and consisted of 6 tasks, each with its unique purpose:

- **Task 1** - Assesses if a map (meant to be played) is valid, according to determined parameters;
- **Task 2** - Transforms a map from the data type "[(Peca, Coordenadas)]" to "Mapa" and vice-versa;
- **Task 3** - Instance Show meant to display an output of the type "Jogo" as a string that creates a graphical representation of the current game state;
- **Task 4** - Updates the current game state according to the players' movements;
- **Task 5** - Graphical interface, developed with the Graphics.Gloss library, which can be found at: https://hackage.haskell.org/package/gloss
- **Task 6** - Calculates the minimum necessary player movements to complete a map. (Unfinished)

## Game Images:

**Menu**

<img align="center" width="700px" alt="Menu" src="https://github.com/sassypocoyo/blocksteve/blob/main/menu.png?raw=true" />

**In-game**

<img align="center" width="700px" alt="In-game" src="https://github.com/sassypocoyo/blocksteve/blob/main/level.png?raw=true" />

**Pause**

<img align="center" width="700px" alt="Pause" src="https://github.com/sassypocoyo/blocksteve/blob/main/pause.png?raw=true" />

**Level Selection**

<img align="center" width="700px" alt="Level Selection" src="https://github.com/sassypocoyo/blocksteve/blob/main/level-selection.png?raw=true" />

## Installing and running the game:

If you want to try this, you'll first need a Linux based system like macOS or Ubuntu. Depending on which, the process will be slightly different.

### Haskell Platform

Installing *Haskell Platform* will give you all the dependencies you need for this to work, including GHC and Cabal.

Follow the instructions for your specific system at: https://www.haskell.org/platform/

### Gloss Library

Finally, since the graphical interface of the game was developed using the Gloss library, you'll need to install it doing the following:

```bash
$ cabal update
$ cabal install gloss
$ cabal install gloss-juicy
```
**Arch based systems:**

If you're using an Arch-based distribution, like Manjaro or ArcoLinux, you may need to do some tweaks to Cabal to successfully install Gloss. Learn more here: https://wiki.archlinux.org/title/haskell#Cabal.

Also, make sure to additionally use the flag "--lib" when running cabal commands.

### Compiling

We're all set up, all that's left to do is compile the game executable by doing:

```bash
$ cd 2021li1g099/src
$ ghc Tarefa5_2021li1g099.hs
$ ./Tarefa5_2021li1g099
```
P.s: Use ESC to exit ;)

**Enjoy!**

## Developed by:

- **A100741** Diogo Matos;
- **A100537** Rui Pedro Cerqueira.
