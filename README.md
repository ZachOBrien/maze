<h1 align="center">
  :gem: MAZE :gem:
</h1>

<h4 align="center">An implementation of <a href="https://en.wikipedia.org/wiki/Labyrinth_(board_game)">Labyrinth</a>.</h4>

<p align="center">
  <a href="#about">About</a> •
  <a href="#directory-structure">Directory Structure</a> •
  <a href="#try-it-out">Try it Out</a>
</p>

## About

<p>
  <a href="https://racket-lang.org">
    <img src="https://img.shields.io/badge/racket-8.6-blue"
         alt="Racket 8.6">
</p>

<a href="https://en.wikipedia.org/wiki/Labyrinth_(board_game)"><img src="https://upload.wikimedia.org/wikipedia/en/d/dd/Amazing_Labyrinth_game_box.jpg" alt="Labyrinth Box" width="300"></a>

Maze is an implementation of the board game "Labyrinth". The real game involves players navigating a maze, represented as a physical grid board of pathways, with the objective of collecting treasure.

This repository implements a client-server architecture and basic GUI for configuring and observing the game. To find more information on each of these architectural components, see the `README` in their respective directories.

```
+-----------------+                    +-----------------+
| Client          |                    | Server          |
+-----------------+                    +-----------------+
|                 |                    |                 |
| Player          |                    | Referee         |
|                 |-------+    +-------|                 |
| ProxyReferee    |       |    |       | ProxyPlayer     |
+-----------------+       |    |       +-----------------+
                          |    |
                          v    v
            +----------------------------------+
            | Shared Understanding of the Game |
            | (Common/ directory)              |
            +----------------------------------+
            |                                  |
            | game pieces (gems, tiles, board) |
            |                                  |
            | Gamestate                        |
            |                                  |
            | rules of the game                |
            +----------------------------------+
```

## Directory Structure

| Directory | Purpose |
| --------- | ------- |
| Assets | Static assets. Currently only image files for gems |
| [Client](Maze/Client/README.md) | A client which connects to a game server |
| [Common](Maze/Common/README.md) | Core data structures and logic for the game |
| Planning | Planning for milestones and changes to the codebase |
| [Players](Maze/Players/README.md) | The player interface, protocol, and implementations |
| [Referee](Maze/Referee/README.md) | Component responsible for coordinating players and enforcing rules |
| [Remote](Maze/Remote/README.md) | Mechanisms for communicating over a network connection |
| [Server](Maze/Server/README.md) | A server which accepts client connections and facilitates the game | 


## Try it Out

Install Racket version 8.6

Install `raco`

### Run Integration Tests

Run all integration tests:

```
./xtest-integration
```

### Run Unit Tests

Run all unit tests:

```
./xtest
```

Run unit tests for a specific module

```
raco test [PATH-TO-MODULE]
```
