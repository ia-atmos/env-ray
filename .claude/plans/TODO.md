# TODO

Everything that is pending in the session that ports the raylib games to
Atmos (`ia-atmos/env-ray`): asked and not decided, reported and not
acknowledged, or known and not done. Keep it current: remove an item when
it is settled, add one whenever something is left open, in the same commit
when possible.

The numbers do not change. Numbers that are missing were settled.

Last update: 2026-11-16.

## A. Decisions waiting for an answer

Each has the option recommended by this session.

| # | Decision | Recommended |
|---|----------|-------------|
| 1 | The remotes: this repository is now `ia-atmos/env-ray`, the compiler `ia-atmos/lang` (the old addresses redirect; the names in `README.md`, `doc/compiler.md`, `tools/setup.sh` are updated). The remote of this checkout and of `ext/ceu-atmos` still name the old addresses: changing a remote is refused by the permissions of this session (auto mode) | The author allows it, or runs `git remote set-url origin https://github.com/ia-atmos/env-ray` and `git -C ext/ceu-atmos remote set-url origin https://github.com/ia-atmos/lang`. Not urgent: pushes still go through |
| 5 | The original of koala_seasons reads the date (`time`), so its runs are not repeatable; the test mode fixes it, by a patch of the original (`tools/original.patch`) and the same in the port | Keep it, as written in `doc/fidelity.md` |
| 21 | Lessmilk (`ia-atmos/ray-lessmilk`) carries a patched copy of the binding (item 47 of the compiler), now `ray.atm` with the table `ray` and the events with no prefix | Merge its patch into `ray.atm` here, so it can use the file as it is |

## B. Work known and not done

| # | Work | Note |
|---|------|------|
| 6 | Paths that no run covers, ported but not compared: koala_seasons (the final form, the eagle, summer and winter in play, fire, ice, gestures); retro_maze_3d (time and stamina running out: 18000 and 10000 frames); pang (the victory); light_my_ritual (the win by light); cat_vs_roomba (the win); tetris (the clear of lines, which the C never does); missile_commander (the 101st missile, the 100 explosions); cat_vs_roomba (a second game) | Each is in `doc/fidelity.md`. A better generator could reach some: the autopilot of koala, the route of light_my_ritual |
| 7 | `ASAN=1 tst/run.sh`, the suite with the address sanitizer, not run on the games ported last (R4 to R6) | One run, about an hour |
| 8 | `tools/compare-all.sh`, every run against the original, run only on snake | One run of all, a few hours |
| 9 | A stress case of `raylife` | Not made: its board is C in the port too |
| 10 | The CPU at 60 fps in `doc/bench.md` is derived from the CPU per frame, not measured apart | Measure it with the frame cap, if it matters |
| 24 | Relax the exactness in favor of expressiveness, keeping the intent of the original author (agreed by the author, 2026-11-16). Candidates: the flags kept only to match the C frame by frame (38 control variables left, `doc/state.md`), the globals never reset, the 32-bit rounding (`ray.f32`), the order of the random draws, the init of the next screen under the old one; and the lists emptied with `vector.clear` (rebuilt instead, once the traces no longer read them from the top level) | The tag `faithful` marks the last identical version. One small commit per relaxation, with its stored results replaced, and the deliberate differences listed in `doc/fidelity.md`. The classics first |
| 22 | `tools/raylib.patch` names the repository by its old name in a comment that it adds to raylib (`fsantanna/raylib`) | Change it with the next change of the patch: editing it alone means rebuilding raylib for a comment |
| 25 | A compiler of its own for this environment, `atmos-ray` (a wish of the author for every environment, relayed by the compiler session): `make -C <lang> env OUT=<dir>/atmos-ray ENV=<dir>/ray.atm ENV_CFLAGS="-I..." ENV_LDFLAGS="<dir>/.../libraylib.a -lm ..."` (absolute paths, no quotes; manual of `ia-atmos/lang`, "Environments"). It includes `ray.atm` before every program; a program with the `include` still works. Then `tools/setup.sh` builds it, `tools/atmos.sh`, `tools/ports.sh`, the tests, the examples and the docs use it, and the games drop their `include` of `ray.atm` | Next, now that the events have no prefix (`ray.atm`, 2026-11-16): after a pull and `make` of the compiler; the 55 runs again after. The compiler then has `skip` (a statement, reserved as a name: only a comment uses the word here) and refuses a `spawn` that dies with its block (`invalid spawn`): the compiler session says none fires here; to confirm by building all ports with it |
| 11 | Differences that no run shows, kept as documented: snake (two keys in one frame), gold_fever (ENTER in the frame of the last coin), skully_escape (a door taken during the 80 frames of a death) | See `doc/fidelity.md` |

## C. Reported and not acknowledged

| # | Report |
|---|--------|
| 12 | The summary and conclusions of the port (all 23 games, identical on 55 runs; 96 of 134 control variables become structure, 38 stay; CPU 1.02 times the C; 1.4 against 0.75 µs per enemy in the stress) |
| 13 | The last full regression: 57 checks, none failed (2026-11-12) |
| 14 | The logo of `games/screens.atm` showed "raylib" whole for 12 frames before its first letter; fixed (TextSubtext, as the C) |
| 15 | `raylib.atm` (now `ray.atm`) grew: `rl.poly`, shaders, gestures, the touch position; `Screens` keeps its state in its `pub`. Lessmilk was told |
| 16 | The original of transmission aborts (`free` of a static buffer of raylib 6.2) on a wrong word; no run can use one |
| 17 | The pitfalls of the compiler found by the ports, in `doc/compiler.md` (`test` and `catch` are keywords, `%` is `fmod`, indexing a literal, `await` of an expression, `pin` in a table, a local that hides a parameter) |
| 18 | The new documents: `doc/case-study.md`, `doc/bench.md`, `launcher.atm`, `tools/compare-all.sh` |

## D. Older

| # | Item |
|---|------|
| 19 | The plan said the assets would not be copied; the author chose to copy them into the repository (done). Their license is the one of each game's README (`README.original.md`); koala_seasons and others credit artists whose terms are not stated beyond the zlib license of the code |
