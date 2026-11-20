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
| snake | 181 | 123 | 1509 | 958 | 5 | 0 | 2 (1220 frames, 16 screens) | relaxed |
| floppy | 143 | 119 | 1054 | 699 | 4 | 0 | 2 (2746 frames, 25 screens) | yes |
| gold_fever | 178 | 164 | 1470 | 1239 | 6 | 1 | 2 (1369 frames, 27 screens) | relaxed |
| arkanoid | 207 | 149 | 2005 | 1312 | 4 | 0 | 2 (22977 frames, 23 screens) | yes |
| asteroids_survival | 241 | 181 | 2262 | 1470 | 3 | 0 | 2 (4531 frames, 22 screens) | yes |
| space_invaders | 271 | 198 | 1903 | 1297 | 9 | 1 | 2 (5477 frames, 26 screens) | relaxed |
| missile_commander | 343 | 162 | 2796 | 1443 | 10 | 1 | 2 (6812 frames, 34 screens) | relaxed |
| gorilas | 351 | 174 | 2994 | 1627 | 6 | 0 | 2 (1008 frames, 44 screens) | relaxed |
| asteroids | 402 | 261 | 3940 | 2176 | 7 | 1 | 2 (1249 frames, 25 screens) | yes |
| pang | 446 | 209 | 4072 | 1791 | 8 | 2 | 2 (2998 frames, 38 screens) | yes |
| platformer | 466 | 169 | 3277 | 1770 | 4 | 0 | 2 (1634 frames, 43 screens) | relaxed |
| tetris | 577 | 340 | 4370 | 2902 | 11 | 2 | 2 (10000 frames, 26 screens) | relaxed |
| raylife | 196 | 180 | 1506 | 1411 | 1 | 1 | 2 (1400 frames, 33 screens) | yes |
| wave_collector | 679 | 273 | 4998 | 2247 | 7 | 1 | 3 (13723 frames, 46 screens) | yes |
| repair | 672 | 384 | 5601 | 3847 | 5 | 1 | 2 (3350 frames, 45 screens) | yes |
| cat_vs_roomba | 857 | 335 | 7312 | 3563 | 5 | 1 | 2 (13420 frames, 31 screens) | yes |
| light_my_ritual | 901 | 281 | 7087 | 2455 | 5 | 2 | 2 (8700 frames, 34 screens) | relaxed |
| transmission | 1125 | 652 | 6898 | 5579 | 6 | 3 | 2 (7036 frames, 37 screens) | yes |
| drturtle | 293 | 221 | 2416 | 1884 | 4 | 1 | 2 (3700 frames, 17 screens) | yes |
| just_do | 1454 | 706 | 9350 | 6535 | 5 | 4 | 2 (4801 frames, 47 screens) | yes |
| skully_escape | 2685 | 402 | 18429 | 4061 | 6 | 3 | 3 (11514 frames, 60 screens) | yes |
| retro_maze_3d | 497 | 432 | 4185 | 3331 | 5 | 4 | 3 (7092 frames, 58 screens) | yes |
| koala_seasons | 4689 | 2765 | 46792 | 33100 | 8 | 6 | 8 (8854 frames, 62 screens) | yes |
