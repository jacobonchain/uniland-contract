# Welcome to UniLand
https://uniland.club

This is the Aleo contract repository for the Uniland game (a parallel privacy universe chessboard game).
![1](https://github.com/jacobonchain/uniland-contract/assets/167742857/5b42ad5d-5e93-453a-b9f2-83f551409a5c)


## One Move, Parallel Universes

This is a parallel universe, 'Uniland Othello', where every move creates a new reality.
Embark on a strategic quest to conquer wisdom-rich planets, shielded by [Aleo](https://aleo.org/)'s privacy technology.
Here, every move is a secret that shapes the AI's learning path. Dive into the Chess Planet Odyssey, One Move, Parallel Universes.

**Visit our website: https://uniland.club**

## Game Rules （[More details](https://uniland.club/vote-rule)）

- Types of Planets

1. Genesis Planet: The starting point of the game, where all voting and decisions begin.
2. Journey Planet: Various decision points during the game, players vote to decide the next move.
3. Smart Planet: The planet that finally defeats Al, and occupying it will earn Smart Star points.

- Voting Mechanism
![2](https://github.com/jacobonchain/uniland-contract/assets/167742857/538a71c5-17c2-4adc-8be2-2b3d72bec054)
1. If a Journey Planet receives only one vote, we continue in that direction, exploring the next planet.

![3](https://github.com/jacobonchain/uniland-contract/assets/167742857/0793f7e9-32e7-4dec-b30b-ddd07c623f5a)
2. If a Journey Planet receives two or more votes, this path opens up new possibilities. Now, players can cast more votes on this new planet, deciding how to further explore.

3. Once a vote has been cast on a new Journey Planet, the previous path is closed, and you can no longer go back to vote.



## Reward Distribution Mechanism （[More details](https://uniland.club/reward-rule)）

- Scoring System: In this game, points are referred to as "Energy". Every planet (i.e., each board state) has potential Energy.
- Reward Calculation: The Energy of the victorious planet is calculated based on the number of winning pieces and the number of planets on the path. For example, if humans defeat AI with a score of 60:4, the number of winning pieces is 60-4=56. Then, calculate the total number of planets on the winning path, assumed to be N. Hence, each planet on the winning path will add 56/N Energy to its existing Energy.
- Reward Characteristics:
   - Early Stage of the Game: The uncertainty of players' voting results is high, but due to the existence of multiple potential paths, the chances of accumulating Energy are relatively more.
   - Later Stage of the Game: Although the chances of players getting path rewards are less, the certainty of winning or losing is higher, making it easier to gain a large amount of Energy.

## Experimental

UniLand is not just an Othello game, but an experimental extension of ZK privacy blockchain technology. We aim to transfer more collective intelligence of players to AI, and this process hopes to realize voting management and reward distribution through ZK’s privacy technology. This makes the game interaction more fair and interesting, and traces the intellectual contributions of humans.  

## Build Guide

To compile this Aleo program, run:

```sh
aleo build
