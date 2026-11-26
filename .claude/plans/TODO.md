# TODO

Everything that is pending in the session that ports the raylib games to
Atmos (`ia-atmos/env-ray`): asked and not decided, reported and not
acknowledged, or known and not done. Keep it current: remove an item when
it is settled, add one whenever something is left open, in the same commit
when possible.

Items are `#N` (a standing rule of the author, 2026-11-18): unique in this session, in order, never reused or changed; from another session, `session#N` (`env-ray#24`, `atmos-lang#22`). An item that closes is removed from the tables below and keeps its number. The next number is `#52`. Nothing else is enumerated with bare numbers.

Sessions (by the name of their repository): this one is `env-ray`; the compiler is `atmos-lang` (session_011eECogKVQ7ZzmWCoMST2wK); everything about `pin` goes to `atmos-pin` (session_011eECogSDhkVfyt7qme5DLh); the events across environments, `envs` (session_011eECofYWTNPACTtUjHN4p6); Lessmilk is `ray-lessmilk` (session_011eECohyasjWkvCHdxGxJ6D).

Last update: 2026-11-26.

At each big step (a milestone, a change of what is on screen), the report to the author shows a few screenshots (the author, 2026-11-26, relayed by `atmos`). Also, for each group of changes, one pair of short Atmos excerpts from that work, with file and line: one idiomatic, one bad (awkward, verbose, a workaround). Each excerpt takes a `#N` and is listed below (section E); each bad one says why, and what would make it better (the language, the environment, or the port).

## A. Decisions waiting for an answer

Each has the option recommended by this session.

| # | Decision | Recommended |
|---|----------|-------------|

## B. Work known and not done

| # | Work | Note |
|---|------|------|
| #6 | Paths that no run covers, ported but not compared: koala_seasons (the final form, the eagle, summer and winter in play, fire, ice, gestures); retro_maze_3d (time and stamina running out: 18000 and 10000 frames); pang (the victory); light_my_ritual (the win by light); cat_vs_roomba (the win); tetris (the clear of lines, which the C never does); missile_commander (the 101st missile, the 100 explosions); cat_vs_roomba (a second game) | Each is in `doc/fidelity.md`. A better generator could reach some: the autopilot of koala, the route of light_my_ritual |
| #9 | A stress case of `raylife` | Not made: its board is C in the port too |
| #10 | The CPU at 60 fps in `doc/bench.md` is derived from the CPU per frame, not measured apart | Measure it with the frame cap, if it matters Not done on 2026-11-20: it needs the test mode to wait in real time; the logic alone was measured instead (`RL_NODRAW`, `doc/bench.md`: 2.14 times the C over the 23 games, 1.02 for the whole frames) |
| #24 | Relax the exactness in favor of expressiveness, keeping the intent of the original author (agreed by the author, 2026-11-16). Candidates: the flags kept only to match the C frame by frame (38 control variables left, `doc/state.md`), the globals never reset, the 32-bit rounding (`ray.f32`), the order of the random draws, the init of the next screen under the old one; and the lists emptied with `vector.clear` | Started. Done: no list is emptied any more (the state of a game is made in each game: snake, gorilas, missile_commander relaxed; space_invaders and transmission still identical); the slots of missile_commander are pools. One small commit per relaxation, with its stored results replaced, and the deliberate differences in "Relaxed ports" of `doc/fidelity.md`. Then (2026-11-19, asked by the author): tetris clears full lines, space_invaders ends a wave at `>=` its kills, platformer resets the jump in each game (all three still identical on their runs). Declined: the placement of the meteors of asteroids and asteroids_survival (the C does not reset `ok`): fixing it moves every meteor from frame 1, and the scripted runs (made by `gen.py` on a model of the C) no longer win or survive. The 32-bit rounding and the order of the random draws are skipped for now (the author, 2026-11-20); the suggestions that are left are #30 to #43 |
| #37 | pang: the second big ball has the speed of the first (`velx`, `vely` not reset) | With the random relaxations (it changes the draws from frame 1): skipped for now |
| #38 | asteroids, asteroids_survival: only the first meteor checks its x against the center (`ok` not reset) | Declined on 2026-11-19: it moves every meteor, and the scripted runs no longer win or survive. With the random relaxations, if ever |
| #39 | koala_seasons: the state of the koala, the alerts, the kills of the ending and others go from game to game; the gameplay and the ending are initialized under the old screen | Large (the biggest port). Leave, unless the author wants it |
| #40 | just_do: done stays done (a second visit to a level skips the play); the key 9 shows a level never initialized | Leave: it reads as a choice of the original, not as a slip |
| #41 | transmission: the words of the message keep the tail of a longer word of the last mission (`strncpy` with no terminator) | Leave: it is in the C of the original that the port reuses in a prelude |
| #42 | floppy: no wall at the top of the screen (floppy flies over the tubes and scores) | Leave: a wall changes the game, and the run `top` exists to show this |
| #11 | Differences that no run shows, kept as documented: snake (two keys in one frame), gold_fever (ENTER in the frame of the last coin), skully_escape (a door taken during the 80 frames of a death) | See `doc/fidelity.md` |

## C. Reported and not acknowledged

| # | Report |
|---|--------|
| #12 | The summary and conclusions of the port (all 23 games, identical on 55 runs; 96 of 134 control variables become structure, 38 stay; CPU 1.02 times the C; 1.4 against 0.75 µs per enemy in the stress) |
| #13 | The last full regression: 57 checks, none failed (2026-11-23, compiler 656e7eb, after #44; also on 98e4787, and under ASAN on f999c52); every run against its original (#8, 2026-11-20, before #44: 37 of 55 identical) |
| #14 | The logo of `games/screens.atm` showed "raylib" whole for 12 frames before its first letter; fixed (TextSubtext, as the C) |
| #15 | `raylib.atm` (now `ray.atm`) grew: `rl.poly`, shaders, gestures, the touch position; `Screens` keeps its state in its `pub`. Lessmilk was told |
| #16 | The original of transmission aborts (`free` of a static buffer of raylib 6.2) on a wrong word; no run can use one |
| #17 | The pitfalls of the compiler found by the ports, in `doc/compiler.md` (`test` and `catch` are keywords, `%` is `fmod`, indexing a literal, `await` of an expression, `pin` in a table, a local that hides a parameter) |
| #18 | The new documents: `doc/case-study.md`, `doc/bench.md`, `launcher.atm`, `tools/compare-all.sh` |

## D. Older

Closed as won't do: #1 (the remotes still name the old addresses, which redirect; the author, 2026-11-22).
Done: #49 and #48 (lang d0fe0ac, 2026-11-26: a context is a value bound with `in <P> X, cmd`, and `context { :enter :leave ... }`; platformer binds its pool from outside, with no `emit :taken`; retro_maze_3d clears in `:enter`; runs identical).
Done: #46 (`context <:draw>` in platformer and retro_maze_3d, in main since ba8a8b6, lang 656e7eb; runs identical, 1 enter per frame; misfits 1, 2, 4 reported to atmos-context).
Done: #44 (the author, 2026-11-22: no fidelity to the floats of the C; the ports compute in the default doubles, with no `ray.f32` and no build option; 21 games relaxed, floppy and pang identical; the input of arkanoid `win` made again on doubles. `ATMOS_FLOAT=32` was measured first: 19 games identical, 4 not, since their C mixes doubles).
Closed: #21 (Lessmilk moved on 2026-11-20: its env/ray.atm is a copy of env-ray 8350e6f, the new events, its own tools/atmos.sh; 33 tests pass on lang 98e4787, f416c03, and with ASAN; not blocked on env-ray. It asked for `ray.stop_sound`; it added RL_NODRAW to its patch, as ours has).
Closed as decided: #5 (koala_seasons keeps the date fixed by the patch of the original in the test mode, as in `doc/fidelity.md`; the author, 2026-11-22).

| # | Item |
|---|------|
| #19 | The plan said the assets would not be copied; the author chose to copy them into the repository (done). Their license is the one of each game's README (`README.original.md`); koala_seasons and others credit artists whose terms are not stated beyond the zlib license of the code |

## E. Excerpts shown to the author

| # | Kind | Where | Note |
|---|------|-------|------|
| #47 | idiomatic | `games/retro_maze_3d/main.atm:477` | `context <:draw> ray.ctx.texture_mode(target) {...}` around the screens: the pair begin/end disappears from the code |
| #48 | bad | `classics/platformer.atm:173-204` | `emit :taken; await false` inside the context, `await :taken` in Play: the inline block of `context` forces an invented event and a never-waking await so Play goes on while the world draws. Better: a `context` usable as a spawn target, or a way to await an inner phase (language; misfit 1, reported to atmos-context) |
| #50 | idiomatic | `classics/platformer.atm:172-198` | `val world = ray.ctx.mode2d(...)`; `in <:draw> world` bound to the tiles, the pool of coins and the player; Play goes on with `await :all coins`: the mode is a value, and the pool lives where Play can await it (lang d0fe0ac) |
| #51 | bad | `classics/platformer.atm:173, 183, 187` | `in <:draw> world,` written three times, once per thing that draws in the mode: the repetition is the price of keeping the pool outside. Grouping without a block was rejected by the author (atmos-context 261126-context-blocks.md §5); a block whose pools stay visible after it leaks scope. Sent to atmos-context as a question (2026-11-26): the repetition may be the accepted cost |
