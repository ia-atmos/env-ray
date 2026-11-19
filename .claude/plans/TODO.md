# TODO

Everything that is pending in the session that ports the raylib games to
Atmos (`ia-atmos/env-ray`): asked and not decided, reported and not
acknowledged, or known and not done. Keep it current: remove an item when
it is settled, add one whenever something is left open, in the same commit
when possible.

Items are `#N` (a standing rule of the author, 2026-11-18): unique in this session, in order, never reused or changed; from another session, `session#N` (`env-ray#24`, `atmos-lang#22`). An item that closes is removed from the tables below and keeps its number. The next number is `#30`. Nothing else is enumerated with bare numbers.

Sessions (by the name of their repository): this one is `env-ray`; the compiler is `atmos-lang` (session_011eECogKVQ7ZzmWCoMST2wK); everything about `pin` goes to `atmos-pin` (session_011eECogSDhkVfyt7qme5DLh); the events across environments, `envs` (session_011eECofYWTNPACTtUjHN4p6); Lessmilk is `ray-lessmilk` (session_011eECohyasjWkvCHdxGxJ6D).

Last update: 2026-11-18.

## A. Decisions waiting for an answer

Each has the option recommended by this session.

| # | Decision | Recommended |
|---|----------|-------------|
| #1 | The remotes: this repository is now `ia-atmos/env-ray`, the compiler `ia-atmos/lang` (the old addresses redirect; the names in `README.md`, `doc/compiler.md`, `tools/setup.sh` are updated). The remote of this checkout and of `ext/ceu-atmos` still name the old addresses: changing a remote is refused by the permissions of this session (auto mode) | The author allows it, or runs `git remote set-url origin https://github.com/ia-atmos/env-ray` and `git -C ext/ceu-atmos remote set-url origin https://github.com/ia-atmos/lang`. Not urgent: pushes still go through |
| #29 | The compiler now has `set :out place = value` (lang 8361f88): a place outside refers to a pinned value of the current block, and goes back to `nil` when the block ends. It fits what the first migration had to rewrite in four games (cat_vs_roomba, skully_escape, light_my_ritual, wave_collector): the top-level trace read the state of a screen through a global, and now reads a string that the screen writes as it draws | Go back to `set :out game = g` in the four games, with the 55 runs identical, after moving the compiler to 8361f88. Small; waiting for the author |
| #5 | The original of koala_seasons reads the date (`time`), so its runs are not repeatable; the test mode fixes it, by a patch of the original (`tools/original.patch`) and the same in the port | Keep it, as written in `doc/fidelity.md` |
| #21 | Lessmilk (`ia-atmos/ray-lessmilk`) has no patch of its own to merge: its binding is `raylib.atm` of 4360cb2 with `pin rl`, and its test patch is ours. It stays on compiler f3389f6 and binding 4360cb2 until a case of pin is settled by the compiler session (16 of its 33 runs fail on 1746969), then it moves to `ray.atm`, `atmos-ray` and the vocabulary of events at once | Nothing to do here; Lessmilk will tell |

## B. Work known and not done

| # | Work | Note |
|---|------|------|
| #6 | Paths that no run covers, ported but not compared: koala_seasons (the final form, the eagle, summer and winter in play, fire, ice, gestures); retro_maze_3d (time and stamina running out: 18000 and 10000 frames); pang (the victory); light_my_ritual (the win by light); cat_vs_roomba (the win); tetris (the clear of lines, which the C never does); missile_commander (the 101st missile, the 100 explosions); cat_vs_roomba (a second game) | Each is in `doc/fidelity.md`. A better generator could reach some: the autopilot of koala, the route of light_my_ritual |
| #7 | `ASAN=1 tst/run.sh`, the suite with the address sanitizer, not run on the games ported last (R4 to R6) | One run, about an hour |
| #8 | `tools/compare-all.sh`, every run against the original, run only on snake | One run of all, a few hours |
| #9 | A stress case of `raylife` | Not made: its board is C in the port too |
| #10 | The CPU at 60 fps in `doc/bench.md` is derived from the CPU per frame, not measured apart | Measure it with the frame cap, if it matters |
| #24 | Relax the exactness in favor of expressiveness, keeping the intent of the original author (agreed by the author, 2026-11-16). Candidates: the flags kept only to match the C frame by frame (38 control variables left, `doc/state.md`), the globals never reset, the 32-bit rounding (`ray.f32`), the order of the random draws, the init of the next screen under the old one; and the lists emptied with `vector.clear` | Started. Done: no list is emptied any more (the state of a game is made in each game: snake, gorilas, missile_commander relaxed; space_invaders and transmission still identical); the slots of missile_commander are pools. One small commit per relaxation, with its stored results replaced, and the deliberate differences in "Relaxed ports" of `doc/fidelity.md`. Next: the other classics (the globals never reset, the flags of the frame), then the 32-bit rounding and the order of the random draws |
| #26 | The tag `faithful` (e0b6a01, the last version identical on all runs) exists only in the local checkout of this session: a session cannot create tags (the git proxy refuses the push) | The author creates it on GitHub at e0b6a01 |
| #22 | `tools/raylib.patch` names the repository by its old name in a comment that it adds to raylib (`fsantanna/raylib`) | Change it with the next change of the patch: editing it alone means rebuilding raylib for a comment |
| #11 | Differences that no run shows, kept as documented: snake (two keys in one frame), gold_fever (ENTER in the frame of the last coin), skully_escape (a door taken during the 80 frames of a death) | See `doc/fidelity.md` |

## C. Reported and not acknowledged

| # | Report |
|---|--------|
| #12 | The summary and conclusions of the port (all 23 games, identical on 55 runs; 96 of 134 control variables become structure, 38 stay; CPU 1.02 times the C; 1.4 against 0.75 µs per enemy in the stress) |
| #13 | The last full regression: 57 checks, none failed (2026-11-18, compiler 8c9453c) |
| #14 | The logo of `games/screens.atm` showed "raylib" whole for 12 frames before its first letter; fixed (TextSubtext, as the C) |
| #15 | `raylib.atm` (now `ray.atm`) grew: `rl.poly`, shaders, gestures, the touch position; `Screens` keeps its state in its `pub`. Lessmilk was told |
| #16 | The original of transmission aborts (`free` of a static buffer of raylib 6.2) on a wrong word; no run can use one |
| #17 | The pitfalls of the compiler found by the ports, in `doc/compiler.md` (`test` and `catch` are keywords, `%` is `fmod`, indexing a literal, `await` of an expression, `pin` in a table, a local that hides a parameter) |
| #18 | The new documents: `doc/case-study.md`, `doc/bench.md`, `launcher.atm`, `tools/compare-all.sh` |

## D. Older

| # | Item |
|---|------|
| #19 | The plan said the assets would not be copied; the author chose to copy them into the repository (done). Their license is the one of each game's README (`README.original.md`); koala_seasons and others credit artists whose terms are not stated beyond the zlib license of the code |
