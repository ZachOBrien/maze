# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

**Run all unit tests:**
```bash
raco test Maze
```

**Run unit tests for a single module:**
```bash
raco test Maze/Common/board.rkt
```

**Run integration tests:**
```bash
./xtest-integration
```

**Run via Docker (as CI does):**
```bash
./build_docker.sh
docker run maze:latest
```

## Architecture

This is a Racket implementation of the board game [Labyrinth](https://en.wikipedia.org/wiki/Labyrinth_(board_game)), using a client-server architecture.

```
Client                              Server
  Player ──────────────────────────── Referee
  ProxyReferee ←──TCP──→ ProxyPlayer
         ↕                     ↕
         └────── Common ───────┘
              (shared game logic)
```

### Directory Overview

| Directory | Role |
|-----------|------|
| `Common/` | Game data structures and rules: `board.rkt`, `tile.rkt`, `gem.rkt`, `state.rkt`, `player-info.rkt`, `rulebook.rkt` |
| `Players/` | Player interface/implementations (`player.rkt`) and AI strategies (`strategy.rkt`) |
| `Referee/` | Game coordination (`referee.rkt`) and GUI observer (`observer.rkt`) |
| `Remote/` | Network proxies: `player.rkt` (server-side proxy), `referee.rkt` (client-side proxy), `tcp-conn.rkt`, `safety.rkt` |
| `Server/` | TCP listener that collects players and calls the referee |
| `Client/` | TCP connector that wraps a local player and forwards RPC calls |

### Key Data Flow

1. **Server** (`Server/server.rkt`) listens for TCP connections → wraps each in a `proxy-player` (`Remote/player.rkt`)
2. **Referee** (`Referee/referee.rkt`) runs `run-game` with the proxy players and a `referee-state`
3. Each player turn: referee calls `safe-get-action` (sandboxed with a 4-second time limit via `racket/sandbox`) → validates move via `rulebook.rkt` → applies to `state`
4. **Client** (`Client/client.rkt`) connects to server → wraps a local player in a `proxy-referee` (`Remote/referee.rkt`) → dispatches incoming JSON RPC messages (`setup`, `take-turn`, `win`, `get-goal`) to the local player

### Player Interface

All players (local and remote) implement `player-interface` defined in `Players/player.rkt`:
- `name` → String
- `propose-board` → Board
- `setup` → Void (receives initial state and goal position)
- `take-turn` → Action (a `Move` or `#f` to pass)
- `win` → Void
- `get-goal` → GridPosn or `#f`

### Strategies

Two strategies in `Players/strategy.rkt`:
- **Riemann**: Enumerates candidate moves in row-major order over goal positions, picks the first reachable one
- **Euclidean**: Same enumeration but breaks ties by Euclidean distance to goal

### Testing Conventions

Each `.rkt` file contains its tests in submodules:
- `(module+ test ...)` — unit tests using `rackunit`
- `(module+ examples ...)` — shared test fixtures exported for use by other modules' tests
- `(module+ serialize ...)` — JSON serialization/deserialization logic

Import another module's examples with:
```racket
(require (submod "../Common/board.rkt" examples))
```

### Misbehaving Player Handling

`Remote/safety.rkt` provides `execute-safe` which wraps player calls in a sandbox. Players that raise exceptions or time out return `'misbehaved`, causing the referee to remove them from the game. `Players/player.rkt` also exports several `player-bad-*%` and `player-infloop-*%` classes for testing fault-tolerance.
