# TODO

Everything that is pending in the session that ports the raylib games to
Atmos (`ia-atmos/env-ray`): asked and not decided, reported and not
acknowledged, or known and not done. Keep it current: remove an item when
it is settled, add one whenever something is left open, in the same commit
when possible.

Items are `#N` (a standing rule of the author, 2026-11-18): unique in this session, in order, never reused or changed; from another session, `session#N` (`env-ray#24`, `atmos-lang#22`). An item that closes is removed from the tables below and keeps its number. The next number is `#47`. Nothing else is enumerated with bare numbers.

Sessions (by the name of their repository): this one is `env-ray`; the compiler is `atmos-lang` (session_011eECogKVQ7ZzmWCoMST2wK); everything about `pin` goes to `atmos-pin` (session_011eECogSDhkVfyt7qme5DLh); the events across environments, `envs` (session_011eECofYWTNPACTtUjHN4p6); Lessmilk is `ray-lessmilk` (session_011eECohyasjWkvCHdxGxJ6D).

Last update: 2026-11-22.

## A. Decisions waiting for an answer

Each has the option recommended by this session.

| # | Decision | Recommended |
|---|----------|-------------|
| #1 | The remotes: this repository is now `ia-atmos/env-ray`, the compiler `ia-atmos/lang` (the old addresses redirect; the names in `README.md`, `doc/compiler.md`, `tools/setup.sh` are updated). The remote of this checkout and of `ext/ceu-atmos` still name the old addresses: changing a remote is refused by the permissions of this session (auto mode) | The author allows it, or runs `git remote set-url origin https://github.com/ia-atmos/env-ray` and `git -C ext/ceu-atmos remote set-url origin https://github.com/ia-atmos/lang`. Not urgent: pushes still go through |
| #44 | The build option `ATMOS_FLOAT=32` of the compiler (formerly `ATMOS_REAL=float`; in lang main since d19d40f; a real is a C float) against the rounding by hand with `ray.f32`. Tried on arkanoid (2026-11-20, lang c4e99c4, not merged): with float reals and its 13 calls of `ray.f32` removed, both runs are identical to the original (`lose`, 1517 frames, and `win`, 21460 frames; two screens checked); with the default doubles the same file diverges at line 7531 of `win`. The port as it is also stays identical with float reals. `ray.atm` was checked under the three options: the time is now emitted in the unit of the build (it was always microseconds), and `tst/env` passes under `ATMOS_FLOAT=32`, `ATMOS_INTEGER=32` and `ATMOS_CLOCK=ms` (formerly `ATMOS_REAL`, `ATMOS_INT`, `ATMOS_TIME`), trace and screen. To watch: a color (0xRRGGBBAA) computed as a real loses bits with float reals (drturtle adds a real to one); `sin` and `cos` where the C mixes doubles | Waiting for the author to decide which options each environment supports (atmos-float#14). Then: build the ports with float reals, and drop `ray.f32` game by game where the runs stay identical. Reported to atmos-float |
| #5 | The original of koala_seasons reads the date (`time`), so its runs are not repeatable; the test mode fixes it, by a patch of the original (`tools/original.patch`) and the same in the port | Keep it, as written in `doc/fidelity.md` |
| #21 | Lessmilk (`ia-atmos/ray-lessmilk`) has no patch of its own to merge: its binding is `raylib.atm` of 4360cb2 with `pin rl`, and its test patch is ours. It stays on compiler f3389f6 and binding 4360cb2 until a case of pin is settled by the compiler session (16 of its 33 runs fail on 1746969), then it moves to `ray.atm`, `atmos-ray` and the vocabulary of events at once | Nothing to do here; Lessmilk will tell |

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
| #46 | `context` (atmos-context, issue 21): platformer and retro_maze_3d rewritten with `context ray.ctx.mode2d/texture_mode(...)` on the branch `exp-context` (d4f30e3, lang b71fbe4, pushed 2026-11-22, not to merge); 5 of 5 runs identical; what does not fit reported (the inline block, pools inside, enter/leave on every event) | Misfit 3 answered on lang 152cba6: `context <:draw> X {...}` enters only during a `:draw`. Optional: re-measure the enters on the branch (it predates `mute`, f416c03) |
| #11 | Differences that no run shows, kept as documented: snake (two keys in one frame), gold_fever (ENTER in the frame of the last coin), skully_escape (a door taken during the 80 frames of a death) | See `doc/fidelity.md` |

## C. Reported and not acknowledged

| # | Report |
|---|--------|
| #12 | The summary and conclusions of the port (all 23 games, identical on 55 runs; 96 of 134 control variables become structure, 38 stay; CPU 1.02 times the C; 1.4 against 0.75 µs per enemy in the stress) |
| #13 | The last full regression: 57 checks, none failed (2026-11-22, compiler f416c03: `toggle` became `mute`; also on 98e4787, and under ASAN on f999c52); every run against its original (#8, 2026-11-20: 37 of 55 identical, the other 18 are the runs of the relaxed games, as listed in `doc/fidelity.md`) |
| #14 | The logo of `games/screens.atm` showed "raylib" whole for 12 frames before its first letter; fixed (TextSubtext, as the C) |
| #15 | `raylib.atm` (now `ray.atm`) grew: `rl.poly`, shaders, gestures, the touch position; `Screens` keeps its state in its `pub`. Lessmilk was told |
| #16 | The original of transmission aborts (`free` of a static buffer of raylib 6.2) on a wrong word; no run can use one |
| #17 | The pitfalls of the compiler found by the ports, in `doc/compiler.md` (`test` and `catch` are keywords, `%` is `fmod`, indexing a literal, `await` of an expression, `pin` in a table, a local that hides a parameter) |
| #18 | The new documents: `doc/case-study.md`, `doc/bench.md`, `launcher.atm`, `tools/compare-all.sh` |

## D. Older

| # | Item |
|---|------|
| #19 | The plan said the assets would not be copied; the author chose to copy them into the repository (done). Their license is the one of each game's README (`README.original.md`); koala_seasons and others credit artists whose terms are not stated beyond the zlib license of the code |
