# The games, one row each

- **Lines** and **tokens**: of code, counted by `tools/count.py` (no blank
  lines, no comments; in C, no blocks for the web or Android; in Atmos, no
  trace). The C is the original, before `tools/original.patch`. A port
  counts the files it includes, such as `classics/classic.atm` (the frame
  that the classics share), as if they were inlined; not `ray.atm`.
- **Control**: the variables of the C that only control the flow (counters
  of frames, flags of phases, screens), and how many are left in the port.
  The list is in [state.md](state.md).
- **Runs**: scripted runs, and whether the port is the same as the original
  on all of their trace lines and screens ([fidelity.md](fidelity.md));
  "relaxed": the same up to the branch `faithful`, and then changed on
  purpose, as listed in "Relaxed ports" of fidelity.md.
- **Memory** and **CPU**: in [bench.md](bench.md), once measured.

The rows are written by `tools/table.py`, from the sources, `state.md`, and
the runs: no number here is typed by hand.

| Game | Lines C | Lines Atmos | Tokens C | Tokens Atmos | Control C | Control left | Runs | Same |
|------|--------:|------------:|---------:|-------------:|----------:|-------------:|-----:|------|
| snake | 181 | 123 | 1509 | 960 | 5 | 0 | 2 (1220 frames, 16 screens) | relaxed |
| floppy | 143 | 119 | 1054 | 701 | 4 | 0 | 2 (2746 frames, 25 screens) | yes |
| gold_fever | 178 | 164 | 1470 | 1241 | 6 | 1 | 2 (1369 frames, 27 screens) | relaxed |
| arkanoid | 207 | 148 | 2005 | 1289 | 4 | 0 | 2 (19504 frames, 22 screens) | relaxed |
| asteroids_survival | 241 | 180 | 2262 | 1366 | 3 | 0 | 2 (4531 frames, 22 screens) | relaxed |
| space_invaders | 271 | 197 | 1903 | 1273 | 9 | 1 | 2 (5477 frames, 26 screens) | relaxed |
| missile_commander | 343 | 161 | 2796 | 1389 | 10 | 1 | 2 (6812 frames, 34 screens) | relaxed |
| gorilas | 351 | 173 | 2994 | 1560 | 6 | 0 | 2 (1008 frames, 44 screens) | relaxed |
| asteroids | 402 | 260 | 3940 | 2038 | 7 | 1 | 2 (1249 frames, 25 screens) | relaxed |
| pang | 446 | 208 | 4072 | 1719 | 8 | 2 | 2 (2998 frames, 38 screens) | yes |
| platformer | 466 | 177 | 3277 | 1702 | 4 | 0 | 2 (1634 frames, 43 screens) | relaxed |
| tetris | 577 | 340 | 4370 | 2904 | 11 | 2 | 2 (10000 frames, 26 screens) | relaxed |
| raylife | 196 | 179 | 1506 | 1354 | 1 | 1 | 2 (1400 frames, 33 screens) | relaxed |
| wave_collector | 679 | 273 | 4998 | 2181 | 7 | 1 | 3 (13723 frames, 46 screens) | relaxed |
| repair | 672 | 384 | 5601 | 3782 | 5 | 1 | 2 (3350 frames, 45 screens) | relaxed |
| cat_vs_roomba | 857 | 333 | 7312 | 3478 | 5 | 1 | 2 (13420 frames, 31 screens) | relaxed |
| light_my_ritual | 901 | 280 | 7087 | 2390 | 5 | 2 | 2 (8700 frames, 34 screens) | relaxed |
| transmission | 1125 | 651 | 6898 | 5424 | 6 | 3 | 2 (7036 frames, 37 screens) | relaxed |
| drturtle | 293 | 222 | 2416 | 1859 | 4 | 1 | 2 (3700 frames, 17 screens) | relaxed |
| just_do | 1454 | 705 | 9350 | 6454 | 5 | 4 | 2 (4801 frames, 47 screens) | relaxed |
| skully_escape | 2685 | 403 | 18429 | 4038 | 6 | 3 | 3 (11514 frames, 60 screens) | relaxed |
| retro_maze_3d | 497 | 434 | 4185 | 3331 | 5 | 4 | 3 (7092 frames, 58 screens) | relaxed |
| koala_seasons | 4689 | 2764 | 46792 | 32043 | 8 | 6 | 8 (8854 frames, 62 screens) | relaxed |
